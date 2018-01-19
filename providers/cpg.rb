
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
  fail ArgumentError, 'Attribute cpg name is required for cpg creation' unless new_resource.cpg_name
  
  if !cpg_exists?(new_resource.storage_system, new_resource.name, new_resource.debug)
    converge_by("Create CPG #{new_resource.name}") do
      create_cpg(new_resource.storage_system, new_resource.cpg_name, new_resource.domain, new_resource.growth_increment, 
                           new_resource.growth_increment_unit, new_resource.growth_limit, new_resource.growth_limit_unit, new_resource.growth_warning, 
                           new_resource.growth_warning_unit, new_resource.raid_type, new_resource.set_size, new_resource.high_availability, 
                           new_resource.disk_type, new_resource.debug)
      Chef::Log.info("Created CPG #{new_resource.name}.")
    end
  else
    Chef::Log.info("CPG #{new_resource.name} already exists. Nothing to do.")
  end
end

action :delete do
# validations
  fail ArgumentError, 'Attribute cpg name is required for cpg deletion' unless new_resource.cpg_name
  if cpg_exists?(new_resource.storage_system, new_resource.name, new_resource.debug)
    converge_by("Delete CPG #{new_resource.name}") do
      delete_cpg(new_resource.storage_system, new_resource.cpg_name, new_resource.debug)
      Chef::Log.info("Deleted CPG #{new_resource.name}.")
    end
  else
    Chef::Log.info("CPG #{new_resource.name} does not exists. Nothing to do.")
  end
end
