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

require_relative '../../spec_helper'

describe 'hpe3par::vlun' do

  let(:chef_run) do
    ChefSpec::SoloRunner.new(platform: PLATFORM, version: PLATFORM_VERSION,
                             step_into: ['vlun']) do |node|
     node.override['hpe3par']['storage_system'] = {
         name: 'MY_3PAR',
         ip: '1.1.1.1.1',
         user: 'chef',
         password: 'chef'
     }
      node.override['hpe3par']['vlun']['export_volume_to_host']['volume_name'] = 'test_chef_volume'
      node.override['hpe3par']['vlun']['export_volume_to_host']['host_name'] = 'test_chef_host'
      node.override['hpe3par']['vlun']['unexport_volume_to_host']['volume_name'] = 'test_chef_volume'
      node.override['hpe3par']['vlun']['unexport_volume_to_host']['host_name'] = 'test_chef_host'
      node.override['hpe3par']['vlun']['unexport_volume_to_host']['lunid'] = 1
      node.override['hpe3par']['vlun']['export_volume_to_hostset']['volume_name'] = 'test_chef_volume'
      node.override['hpe3par']['vlun']['export_volume_to_hostset']['hostset_name'] = 'test_chef_hostset'
      node.override['hpe3par']['vlun']['unexport_volume_to_hostset']['volume_name'] = 'test_chef_volume'
      node.override['hpe3par']['vlun']['unexport_volume_to_hostset']['hostset_name'] = 'test_chef_hostset'
      node.override['hpe3par']['vlun']['unexport_volume_to_hostset']['lunid'] = 1
      node.override['hpe3par']['vlun']['export_volumeset_to_host']['volumeset_name'] = 'test_chef_vvset'
      node.override['hpe3par']['vlun']['export_volumeset_to_host']['host_name'] = 'test_chef_host'
      node.override['hpe3par']['vlun']['unexport_volumeset_to_host']['volumeset_name'] = 'test_chef_vvset'
      node.override['hpe3par']['vlun']['unexport_volumeset_to_host']['host_name'] = 'test_chef_host'
      node.override['hpe3par']['vlun']['unexport_volumeset_to_host']['lunid'] = 1
      node.override['hpe3par']['vlun']['export_volumeset_to_hostset']['volumeset_name'] = 'test_chef_vvset'
      node.override['hpe3par']['vlun']['export_volumeset_to_hostset']['hostset_name'] = 'test_chef_hostset'
      node.override['hpe3par']['vlun']['unexport_volumeset_to_hostset']['volumeset_name'] = 'test_chef_vvset'
      node.override['hpe3par']['vlun']['unexport_volumeset_to_hostset']['hostset_name'] = 'test_chef_hostset'
      node.override['hpe3par']['vlun']['unexport_volumeset_to_hostset']['lunid'] = 1 
     

                                 
    end.converge(described_recipe)
  end

  it 'exports a volume to a host  through export_volume_to_host_hpe3par_vlun' do
    expect(chef_run).to export_volume_to_host_hpe3par_vlun(chef_run.node['hpe3par']['vlun']['export_volume_to_host']['volume_name'])
  end

  it 'unexport a volume to a host unexport_volume_to_host_hpe3par_vlun' do
    expect(chef_run).to unexport_volume_to_host_hpe3par_vlun(chef_run.node['hpe3par']['vlun']['unexport_volume_to_host']['volume_name'])
  end

  it 'exports volume to hostset through export_volume_to_hostset_hpe3par_vlun' do
    expect(chef_run).to export_volume_to_hostset_hpe3par_vlun(chef_run.node['hpe3par']['vlun']['export_volume_to_hostset']['volume_name'])
  end

  it 'unexports volume to hostset through unexport_volume_to_hostset_hpe3par_vlun' do
    expect(chef_run).to unexport_volume_to_hostset_hpe3par_vlun(chef_run.node['hpe3par']['vlun']['unexport_volume_to_hostset']['volume_name'])
  end


  it 'exports volumeset to host through export_volumeset_to_host_hpe3par_vlun' do
    expect(chef_run).to export_volumeset_to_host_hpe3par_vlun(chef_run.node['hpe3par']['vlun']['export_volumeset_to_host']['volumeset_name'])
  end

  it 'unexports volumeset to host through unexport_volumeset_to_host_hpe3par_vlun' do
    expect(chef_run).to unexport_volumeset_to_host_hpe3par_vlun(chef_run.node['hpe3par']['vlun']['unexport_volumeset_to_host']['volumeset_name'])
  end

  it 'exports volumeset to hostset through export_volumeset_to_hostset_hpe3par_vlun' do
    expect(chef_run).to export_volumeset_to_hostset_hpe3par_vlun(chef_run.node['hpe3par']['vlun']['export_volumeset_to_hostset']['volumeset_name'])
  end

  it 'unexports volumeset to hostset through unexport_volumeset_to_hostset_hpe3par_vlun' do
    expect(chef_run).to unexport_volumeset_to_hostset_hpe3par_vlun(chef_run.node['hpe3par']['vlun']['unexport_volumeset_to_hostset']['volumeset_name'])
  end

end