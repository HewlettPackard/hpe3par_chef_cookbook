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

hpe3par_vlun node['hpe3par']['vlun']['export_volume_to_host']['volume_name'] do
   storage_system node['hpe3par']['storage_system']
   lunid node['hpe3par']['vlun']['export_volume_to_host']['lunid']
   autolun node['hpe3par']['vlun']['export_volume_to_host']['autolun']
   host_name node['hpe3par']['vlun']['export_volume_to_host']['host_name']
   node_val node['hpe3par']['vlun']['export_volume_to_host']['node_val'] 
   slot node['hpe3par']['vlun']['export_volume_to_host']['slot']
   card_port node['hpe3par']['vlun']['export_volume_to_host']['card_port'] 
   action :export_volume_to_host
 end

 hpe3par_vlun node['hpe3par']['vlun']['unexport_volume_to_host']['volume_name'] do
   storage_system node['hpe3par']['storage_system']
   lunid node['hpe3par']['vlun']['unexport_volume_to_host']['lunid']
   host_name node['hpe3par']['vlun']['unexport_volume_to_host']['host_name']
   action :unexport_volume_to_host
 end


hpe3par_vlun node['hpe3par']['vlun']['export_volume_to_hostset']['volume_name'] do
   storage_system node['hpe3par']['storage_system']
   hostset_name node['hpe3par']['vlun']['export_volume_to_hostset']['hostset_name']
   lunid node['hpe3par']['vlun']['export_volume_to_hostset']['lunid']
   autolun node['hpe3par']['vlun']['export_volume_to_hostset']['autolun'] 
   action :export_volume_to_hostset
 end

  hpe3par_vlun node['hpe3par']['vlun']['unexport_volume_to_hostset']['volume_name'] do
    storage_system node['hpe3par']['storage_system']
    lunid node['hpe3par']['vlun']['unexport_volume_to_hostset']['lunid']
    hostset_name node['hpe3par']['vlun']['unexport_volume_to_hostset']['hostset_name']
    action :unexport_volume_to_hostset
 end


hpe3par_vlun node['hpe3par']['vlun']['export_volumeset_to_host']['volumeset_name'] do
   volumeset_name node['hpe3par']['vlun']['export_volumeset_to_host']['volumeset_name']
   storage_system node['hpe3par']['storage_system']
   lunid node['hpe3par']['vlun']['export_volumeset_to_host']['lunid']
   autolun node['hpe3par']['vlun']['export_volumeset_to_host']['autolun']
   host_name node['hpe3par']['vlun']['export_volumeset_to_host']['host_name']
   action :export_volumeset_to_host
 end

 hpe3par_vlun node['hpe3par']['vlun']['unexport_volumeset_to_host']['volumeset_name'] do
   volumeset_name node['hpe3par']['vlun']['unexport_volumeset_to_host']['volumeset_name']
   storage_system node['hpe3par']['storage_system']
   lunid node['hpe3par']['vlun']['unexport_volumeset_to_host']['lunid']
   host_name node['hpe3par']['vlun']['unexport_volumeset_to_host']['host_name']
   action :unexport_volumeset_to_host
end


hpe3par_vlun node['hpe3par']['vlun']['export_volumeset_to_hostset']['volumeset_name'] do
  volumeset_name node['hpe3par']['vlun']['export_volumeset_to_hostset']['volumeset_name']
  storage_system node['hpe3par']['storage_system']
  lunid node['hpe3par']['vlun']['export_volumeset_to_hostset']['lunid']
  autolun node['hpe3par']['vlun']['export_volumeset_to_hostset']['autolun'] 
  hostset_name node['hpe3par']['vlun']['export_volumeset_to_hostset']['hostset_name']
  action :export_volumeset_to_hostset
end

hpe3par_vlun node['hpe3par']['vlun']['unexport_volumeset_to_hostset']['volumeset_name'] do
  volumeset_name node['hpe3par']['vlun']['unexport_volumeset_to_hostset']['volumeset_name']
  storage_system node['hpe3par']['storage_system']
  lunid node['hpe3par']['vlun']['unexport_volumeset_to_hostset']['lunid']
  hostset_name node['hpe3par']['vlun']['unexport_volumeset_to_hostset']['hostset_name']
  action :unexport_volumeset_to_hostset
end
