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

describe 'hpe3par::volume_set' do

  let(:chef_run) do
    ChefSpec::SoloRunner.new(platform: PLATFORM, version: PLATFORM_VERSION,
                             step_into: ['volume_set']) do |node|
       node.override['hpe3par']['storage_system'] = {
           name: 'MY_3PAR',
           ip: '1.1.1.1.1',
           user: 'chef',
           password: 'chef'
       }
                               #volumeset create
       node.override['hpe3par']['volume_set']['create']['name'] = 'chef_volume_set'
       node.override['hpe3par']['volume_set']['create']['domain'] = 'my_domain'
       node.override['hpe3par']['volume_set']['create']['setmembers'] = ['chef_vol_thin2']
         
       #volumeset delete
       node.override['hpe3par']['volume_set']['delete']['name'] = 'chef_volume_set'
         
       #volumeset add_volume
       node.override['hpe3par']['volume_set']['add_volume']['name'] = 'chef_volume_set'
       node.override['hpe3par']['volume_set']['add_volume']['setmembers'] = ['chef_vol_thin2']
         
       #volumeset add_volume
       node.override['hpe3par']['volume_set']['remove_volume']['name'] = 'chef_volume_set'
       node.override['hpe3par']['volume_set']['remove_volume']['setmembers'] = ['chef_vol_thin2']

    end.converge(described_recipe)
  end

  it 'creates the volume set through create_volume_set' do
    expect(chef_run).to create_hpe3par_volume_set(chef_run.node['hpe3par']['volume_set']['create']['name'])
  end

  it 'deletes the volume set through delete_volume_set' do
    expect(chef_run).to delete_hpe3par_volume_set(chef_run.node['hpe3par']['volume_set']['delete']['name'])
  end
  

  it 'adds volume to the volume set through add_volume_set' do
    expect(chef_run).to add_volume_hpe3par_volume_set(chef_run.node['hpe3par']['volume_set']['add_volume']['name'])
  end
  

  it 'removes volume from the volume set through remove_volume_set' do
    expect(chef_run).to remove_volume_hpe3par_volume_set(chef_run.node['hpe3par']['volume_set']['remove_volume']['name'])
  end

end