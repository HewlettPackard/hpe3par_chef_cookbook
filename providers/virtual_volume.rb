# (c) Copyright 2016-2017 Hewlett Packard Enterprise Development LP
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software distributed
# under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
# CONDITIONS OF ANY KIND, either express or implied. See the License for the
# specific language governing permissions and limitations under the License.

include HPE3PAR::RestHelper
use_inline_resources

action :create do
# validations
  fail ArgumentError, 'Attribute storage_system is required for volume creation' unless new_resource.storage_system
  fail ArgumentError, 'Attribute name is required for volume creation' unless new_resource.name
  fail ArgumentError, 'Attribute cpg is required for volume creation' unless new_resource.cpg
  fail ArgumentError, 'Attribute size is required for volume creation' unless new_resource.size
  fail ArgumentError, 'Attribute size_unit is required for volume creation' unless new_resource.size_unit

  if !volume_exists?(new_resource.storage_system, new_resource.name, new_resource.debug)
    converge_by("Creating volume #{new_resource.name}") do
      create_volume(new_resource.storage_system, new_resource.name, new_resource.cpg,
                              new_resource.size, new_resource.size_unit, new_resource.type,
                              new_resource.compression, new_resource.snap_cpg, new_resource.debug)
    end
  else
    Chef::Log.info("Volume #{new_resource.name} already exists. Nothing to do.")
  end
end

action :delete do
# validations
  fail ArgumentError, 'Attribute storage_system is required for volume deletion' unless new_resource.storage_system
  fail ArgumentError, 'Attribute name is required for volume deletion' unless new_resource.name
  
  if volume_exists?(new_resource.storage_system, new_resource.name, new_resource.debug)
    converge_by("Deleting volume #{new_resource.name}") do
      delete_volume(new_resource.storage_system, new_resource.name, new_resource.debug)
    end
  else
    Chef::Log.info("Volume #{new_resource.name} does not exist. Nothing to do.")
  end
end

action :grow do
# validations
  fail ArgumentError, 'Attribute storage_system is required for volume grow' unless new_resource.storage_system
  fail ArgumentError, 'Attribute name is required for volume grow' unless new_resource.name
  fail ArgumentError, 'Attribute size is required for volume grow' unless new_resource.size
  fail ArgumentError, 'Attribute size_unit is required for volume grow' unless new_resource.size_unit
  converge_by("Grow volume #{new_resource.name} by #{new_resource.size} #{new_resource.size_unit}") do
    grow_volume(new_resource.storage_system, new_resource.name, new_resource.size, new_resource.size_unit, new_resource.debug)
  end
end

action :grow_to_size do
# validations
  fail ArgumentError, 'Attribute storage_system is required for volume grow to size' unless new_resource.storage_system
  fail ArgumentError, 'Attribute name is required for volume grow to size' unless new_resource.name
  fail ArgumentError, 'Attribute size is required for volume grow to size' unless new_resource.size
  fail ArgumentError, 'Attribute size_unit is required for volume grow to size' unless new_resource.size_unit

  if volume_exists?(new_resource.storage_system, new_resource.name, new_resource.debug) and
      get_volume(new_resource.storage_system, new_resource.name, new_resource.debug).size_mib < convert_to_binary_multiple(new_resource.size, new_resource.size_unit)
    converge_by("Growing volume #{new_resource.name} to size: #{new_resource.size} #{new_resource.size_unit}") do
      grow_volume(new_resource.storage_system, new_resource.name,
                  convert_to_binary_multiple(new_resource.size, new_resource.size_unit) - get_volume(new_resource.storage_system, new_resource.name).size_mib,
                  'MiB', new_resource.debug)
    end
  else
    Chef::Log.info("Volume #{new_resource.name} is already equal or the new size is less than the existing size of the volume. Nothing to do.")
  end
end

action :change_snap_cpg do
# validations
  fail ArgumentError,
       'Attribute storage_system is required for changing the snap cpg of a volume' unless new_resource.storage_system
  fail ArgumentError,
       'Attribute name is required for changing the snap cpg of a volume' unless new_resource.name
  fail ArgumentError,
       'Attribute snap_cpg is required for changing the snap cpg of a volume' unless new_resource.snap_cpg
  if volume_exists?(new_resource.storage_system, new_resource.name, new_resource.debug) and get_volume(new_resource.storage_system, new_resource.name, new_resource.debug).snap_cpg != new_resource.snap_cpg
    converge_by("Change Snap CPG of volume #{new_resource.name} to CPG: #{new_resource.snap_cpg}") do
      change_snap_cpg(new_resource.storage_system, new_resource.name,
                      new_resource.snap_cpg, new_resource.wait_for_task_to_end, new_resource.debug)
    end
  else
    Chef::Log.info("Volume snap CPG #{new_resource.snap_cpg} is already set")
  end
