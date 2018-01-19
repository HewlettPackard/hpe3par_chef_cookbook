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

action :create_online do
# validations
  fail ArgumentError, 'Attribute storage_system is required for volume clone creation' unless new_resource.storage_system
  fail ArgumentError, 'Attribute volume_name is required for volume clone creation' unless new_resource.base_volume_name
  fail ArgumentError, 'Attribute clone_name is required for volume clone creation' unless new_resource.clone_name
  if !volume_exists?(new_resource.storage_system, new_resource.clone_name, new_resource.debug)
    converge_by("Create online clone #{new_resource.clone_name} of volume #{new_resource.base_volume_name}") do
      create_online_clone(new_resource.storage_system, new_resource.base_volume_name, new_resource.clone_name,
                          new_resource.dest_cpg, true, new_resource.tpvv, new_resource.tdvv, new_resource.snap_cpg,
                          new_resource.compression, new_resource.debug)
    end
  else
    Chef::Log.info("Clone #{new_resource.clone_name} already exists / creation in progress. Nothing to do.")
  end  
end

action :create_offline do
# validations
  fail ArgumentError, 'Attribute storage_system is required for volume clone creation' unless new_resource.storage_system
  fail ArgumentError, 'Attribute volume_name is required for volume clone creation' unless new_resource.base_volume_name
  fail ArgumentError, 'Attribute clone_name is required for volume clone creation' unless new_resource.clone_name
  if volume_exists?(new_resource.storage_system, new_resource.clone_name, new_resource.debug) and
    !online_physical_copy_exists?(new_resource.storage_system, new_resource.base_volume_name, new_resource.clone_name, new_resource.debug) and
    !offline_physical_copy_exists?(new_resource.storage_system, new_resource.base_volume_name, new_resource.clone_name, new_resource.debug)
      converge_by("Create offline clone #{new_resource.clone_name} of volume #{new_resource.base_volume_name}") do
        create_offline_clone(new_resource.storage_system, new_resource.base_volume_name, new_resource.clone_name, 
                             new_resource.dest_cpg, false, new_resource.save_snapshot, new_resource.priority,
                             new_resource.skip_zero, new_resource.debug)
      end
  else
    Chef::Log.info("Clone #{new_resource.clone_name} already exists / creation in progress. Nothing to do.")
  end  
end

action :resync do
# validations
  fail ArgumentError, 'Attribute storage_system is required for volume clone resync' unless new_resource.storage_system
  fail ArgumentError, 'Attribute clone_name is required for volume clone resync' unless new_resource.clone_name
  converge_by("Resync clone #{new_resource.clone_name}") do
    resync_clone(new_resource.storage_system, new_resource.clone_name, new_resource.debug)
  end
end

action :stop do
# validations
  fail ArgumentError, 'Attribute storage_system is required for volume clone stop' unless new_resource.storage_system
  fail ArgumentError, 'Attribute clone_name is required for volume clone stop' unless new_resource.clone_name
  fail ArgumentError, 'Attribute volume_name is required for volume clone stop' unless new_resource.base_volume_name
  if volume_exists?(new_resource.storage_system, new_resource.clone_name, new_resource.debug) and
     offline_physical_copy_exists?(new_resource.storage_system, new_resource.base_volume_name, new_resource.clone_name)
    converge_by("Stop cloning into #{new_resource.clone_name}") do
      stop_clone(new_resource.storage_system, new_resource.clone_name, new_resource.debug)
    end
  else
    Chef::Log.info("Clone #{new_resource.clone_name} does not exists / creation in progress. Nothing to do.")
  end  
end

action :delete do
# validations
  fail ArgumentError, 'Attribute storage_system is required for volume clone delete' unless new_resource.storage_system
  fail ArgumentError, 'Attribute clone_name is required for volume clone delete' unless new_resource.clone_name
  fail ArgumentError, 'Attribute base_volume_name is required for volume clone delete' unless new_resource.base_volume_name
  if volume_exists?(new_resource.storage_system, new_resource.clone_name, new_resource.debug) and
    !online_physical_copy_exists?(new_resource.storage_system, new_resource.base_volume_name, new_resource.clone_name, new_resource.debug) and
    !offline_physical_copy_exists?(new_resource.storage_system, new_resource.base_volume_name, new_resource.clone_name, new_resource.debug)
    converge_by("Delete clone #{new_resource.clone_name}") do
      delete_clone(new_resource.storage_system, new_resource.clone_name, new_resource.debug)
    end
  else
    Chef::Log.info("Clone #{new_resource.clone_name} does not exists / creation in progress. Nothing to do.")
  end  
end
