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

hpe3par_host_set node['hpe3par']['host_set']['create']['name'] do
  storage_system node['hpe3par']['storage_system']
  domain node['hpe3par']['host_set']['create']['domain']
  setmembers node['hpe3par']['host_set']['create']['setmembers']
  action :create
end

hpe3par_host_set node['hpe3par']['host_set']['remove_host']['name'] do
  storage_system node['hpe3par']['storage_system']
  setmembers node['hpe3par']['host_set']['remove_host']['setmembers']
  action :remove_host
end

hpe3par_host_set node['hpe3par']['host_set']['add_host']['name'] do
  storage_system node['hpe3par']['storage_system']
  setmembers node['hpe3par']['host_set']['add_host']['setmembers']
  action :add_host
end

hpe3par_host_set node['hpe3par']['host_set']['delete']['name'] do
  storage_system node['hpe3par']['storage_system']
  action :delete
end



