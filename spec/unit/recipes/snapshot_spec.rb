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

describe 'hpe3par::snapshot' do

  let(:chef_run) do
    ChefSpec::SoloRunner.new(platform: PLATFORM, version: PLATFORM_VERSION,
                             step_into: ['snapshot']) do |node|
       node.override['hpe3par']['storage_system'] = {
           name: 'MY_3PAR',
           ip: '1.1.1.1.1',
           user: 'chef',
           password: 'chef'
       }
                               
       #Snapshot create
       node.override['hpe3par']['snapshot']['create']['snapshot_name'] = 'chef_thin_volume_vc'
       node.override['hpe3par']['snapshot']['create']['base_volume_name'] = 'chef_vol_thin'
       node.override['hpe3par']['snapshot']['create']['read_only'] = false
       node.override['hpe3par']['snapshot']['create']['expiration_time'] = 1
       node.override['hpe3par']['snapshot']['create']['expiration_unit'] = 'Days'
       node.override['hpe3par']['snapshot']['create']['retention_time'] = 1
       node.override['hpe3par']['snapshot']['create']['retention_unit'] = 'Days'
         
       #Snapshot restore
       node.override['hpe3par']['snapshot']['restore']['snapshot_name'] = 'chef_thin_volume_vc'
       node.override['hpe3par']['snapshot']['restore']['priority'] = 'MEDIUM'
       node.override['hpe3par']['snapshot']['restore']['allow_remote_copy_parent'] = false
         
       #Snapshot delete
       node.override['hpe3par']['snapshot']['delete']['snapshot_name'] = 'chef_thin_volume_vc'
         
       #Snapshot modify
       node.override['hpe3par']['snapshot']['modify']['snapshot_name'] = 'chef_thin_volume_vc'
       node.override['hpe3par']['snapshot']['modify']['new_name'] = 'chef_vol_thin_cc_chef'
       node.override['hpe3par']['snapshot']['modify']['retention_hours'] = 0
       node.override['hpe3par']['snapshot']['modify']['expiration_hours'] = 0
       node.override['hpe3par']['snapshot']['modify']['rm_exp_time'] = false

    end.converge(described_recipe)
  end

  it 'creates the snapshot through create snapshot' do
    expect(chef_run).to create_hpe3par_snapshot(chef_run.node['hpe3par']['snapshot']['create']['snapshot_name'])
  end

  it 'deletes the snapshot through delete snapshot' do
    expect(chef_run).to delete_hpe3par_snapshot(chef_run.node['hpe3par']['snapshot']['delete']['snapshot_name'])
  end
  
  it 'modifies the snapshot through modify snapshot' do
    expect(chef_run).to modify_hpe3par_snapshot(chef_run.node['hpe3par']['snapshot']['modify']['snapshot_name'])
  end
  
  it 'restores the snapshot through online restore snapshot' do
    expect(chef_run).to restore_hpe3par_online_snapshot(chef_run.node['hpe3par']['snapshot']['restore']['snapshot_name'])
  end
  
  it 'restores the snapshot through offline restore snapshot' do
    expect(chef_run).to restore_hpe3par_offline_snapshot(chef_run.node['hpe3par']['snapshot']['restore']['snapshot_name'])
  end
  
end
