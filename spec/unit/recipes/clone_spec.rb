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

describe 'hpe3par::clone' do

  let(:chef_run) do
    ChefSpec::SoloRunner.new(platform: PLATFORM, version: PLATFORM_VERSION,
                             step_into: ['clone']) do |node|
                               
       node.override['hpe3par']['storage_system'] = {
           name: 'MY_3PAR',
           ip: '1.1.1.1.1',
           user: 'chef',
           password: 'chef'
       }
       #clone create_online
       node.normal['hpe3par']['clone']['create_online']['clone_name'] = 'chef_test_vol_clone'
       node.normal['hpe3par']['clone']['create_online']['base_volume_name'] = 'chef_vol_thin2'
       node.normal['hpe3par']['clone']['create_online']['dest_cpg'] = 'FC_r1'
       node.normal['hpe3par']['clone']['create_online']['online'] = true
       node.normal['hpe3par']['clone']['create_online']['tpvv'] = false
       node.normal['hpe3par']['clone']['create_online']['tdvv'] = false
       node.normal['hpe3par']['clone']['create_online']['snap_cpg'] = 'FC_r1'
       node.normal['hpe3par']['clone']['create_online']['compression'] = false
       
       #clone create_offline
       node.normal['hpe3par']['clone']['create_offline']['clone_name'] = 'chef_test_vol_clone'
       node.normal['hpe3par']['clone']['create_offline']['base_volume_name'] = 'chef_vol_thin2'
       node.normal['hpe3par']['clone']['create_offline']['dest_cpg'] = 'FC_r1'
       node.normal['hpe3par']['clone']['create_offline']['online'] = false
       node.normal['hpe3par']['clone']['create_offline']['save_snapshot'] = true
       node.normal['hpe3par']['clone']['create_offline']['priority'] = 'MEDIUM'
       node.normal['hpe3par']['clone']['create_offline']['skip_zero'] = false
         
       #clone resync
       node.normal['hpe3par']['clone']['resync']['clone_name'] = 'chef_test_vol_clone'
       
       #clone stop
       node.normal['hpe3par']['clone']['stop']['clone_name'] = 'chef_test_vol_clone'
         
       #clone delete
       node.normal['hpe3par']['clone']['delete']['clone_name'] = 'chef_test_vol_clone'

    end.converge(described_recipe)
  end

  it 'creates the offline clone through create offline clone' do
    expect(chef_run).to create_online_hpe3par_clone(chef_run.node['hpe3par']['clone']['create_offline']['clone_name'])
  end

  it 'created the online clone through create online clone' do
    expect(chef_run).to create_offline_hpe3par_clone(chef_run.node['hpe3par']['clone']['create_online']['clone_name'])
  end
  
  it 'resyncs clone through resync clone' do
    expect(chef_run).to resync_hpe3par_clone(chef_run.node['hpe3par']['clone']['resync']['clone_name'])
  end
  

  it 'stops clone stop clone' do
    expect(chef_run).to stop_hpe3par_clone(chef_run.node['hpe3par']['clone']['stop']['clone_name'])
  end
  
  it 'deletes clone through delete clone' do
    expect(chef_run).to delete_hpe3par_clone(chef_run.node['hpe3par']['clone']['delete']['clone_name'])
  end

  it 'creates the offline clone through create offline clone with invalid priority value' do
    
    chef_run.node.normal['hpe3par']['clone']['create_offline']['priority'] = 'INVALID'
    expect{ chef_run.converge(described_recipe) }.to raise_error(Chef::Exceptions::ValidationFailed,
    'Option priority must be equal to one of: HIGH, MEDIUM, LOW!  You passed "INVALID".')
  end
end
