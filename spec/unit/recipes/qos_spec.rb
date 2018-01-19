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

describe 'hpe3par::qos' do

  let(:chef_run) do
    ChefSpec::SoloRunner.new(platform: PLATFORM, version: PLATFORM_VERSION,
                             step_into: ['qos']) do |node|
       node.normal['hpe3par']['storage_system'] = {
           name: 'MY_3PAR',
           ip: '1.1.1.1.1',
           user: 'chef',
           password: 'chef'
       }
      node.normal['hpe3par']['qos']['create']['qos_target_name'] = 'test_3par_chef'
      node.normal['hpe3par']['qos']['modify']['qos_target_name'] = 'test_3par_chef'
      node.normal['hpe3par']['qos']['delete']['qos_target_name'] = 'test_3par_chef'
      node.normal['hpe3par']['qos']['modify']['enable'] = true
      node.normal['hpe3par']['qos']['create']['priority'] = 'LOW'
      node.normal['hpe3par']['qos']['create']['bwMinGoalKB'] = 500
      node.normal['hpe3par']['qos']['create']['bwMaxLimitKB'] = 500
    end.converge(described_recipe)
  end

  it 'creates the qos through create_qos' do
    expect(chef_run).to create_hpe3par_qos(chef_run.node['hpe3par']['qos']['create']['qos_target_name'])
  end

  it 'modifies the qos through modify_qos' do
    expect(chef_run).to modify_hpe3par_qos(chef_run.node['hpe3par']['qos']['modify']['qos_target_name'])
  end

  it 'delete the qos through delete_qos' do
    expect(chef_run).to delete_hpe3par_qos(chef_run.node['hpe3par']['qos']['delete']['qos_target_name'])
  end

  it 'creates the qos through create_qos with invalid priority' do
    chef_run.node.normal['hpe3par']['qos']['create']['priority'] = 'INVALID'
    expect{ chef_run.converge(described_recipe) }.to raise_error(Chef::Exceptions::ValidationFailed,
      'Option priority must be equal to one of: LOW, NORMAL, HIGH!  You passed "INVALID".')
  end
   
  it 'creates the qos through create_qos with invalid bwmin_goal_op' do
    chef_run.node.normal['hpe3par']['qos']['create']['bwmin_goal_op'] = 'INVALID'
    expect{ chef_run.converge(described_recipe) }.to raise_error(Chef::Exceptions::ValidationFailed,
      'Option bwmin_goal_op must be equal to one of: ZERO, NOLIMIT!  You passed "INVALID".')
  end
  
  it 'creates the qos through create_qos with invalid bwmax_limit_op' do
    chef_run.node.normal['hpe3par']['qos']['create']['bwmax_limit_op'] = 'INVALID'
    expect{ chef_run.converge(described_recipe) }.to raise_error(Chef::Exceptions::ValidationFailed,
      'Option bwmax_limit_op must be equal to one of: ZERO, NOLIMIT!  You passed "INVALID".')
  end
  
  it 'creates the qos through create_qos with invalid iomin_goal_op' do
    chef_run.node.normal['hpe3par']['qos']['create']['iomin_goal_op'] = 'INVALID'
    expect{ chef_run.converge(described_recipe) }.to raise_error(Chef::Exceptions::ValidationFailed,
      'Option iomin_goal_op must be equal to one of: ZERO, NOLIMIT!  You passed "INVALID".')
  end
  
  it 'creates the qos through create_qos with invalid iomax_limit_op' do
    chef_run.node.normal['hpe3par']['qos']['create']['iomax_limit_op'] = 'INVALID'
    expect{ chef_run.converge(described_recipe) }.to raise_error(Chef::Exceptions::ValidationFailed,
      'Option iomax_limit_op must be equal to one of: ZERO, NOLIMIT!  You passed "INVALID".')
  end
end
