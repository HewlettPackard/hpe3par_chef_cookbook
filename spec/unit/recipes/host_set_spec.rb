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

describe 'hpe3par::host_set' do

  let(:chef_run) do
    ChefSpec::SoloRunner.new(platform: PLATFORM, version: PLATFORM_VERSION,
                             step_into: ['host_set']) do |node|
       node.override['hpe3par']['storage_system'] = {
           name: 'MY_3PAR',
           ip: '1.1.1.1.1',
           user: 'chef',
           password: 'chef'
       }
      node.override['hpe3par']['host_set']['create']['name'] = 'chef_host_set'
      node.override['hpe3par']['host_set']['create']['setmembers'] = ['test_chef_host1']
      node.override['hpe3par']['host_set']['create']['domain'] = nil
      node.override['hpe3par']['host_set']['delete']['name'] = 'chef_host_set'
      node.override['hpe3par']['host_set']['add_host']['name'] = 'chef_host_set'
      node.override['hpe3par']['host_set']['add_host']['setmembers'] = ['test_chef_host1']
      node.override['hpe3par']['host_set']['remove_host']['name'] = 'chef_host_set'
      node.override['hpe3par']['host_set']['remove_host']['setmembers'] = ['test_chef_host1']
    end.converge(described_recipe)
  end

  it 'creates host set through create_host_set' do
    expect(chef_run).to create_hpe3par_host_set(chef_run.node['hpe3par']['host_set']['create']['name'])
  end

  it 'deletes the virtual_volume through delete_host_set' do
    expect(chef_run).to delete_hpe3par_host_set(chef_run.node['hpe3par']['host_set']['delete']['name'])
  end

  it 'adds host to a host set through add_host_to_host_set' do
    expect(chef_run).to add_hosts_hpe3par_host_set(chef_run.node['hpe3par']['host_set']['add_host']['name'])
  end

  it 'removes host from a host set through remove_host_from_host_set' do
    expect(chef_run).to remove_hosts_hpe3par_host_set(chef_run.node['hpe3par']['host_set']['remove_host']['name'] )
  end

end
