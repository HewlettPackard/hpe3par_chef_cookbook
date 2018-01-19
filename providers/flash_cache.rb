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
  fail ArgumentError, 'Attribute storage_system is required for flash cache creation' unless new_resource.storage_system
  fail ArgumentError, 'Attribute size_in_gib is required for flash cache creation' unless new_resource.size_in_gib
  if !flash_cache_exists?(new_resource.storage_system, new_resource.debug)
    converge_by("Create Flash Cache") do
      create_flash_cache(new_resource.storage_system, new_resource.size_in_gib, new_resource.mode, new_resource.debug)
    end
  else
    Chef::Log.info('Flash Cache already exists. Nothing to do.')
  end
end

action :delete do
# validations
  fail ArgumentError, 'Attribute storage_system is required for flash cache deletion' unless new_resource.storage_system
  if flash_cache_exists?(new_resource.storage_system, new_resource.debug)
    converge_by("Delete Flash Cache") do
      delete_flash_cache(new_resource.storage_system, new_resource.debug)
    end
  else
    Chef::Log.info('Flash Cache does not exist. Nothing to do.')
  end
end
