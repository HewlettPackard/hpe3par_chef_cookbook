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

hpe3par_snapshot node['hpe3par']['snapshot']['create']['snapshot_name'] do
  storage_system node['hpe3par']['storage_system']
  base_volume_name node['hpe3par']['snapshot']['create']['base_volume_name']
  read_only node['hpe3par']['snapshot']['create']['read_only']
  expiration_time node['hpe3par']['snapshot']['create']['expiration_time']
  retention_time node['hpe3par']['snapshot']['create']['retention_time']
  expiration_unit node['hpe3par']['snapshot']['create']['expiration_unit']
  retention_unit node['hpe3par']['snapshot']['create']['retention_unit']  

  action :create
end

hpe3par_snapshot node['hpe3par']['snapshot']['modify']['snapshot_name'] do
  storage_system node['hpe3par']['storage_system']
  new_name node['hpe3par']['snapshot']['modify']['new_name']
  retention_hours node['hpe3par']['snapshot']['modify']['retention_hours']
  expiration_hours node['hpe3par']['snapshot']['modify']['expiration_hours']
  rm_exp_time node['hpe3par']['snapshot']['modify']['rm_exp_time']

    
  action :modify
end

hpe3par_snapshot node['hpe3par']['snapshot']['restore']['snapshot_name'] do
  storage_system node['hpe3par']['storage_system']
  priority node['hpe3par']['snapshot']['restore']['priority']
  allow_remote_copy_parent node['hpe3par']['snapshot']['restore']['allow_remote_copy_parent']
  action :restore_offline
end

hpe3par_snapshot node['hpe3par']['snapshot']['restore']['snapshot_name'] do
  storage_system node['hpe3par']['storage_system']
  allow_remote_copy_parent node['hpe3par']['snapshot']['restore']['allow_remote_copy_parent']
  action :restore_online
end

hpe3par_snapshot node['hpe3par']['snapshot']['delete']['snapshot_name'] do
  storage_system node['hpe3par']['storage_system']
  action :delete
end
