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

describe 'hpe3par::virtual_volume' do

  let(:chef_run) do
    ChefSpec::SoloRunner.new(platform: PLATFORM, version: PLATFORM_VERSION,
                             step_into: ['virtual_volume']) do |node|
                               
       node.normal['hpe3par']['storage_system'] = {
           name: 'MY_3PAR',
           ip: '1.1.1.1.1',
           user: 'chef',
           password: 'chef'
       }
       node.normal['hpe3par']['virtual_volume']['name'] = 'chef_vol_thin2'
       node.normal['hpe3par']['virtual_volume']['cpg'] = 'FC_r1'
       node.normal['hpe3par']['virtual_volume']['size'] = 1024.0
       node.normal['hpe3par']['virtual_volume']['size_unit'] = 'MiB'
       node.normal['hpe3par']['virtual_volume']['type'] = 'thin'
       node.normal['hpe3par']['virtual_volume']['compression'] = false
       node.normal['hpe3par']['virtual_volume']['snap_cpg'] = 'FC_r1'
       
       #virtual_volume modify
       node.normal['hpe3par']['virtual_volume']['modify']['snap_cpg'] = 'FC_r1'
       node.normal['hpe3par']['virtual_volume']['modify']['new_name'] = 'chef_vol_thin2_1'
       
       node.normal['hpe3par']['virtual_volume']['modify']['ss_spc_alloc_warning_pct'] = 0
       node.normal['hpe3par']['virtual_volume']['modify']['ss_spc_alloc_limit_pct'] = 0
       node.normal['hpe3par']['virtual_volume']['modify']['rm_ss_spc_alloc_warning'] = false
       node.normal['hpe3par']['virtual_volume']['modify']['usr_spc_alloc_warning_pct'] = 0
       node.normal['hpe3par']['virtual_volume']['modify']['usr_spc_alloc_limit_pct'] = 0
       node.normal['hpe3par']['virtual_volume']['modify']['rm_usr_spc_alloc_warning'] = false
       node.normal['hpe3par']['virtual_volume']['modify']['expiration_hours'] = 0
       node.normal['hpe3par']['virtual_volume']['modify']['retention_hours'] = 0
       node.normal['hpe3par']['virtual_volume']['modify']['rm_exp_time'] = false
       node.normal['hpe3par']['virtual_volume']['modify']['rm_ss_spc_alloc_limit'] = false
       node.normal['hpe3par']['virtual_volume']['modify']['rm_usr_spc_alloc_limit'] = false
       
       #virtual_volume tune
       node.normal['hpe3par']['virtual_volume']['tune']['user_cpg'] = 'FC_r1'
       node.normal['hpe3par']['virtual_volume']['tune']['snap_cpg'] = 'FC_r1'
       node.normal['hpe3par']['virtual_volume']['tune']['type'] = 'full'
       node.normal['hpe3par']['virtual_volume']['tune']['keep_vv'] = 'vol_bkup'
       node.normal['hpe3par']['virtual_volume']['tune']['compression'] = false
    end.converge(described_recipe)
  end

  it 'creates the virtual_volume through create_volume' do
    expect(chef_run).to create_hpe3par_virtual_volume(chef_run.node['hpe3par']['virtual_volume']['name'])
  end

  it 'deletes the virtual_volume through delete_volume' do
    expect(chef_run).to delete_hpe3par_virtual_volume(chef_run.node['hpe3par']['virtual_volume']['name'])
  end

  it 'grows the virtual_volume through grow_volume' do
    expect(chef_run).to grow_hpe3par_virtual_volume(chef_run.node['hpe3par']['virtual_volume']['name'])
  end
  
  it 'grows the virtual_volume through grow_to_size' do
    expect(chef_run).to grow_to_size_hpe3par_virtual_volume(chef_run.node['hpe3par']['virtual_volume']['name'])
  end

  it 'changes the snap CPG of the virtual_volume through change_snap_cpg' do
    expect(chef_run).to change_snap_cpg_hpe3par_virtual_volume(chef_run.node['hpe3par']['virtual_volume']['name'])
  end

  it 'changes the user CPG of the virtual_volume through change_user_cpg' do
    expect(chef_run).to change_user_cpg_hpe3par_virtual_volume(chef_run.node['hpe3par']['virtual_volume']['name'])
  end

  it 'converts the type of the virtual_volume through convert_type' do
    expect(chef_run).to convert_type_hpe3par_virtual_volume(chef_run.node['hpe3par']['virtual_volume']['name'])
  end

  it 'creates the virtual_volume with invalid size unit' do
    chef_run.node.normal['hpe3par']['virtual_volume']['size_unit'] = 'INVALID'
    expect{ chef_run.converge(described_recipe) }.to raise_error(Chef::Exceptions::ValidationFailed,
      'Option size_unit must be equal to one of: TiB, GiB, MiB!  You passed "INVALID".')
  end
end
