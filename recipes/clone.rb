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

hpe3par_clone node['hpe3par']['clone']['create_online']['clone_name'] do
  storage_system node['hpe3par']['storage_system']
  base_volume_name node['hpe3par']['clone']['create_online']['base_volume_name']
  dest_cpg node['hpe3par']['clone']['create_online']['dest_cpg']
  online node['hpe3par']['clone']['create_online']['online']
  tpvv node['hpe3par']['clone']['create_online']['tpvv']
  tdvv node['hpe3par']['clone']['create_online']['tdvv']
  snap_cpg node['hpe3par']['clone']['create_online']['snap_cpg']
  compression node['hpe3par']['clone']['create_online']['compression']

  action :create_online
end

hpe3par_clone node['hpe3par']['clone']['create_offline']['clone_name'] do
  storage_system node['hpe3par']['storage_system']
  base_volume_name node['hpe3par']['clone']['create_offline']['base_volume_name']
  dest_cpg node['hpe3par']['clone']['create_offline']['dest_cpg']
  online node['hpe3par']['clone']['create_offline']['online']
  save_snapshot node['hpe3par']['clone']['create_offline']['save_snapshot']
  priority node['hpe3par']['clone']['create_offline']['priority']
  skip_zero node['hpe3par']['clone']['create_offline']['skip_zero']

  action :create_offline
end

hpe3par_clone node['hpe3par']['clone']['resync']['clone_name'] do
  storage_system node['hpe3par']['storage_system']

  action :resync
end

hpe3par_clone node['hpe3par']['clone']['stop']['clone_name'] do
  storage_system node['hpe3par']['storage_system']

  action :stop
end

hpe3par_clone node['hpe3par']['clone']['delete']['clone_name'] do
  storage_system node['hpe3par']['storage_system']
  base_volume_name node['hpe3par']['clone']['delete']['base_volume_name']
  action :delete
end
