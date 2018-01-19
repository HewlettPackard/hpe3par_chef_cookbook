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
  fail ArgumentError, 'Attribute storage_system is required for volume set creation' unless new_resource.storage_system
  fail ArgumentError, 'Attribute name is required for volume set creation' unless new_resource.name
  
  if !volume_set_exists?(new_resource.storage_system, new_resource.name, new_resource.debug)
    converge_by("Create volume set #{new_resource.name}") do
      create_volume_set(new_resource.storage_system, new_resource.name,
                        new_resource.domain, new_resource.setmembers, new_resource.debug)
      Chef::Log.info("Created volume set #{new_resource.name}.")
    end
  else
    Chef::Log.info("Volume set #{new_resource.name} already exists. Nothing to do.")
  end
end

action :delete do
# validations
  fail ArgumentError, 'Attribute storage_system is required for  volume set deletion' unless new_resource.storage_system
  fail ArgumentError, 'Attribute name is required for volume set deletion' unless new_resource.name
  
  if volume_set_exists?(new_resource.storage_system, new_resource.name, new_resource.debug)
    converge_by("Delete volume set #{new_resource.name}") do
      delete_volume_set(new_resource.storage_system, new_resource.name, new_resource.debug)
    end
  else
    Chef::Log.info("Volume set #{new_resource.name} does not exist. Nothing to do.")
  end
end

action :add_volume do
# validations
  fail ArgumentError, 'Attribute storage_system is required to add volume to volume set' unless new_resource.storage_system
  fail ArgumentError, 'Attribute name is required to add volume to volume set' unless new_resource.name
  fail ArgumentError, 'Attribute setmembers is required to add volumes to volume set' unless new_resource.setmembers
  set_members = get_volume_set(new_resource.storage_system, new_resource.name, new_resource.debug).setmembers
  if !set_members.nil?
    new_set_members = new_resource.setmembers - set_members
  else
    new_set_members = new_resource.setmembers
  end
  if !new_set_members.nil? and new_set_members.any?
    converge_by("Add volumes #{new_resource.setmembers} to volume set #{new_resource.name}") do
      add_volumes_to_volume_set(new_resource.storage_system, new_resource.name, new_set_members, new_resource.debug)
    end
  else
    Chef::Log.info("No new members to add to the Volume set #{new_resource.name}. Nothing to do.")
  end
end

action :remove_volume do
# validations
  fail ArgumentError, 'Attribute storage_system is required to remove volume from volume set' unless new_resource.storage_system
  fail ArgumentError, 'Attribute name is required to remove volume from volume set' unless new_resource.name
  fail ArgumentError, 'Attribute setmembers is required to remove volumes from volume set' unless new_resource.setmembers
  set_members = get_volume_set(new_resource.storage_system, new_resource.name, new_resource.debug).setmembers
  if set_members != nil
    common_set_members = set_members & new_resource.setmembers
    if !common_set_members.nil? and common_set_members.any?
      converge_by("Remove volumes #{new_resource.setmembers} from volume set #{new_resource.name}") do
        remove_volumes_from_volume_set(new_resource.storage_system, new_resource.name,
                                       common_set_members, new_resource.debug)
      end
    else
      Chef::Log.info("No members to remove from the Volume set #{new_resource.name}. Nothing to do.")
    end
  else
    Chef::Log.info("No members to remove from the Volume set #{new_resource.name}. Nothing to do.")
  end
end
