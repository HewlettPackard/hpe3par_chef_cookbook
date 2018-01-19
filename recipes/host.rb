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

hpe3par_host node['hpe3par']['host']['create']['name'] do
  storage_system node['hpe3par']['storage_system']
  domain node['hpe3par']['host']['create']['domain']
  fc_wwns node['hpe3par']['host']['create']['fc_wwns']
  #iscsi_names node['hpe3par']['host']['create']['iscsi_names']
  persona node['hpe3par']['host']['create']['persona']
  action :create
end

hpe3par_host node['hpe3par']['host']['remove_fc_path']['host_name'] do
  storage_system node['hpe3par']['storage_system']
  fc_wwns node['hpe3par']['host']['remove_fc_path']['fc_wwns']
  force_path_removal node['hpe3par']['host']['remove_fc_path']['force_path_removal']
  action :remove_fc_path_from_host
end

hpe3par_host node['hpe3par']['host']['add_fc_path']['host_name'] do
  storage_system node['hpe3par']['storage_system']
  fc_wwns node['hpe3par']['host']['add_fc_path']['fc_wwns']
  action :add_fc_path_to_host
end

hpe3par_host node['hpe3par']['host']['add_iscsi_path']['host_name'] do
  storage_system node['hpe3par']['storage_system']
  iscsi_names node['hpe3par']['host']['add_iscsi_path']['iscsi_names']
  action :add_iscsi_path_to_host
end

hpe3par_host node['hpe3par']['host']['remove_iscsi_path']['host_name'] do
  storage_system node['hpe3par']['storage_system']
  iscsi_names node['hpe3par']['host']['remove_iscsi_path']['iscsi_names']
  force_path_removal node['hpe3par']['host']['remove_iscsi_path']['force_path_removal']
  action :remove_iscsi_path_from_host
end

hpe3par_host node['hpe3par']['host']['modify']['host_name'] do
  storage_system node['hpe3par']['storage_system']
  new_name node['hpe3par']['host']['modify']['new_name']
  domain node['hpe3par']['host']['modify']['domain']
  persona node['hpe3par']['host']['modify']['persona']
  action :modify
end

hpe3par_host node['hpe3par']['host']['add_initiator_chap']['host_name'] do
  storage_system node['hpe3par']['storage_system']
  chap_name node['hpe3par']['host']['add_initiator_chap']['chap_name']
  chap_secret node['hpe3par']['host']['add_initiator_chap']['chap_secret']
  chap_secret_hex node['hpe3par']['host']['add_initiator_chap']['chap_secret_hex']
  action :add_initiator_chap
end

hpe3par_host node['hpe3par']['host']['add_target_chap']['host_name'] do
  storage_system node['hpe3par']['storage_system']
  chap_name node['hpe3par']['host']['add_target_chap']['chap_name']
  chap_secret node['hpe3par']['host']['add_target_chap']['chap_secret']
  chap_secret_hex node['hpe3par']['host']['add_target_chap']['chap_secret_hex']
  action :add_target_chap
end

hpe3par_host node['hpe3par']['host']['remove_target_chap']['host_name'] do
  storage_system node['hpe3par']['storage_system']
  action :remove_target_chap
end

hpe3par_host node['hpe3par']['host']['remove_initiator_chap']['host_name'] do
  storage_system node['hpe3par']['storage_system']
  action :remove_initiator_chap
end

hpe3par_host node['hpe3par']['host']['delete']['host_name'] do
  storage_system node['hpe3par']['storage_system']
  action :delete
end
