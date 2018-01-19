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

hpe3par_virtual_volume node['hpe3par']['virtual_volume']['name'] do
  storage_system node['hpe3par']['storage_system']
  cpg node['hpe3par']['virtual_volume']['cpg']
  size node['hpe3par']['virtual_volume']['size']
  size_unit node['hpe3par']['virtual_volume']['size_unit']
  type node['hpe3par']['virtual_volume']['type']
  snap_cpg node['hpe3par']['virtual_volume']['snap_cpg']
  compression node['hpe3par']['virtual_volume']['compression']
  action :create
end

hpe3par_virtual_volume node['hpe3par']['virtual_volume']['name'] do
  storage_system node['hpe3par']['storage_system']

  action :delete
end

hpe3par_virtual_volume node['hpe3par']['virtual_volume']['name'] do
  storage_system node['hpe3par']['storage_system']
  size node['hpe3par']['virtual_volume']['size']
  size_unit node['hpe3par']['virtual_volume']['size_unit']

  action :grow
end

hpe3par_virtual_volume node['hpe3par']['virtual_volume']['name'] do
  storage_system node['hpe3par']['storage_system']
  size node['hpe3par']['virtual_volume']['size']
  size_unit node['hpe3par']['virtual_volume']['size_unit']

  action :grow_to_size
end

hpe3par_virtual_volume node['hpe3par']['virtual_volume']['name'] do
  storage_system node['hpe3par']['storage_system']
  cpg node['hpe3par']['virtual_volume']['tune']['user_cpg']

  action :change_user_cpg
end

hpe3par_virtual_volume node['hpe3par']['virtual_volume']['name'] do
  storage_system node['hpe3par']['storage_system']
  snap_cpg node['hpe3par']['virtual_volume']['tune']['snap_cpg']

  action :change_snap_cpg
end

hpe3par_virtual_volume node['hpe3par']['virtual_volume']['name'] do
  storage_system node['hpe3par']['storage_system']
  cpg node['hpe3par']['virtual_volume']['tune']['user_cpg']
  type node['hpe3par']['virtual_volume']['tune']['type']

  action :convert_type
end 

hpe3par_virtual_volume node['hpe3par']['virtual_volume']['name'] do
  storage_system node['hpe3par']['storage_system']
  new_name node['hpe3par']['virtual_volume']['modify']['new_name']
  ss_spc_alloc_warning_pct node['hpe3par']['virtual_volume']['modify']['ss_spc_alloc_warning_pct']
  ss_spc_alloc_limit_pct node['hpe3par']['virtual_volume']['modify']['ss_spc_alloc_limit_pct']
  rm_ss_spc_alloc_warning node['hpe3par']['virtual_volume']['modify']['rm_ss_spc_alloc_warning']
  usr_spc_alloc_warning_pct node['hpe3par']['virtual_volume']['modify']['usr_spc_alloc_warning_pct']
  usr_spc_alloc_limit_pct node['hpe3par']['virtual_volume']['modify']['usr_spc_alloc_limit_pct']
  rm_usr_spc_alloc_warning node['hpe3par']['virtual_volume']['modify']['rm_usr_spc_alloc_warning']
  expiration_hours node['hpe3par']['virtual_volume']['modify']['expiration_hours']
  retention_hours node['hpe3par']['virtual_volume']['modify']['retention_hours']
  rm_exp_time node['hpe3par']['virtual_volume']['modify']['rm_exp_time']
  rm_ss_spc_alloc_limit node['hpe3par']['virtual_volume']['modify']['rm_ss_spc_alloc_limit']
  rm_usr_spc_alloc_limit node['hpe3par']['virtual_volume']['modify']['rm_usr_spc_alloc_limit']

  action :modify
end

hpe3par_virtual_volume node['hpe3par']['virtual_volume']['name'] do
  storage_system node['hpe3par']['storage_system']
  snap_cpg node['hpe3par']['virtual_volume']['modify']['snap_cpg']

  action :set_snap_cpg
end
