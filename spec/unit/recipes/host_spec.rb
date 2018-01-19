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

describe 'hpe3par::host' do

  let(:chef_run) do
    ChefSpec::SoloRunner.new(platform: PLATFORM, version: PLATFORM_VERSION,
                             step_into: ['host']) do |node|
                               node.normal['hpe3par']['storage_system'] = {
                                   name: 'MY_3PAR',
                                   ip: '1.1.1.1.1',
                                   user: 'chef',
                                   password: 'chef'
                               }
      node.normal['hpe3par']['host']['create']['name'] = 'test_chef_host1'
      node.normal['hpe3par']['host']['create']['domain'] = 'my_domain'
      node.normal['hpe3par']['host']['create']['fc_wwns'] = ['1000D89D676F3854']
      node.normal['hpe3par']['host']['create']['iscsi_names'] = ['iqn.1993-08.org.debian:01:ba4c8e542ae']
      node.normal['hpe3par']['host']['create']['persona'] = 'WINDOWS_SERVER'
      node.normal['hpe3par']['host']['add_fc_path']['host_name'] = 'test_chef_host1'
      node.normal['hpe3par']['host']['add_fc_path']['fc_wwns'] = ['1000D89D676F3854']
      node.normal['hpe3par']['host']['remove_fc_path']['host_name'] = 'test_chef_host1'
      node.normal['hpe3par']['host']['remove_fc_path']['fc_wwns'] = ['1000D89D676F3854']
      node.normal['hpe3par']['host']['remove_fc_path']['force_path_removal'] = true
      node.normal['hpe3par']['host']['add_iscsi_path']['host_name'] = 'test_chef_host1'
      node.normal['hpe3par']['host']['add_iscsi_path']['iscsi_names'] = ['iqn.1993-08.org.debian:01:ba4c8e542ae']
      node.normal['hpe3par']['host']['remove_iscsi_path']['host_name'] = 'test_chef_host1'
      node.normal['hpe3par']['host']['remove_iscsi_path']['iscsi_names'] = ['iqn.1993-08.org.debian:01:ba4c8e542ae']
      node.normal['hpe3par']['host']['remove_iscsi_path']['force_path_removal'] = false
      node.normal['hpe3par']['host']['modify']['host_name'] = 'test_chef_host1'
      node.normal['hpe3par']['host']['modify']['new_name'] = 'test_chef_host2'
      node.normal['hpe3par']['host']['modify']['domain'] = 'my_domain'
      node.normal['hpe3par']['host']['modify']['persona'] = 'AIX_LEGACY'
      node.normal['hpe3par']['host']['add_initiator_chap']['host_name'] = 'test_chef_host2'
      node.normal['hpe3par']['host']['add_initiator_chap']['chap_name'] = 'initiator-chap-name'
      node.normal['hpe3par']['host']['add_initiator_chap']['chap_secret'] = 'ini-chap-secret'
      node.normal['hpe3par']['host']['add_initiator_chap']['chap_secret_hex'] = false
      node.normal['hpe3par']['host']['add_target_chap']['host_name'] = 'test_chef_host2'
      node.normal['hpe3par']['host']['add_target_chap']['chap_name'] = 'target-chap-name'
      node.normal['hpe3par']['host']['add_target_chap']['chap_secret'] = '768EA6A5FBD6020ABEE4D4DEDBF9C5AE'
      node.normal['hpe3par']['host']['add_target_chap']['chap_secret_hex'] = true
      node.normal['hpe3par']['host']['remove_target_chap']['host_name'] = 'test_chef_host2'
      node.normal['hpe3par']['host']['remove_initiator_chap']['host_name'] = 'test_chef_host2'
      node.normal['hpe3par']['host']['delete']['host_name'] = 'test_chef_host2'
    end.converge(described_recipe)
  end

  it 'creates the host through create_host' do
    expect(chef_run).to create_hpe3par_host(chef_run.node['hpe3par']['host']['create']['name'])
  end

  it 'Removes FC path from host through modify_host' do
    expect(chef_run).to remove_fc_path_from_host_hpe3par_host(chef_run.node['hpe3par']['host']['remove_fc_path']['host_name'])
  end

  it 'Adds FC path to host through modify_host' do
    expect(chef_run).to add_fc_path_to_host_hpe3par_host(chef_run.node['hpe3par']['host']['add_fc_path']['host_name'])
  end

  it 'Adds iSCSI path to host through modify_host' do
    expect(chef_run).to add_iscsi_path_to_host_hpe3par_host(chef_run.node['hpe3par']['host']['add_iscsi_path']['host_name'])
  end

  it 'Removess iSCSI path from host through modify_host' do
    expect(chef_run).to remove_iscsi_path_from_host_hpe3par_host(chef_run.node['hpe3par']['host']['remove_iscsi_path']['host_name'])
  end

  it 'Modify other host details through modify_host' do
    expect(chef_run).to modify_hpe3par_host(chef_run.node['hpe3par']['host']['modify']['host_name'])
  end

  it 'Adds initiator chap to host through modify_host' do
    expect(chef_run).to add_initiator_chap_hpe3par_host(chef_run.node['hpe3par']['host']['add_initiator_chap']['host_name'])
  end

  it 'Adds target chap to host through modify_host' do
    expect(chef_run).to add_target_chap_hpe3par_host(chef_run.node['hpe3par']['host']['add_target_chap']['host_name'])
  end

  it 'Removes target chap from host through modify_host' do
    expect(chef_run).to remove_target_chap_hpe3par_host(chef_run.node['hpe3par']['host']['remove_target_chap']['host_name'])
  end

  it 'Removes initiator chap from host through modify_host' do
    expect(chef_run).to remove_initiator_chap_hpe3par_host(chef_run.node['hpe3par']['host']['remove_initiator_chap']['host_name'])
  end

  it 'Deletes the host through delete_host' do
    expect(chef_run).to delete_hpe3par_host(chef_run.node['hpe3par']['host']['delete']['host_name'])
  end
  
  it 'creates the host through create_host with invalid persona' do
    chef_run.node.normal['hpe3par']['host']['create']['persona'] = 'DUMMY'
    expect{ chef_run.converge(described_recipe) }.to raise_error(Chef::Exceptions::ValidationFailed,
      'Option persona must be equal to one of: GENERIC, GENERIC_ALUA, GENERIC_LEGACY, HPUX_LEGACY, AIX_LEGACY, EGENERA, ONTAP_LEGACY, VMWARE, OPENVMS, HPUX, WINDOWS_SERVER!  You passed "DUMMY".')
  end

  it 'Modify other host details through modify_host passing invalid persona' do
    chef_run.node.normal['hpe3par']['host']['modify']['persona'] = 'DUMMY'
    expect{ chef_run.converge(described_recipe) }.to raise_error(Chef::Exceptions::ValidationFailed,
      'Option persona must be equal to one of: GENERIC, GENERIC_ALUA, GENERIC_LEGACY, HPUX_LEGACY, AIX_LEGACY, EGENERA, ONTAP_LEGACY, VMWARE, OPENVMS, HPUX, WINDOWS_SERVER!  You passed "DUMMY".')
  end
end
