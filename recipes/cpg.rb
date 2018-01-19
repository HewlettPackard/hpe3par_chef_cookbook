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

hpe3par_cpg node['hpe3par']['cpg']['create']['name'] do
  storage_system node['hpe3par']['storage_system']
  domain node['hpe3par']['cpg']['create']['domain']
  growth_increment node['hpe3par']['cpg']['create']['growth_increment']
  growth_increment_unit node['hpe3par']['cpg']['create']['growth_increment_unit']
  growth_limit node['hpe3par']['cpg']['create']['growth_limit']
  growth_limit_unit node['hpe3par']['cpg']['create']['growth_limit_unit']
  growth_warning node['hpe3par']['cpg']['create']['growth_warning']
  growth_warning_unit node['hpe3par']['cpg']['create']['growth_warning_unit']
  raid_type node['hpe3par']['cpg']['create']['raid_type']
  set_size node['hpe3par']['cpg']['create']['set_size']
  high_availability node['hpe3par']['cpg']['create']['high_availability']
  disk_type node['hpe3par']['cpg']['create']['disk_type']
    
  action :create
end

hpe3par_cpg node['hpe3par']['cpg']['delete']['name'] do
  storage_system node['hpe3par']['storage_system']
    
  action :delete
end