end

action :change_user_cpg do
# validations
  fail ArgumentError,
       'Attribute storage_system is required for changing the user cpg of a volume' unless new_resource.storage_system
  fail ArgumentError,
       'Attribute name is required for changing the user cpg of a volume' unless new_resource.name
  fail ArgumentError,
       'Attribute snap_cpg is required for changing the user cpg of a volume' unless new_resource.cpg
  if volume_exists?(new_resource.storage_system, new_resource.name, new_resource.debug) and
      get_volume(new_resource.storage_system, new_resource.name, new_resource.debug).user_cpg != new_resource.cpg
    converge_by("Change User CPG of volume #{new_resource.name} to CPG: #{new_resource.cpg}") do
      change_user_cpg(new_resource.storage_system, new_resource.name,
                    new_resource.cpg, new_resource.wait_for_task_to_end, new_resource.debug)
    end
  else
    Chef::Log.info("Volume user CPG #{new_resource.cpg} is already set")
  end
end

action :convert_type do
# validations
  fail ArgumentError,
       'Attribute storage_system is required for changing the type of a volume' unless new_resource.storage_system
  fail ArgumentError,
       'Attribute name is required for changing the type of a volume' unless new_resource.name
  fail ArgumentError,
       'Attribute type is required for changing the type of a volume' unless new_resource.type
  fail ArgumentError,
       'Attribute cpg is required for changing the type of a volume' unless new_resource.cpg
  
  provisioning_type = get_volume(new_resource.storage_system, new_resource.name, new_resource.debug).provisioning_type
  if provisioning_type == 1
    volume_type = 'FPVV'
  elsif provisioning_type == 2
    volume_type = 'TPVV'
  elsif provisioning_type == 6
    volume_type = 'TDVV'
  else
    volume_type = 'UNKNOWN'
  end


  if volume_exists?(new_resource.storage_system, new_resource.name, new_resource.debug) and
      (volume_type != get_volume_type(new_resource.type) or volume_type == 'UNKNOWN')
    converge_by("Convert type of volume #{new_resource.name} to type: #{new_resource.type}") do
      convert_volume_type(new_resource.storage_system, new_resource.name, new_resource.cpg,
                          new_resource.type, new_resource.keep_vv, new_resource.compression,
                          new_resource.wait_for_task_to_end, new_resource.debug)
    end
  else
    Chef::Log.info("Volume provisioning type #{new_resource.type} is already set")
  end
end

action :modify do
# validations
  fail ArgumentError,
       'Attribute storage_system is required' unless new_resource.storage_system
  fail ArgumentError,
       'Attribute name is required' unless new_resource.name
  converge_by("Modify volume #{new_resource.name}") do
    modify_base_volume(new_resource.storage_system, new_resource.name,
                                 new_resource.new_name,
                                 new_resource.expiration_hours,
                                 new_resource.retention_hours,
                                 new_resource.ss_spc_alloc_warning_pct,
                                 new_resource.ss_spc_alloc_limit_pct,
                                 new_resource.usr_spc_alloc_warning_pct,
                                 new_resource.usr_spc_alloc_limit_pct,
                                 new_resource.rm_ss_spc_alloc_warning,
                                 new_resource.rm_usr_spc_alloc_warning,
                                 new_resource.rm_exp_time,
                                 new_resource.rm_usr_spc_alloc_limit,
                                 new_resource.rm_ss_spc_alloc_limit,
                                 new_resource.debug)
  end
end

action :set_snap_cpg do
# validations
  fail ArgumentError,
       'Attribute storage_system is required' unless new_resource.storage_system
  fail ArgumentError,
       'Attribute name is required' unless new_resource.name
  fail ArgumentError,
       'Attribute snap_cpg is required' unless new_resource.snap_cpg
  if volume_exists?(new_resource.storage_system, new_resource.name, new_resource.debug) and
      get_volume(new_resource.storage_system, new_resource.name, new_resource.debug).snap_cpg != new_resource.snap_cpg
    converge_by("Set snap CPG on volume #{new_resource.name} as #{new_resource.snap_cpg}") do
      set_snap_cpg(new_resource.storage_system, new_resource.name, new_resource.snap_cpg, new_resource.debug)
    end
  else
    Chef::Log.info("Volume snap CPG #{new_resource.snap_cpg} is already set")
  end
end
