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
  fail ArgumentError, 'Attribute storage_system is required for volume snapshot creation' unless new_resource.storage_system
  fail ArgumentError, 'Attribute name is required for volume snapshot creation' unless new_resource.snapshot_name
  fail ArgumentError, 'Attribute parent_volume_name is required for volume snapshot creation' unless new_resource.base_volume_name
  if !volume_exists?(new_resource.storage_system, new_resource.snapshot_name, new_resource.debug)
    converge_by("Create Snapshot #{new_resource.snapshot_name} from #{new_resource.base_volume_name}") do
      create_snapshot(new_resource.storage_system, new_resource.snapshot_name, new_resource.base_volume_name, 
      new_resource.read_only, new_resource.expiration_time, new_resource.retention_time, new_resource.expiration_unit,
                      new_resource.retention_unit, new_resource.debug)
    end
  else
    Chef::Log.info("Host #{new_resource.snapshot_name} already exists. Nothing to do.")
  end
end

action :delete do
# validations
  fail ArgumentError, 'Attribute storage_system is required for volume snapshot deletion' unless new_resource.storage_system
  fail ArgumentError, 'Attribute name is required for volume snapshot deletion' unless new_resource.snapshot_name
  if volume_exists?(new_resource.storage_system, new_resource.snapshot_name, new_resource.debug)
    converge_by("Delete Snapshot #{new_resource.snapshot_name}") do
      delete_snapshot(new_resource.storage_system, new_resource.snapshot_name, new_resource.debug)
    end
  else
    Chef::Log.info("Host #{new_resource.snapshot_name} does not exists. Nothing to do.")
  end
end

action :modify do
  # validations
  fail ArgumentError, 'Attribute storage_system is required for volume snapshot modification' unless new_resource.storage_system
  fail ArgumentError, 'Attribute name is required for volume snapshot modification' unless new_resource.snapshot_name
  converge_by("Modify Snapshot #{new_resource.snapshot_name}") do
    modify_snapshot(new_resource.storage_system, new_resource.snapshot_name, new_resource.new_name,
    new_resource.expiration_hours, new_resource.retention_hours, new_resource.rm_exp_time, new_resource.debug)
  end
end

action :restore_offline do
  # validations
  fail ArgumentError, 'Attribute storage_system is required for offline volume snapshot restore' unless new_resource.storage_system
  fail ArgumentError, 'Attribute name is required for offline volume snapshot restore' unless new_resource.snapshot_name
  converge_by("Restore Snapshot #{new_resource.snapshot_name} offline") do
    restore_offline_snapshot(new_resource.storage_system, new_resource.snapshot_name, new_resource.priority,
                             new_resource.allow_remote_copy_parent, new_resource.debug)
  end
end

action :restore_online do
  # validations
  fail ArgumentError, 'Attribute storage_system is required for online volume snapshot restore' unless new_resource.storage_system
  fail ArgumentError, 'Attribute name is required for online volume snapshot restore' unless new_resource.snapshot_name
  converge_by("Restore Snapshot #{new_resource.snapshot_name} online") do
    restore_online_snapshot(new_resource.storage_system, new_resource.snapshot_name,
                            new_resource.allow_remote_copy_parent, new_resource.debug)
  end
end

