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

describe 'hpe3par::cpg' do

  let(:chef_run) do
    ChefSpec::SoloRunner.new(platform: PLATFORM, version: PLATFORM_VERSION,
                             step_into: ['cpg']) do |node|
      #CPG
      node.normal['hpe3par']['storage_system'] = {
          name: 'SRA_205',
          ip: '16.192.67.205',
          user: '3par_user',
          password: 'password'
      }
      node.normal['hpe3par']['cpg']['create']['name'] = 'test_3par_tryone'
      node.normal['hpe3par']['cpg']['create']['domain'] = 'Chef_Test'
      node.normal['hpe3par']['cpg']['create']['growth_increment'] = 32768.0
      node.normal['hpe3par']['cpg']['create']['growth_increment_unit'] = 'MiB'
      node.normal['hpe3par']['cpg']['create']['growth_limit'] = 65536.0
      node.normal['hpe3par']['cpg']['create']['growth_limit_unit'] = 'MiB'
      node.normal['hpe3par']['cpg']['create']['growth_warning'] = 51200.0
      node.normal['hpe3par']['cpg']['create']['growth_warning_unit'] = 'MiB'
      node.normal['hpe3par']['cpg']['create']['raid_type'] = 'R6'
      node.normal['hpe3par']['cpg']['create']['set_size'] = 8
      node.normal['hpe3par']['cpg']['create']['high_availability'] = 'MAG'
      node.normal['hpe3par']['cpg']['create']['disk_type'] = 'FC'
        
      node.normal['hpe3par']['cpg']['delete']['name'] = 'test_3par_tryone'

    end.converge(described_recipe)
  end

  it 'creates the cpg through create_cpg' do
    expect(chef_run).to create_hpe3par_cpg(chef_run.node['hpe3par']['cpg']['create']['name'])
  end

  it 'deletes the cpg through delete_cpg' do
    expect(chef_run).to delete_hpe3par_cpg(chef_run.node['hpe3par']['cpg']['delete']['name'])
  end

  it 'create CPG with invalid raid type ' do
    chef_run.node.normal['hpe3par']['cpg']['create']['raid_type'] = 'R99'
    expect { chef_run.converge(described_recipe) }.to raise_error(Chef::Exceptions::ValidationFailed,
      'Option raid_type must be equal to one of: R0, R1, R5, R6!  You passed "R99".')
  end

  it 'create CPG with invalid HA ' do
    chef_run.node.normal['hpe3par']['cpg']['create']['high_availability'] = 'INVALID'
    expect { chef_run.converge(described_recipe) }.to raise_error(Chef::Exceptions::ValidationFailed,
      'Option high_availability must be equal to one of: PORT, CAGE, MAG!  You passed "INVALID".')
  end

  it 'create CPG with invalid Growth Increment Unit ' do
    chef_run.node.normal['hpe3par']['cpg']['create']['growth_increment_unit'] = 'INVALID'
    expect { chef_run.converge(described_recipe) }.to raise_error(Chef::Exceptions::ValidationFailed,
      'Option growth_increment_unit must be equal to one of: TiB, GiB, MiB!  You passed "INVALID".')
  end

  it 'create CPG with invalid Growth Limit Unit ' do
    chef_run.node.normal['hpe3par']['cpg']['create']['growth_limit_unit'] = 'INVALID'
  expect { chef_run.converge(described_recipe) }.to raise_error(Chef::Exceptions::ValidationFailed,
    'Option growth_limit_unit must be equal to one of: TiB, GiB, MiB!  You passed "INVALID".')
  end

  it 'create CPG with invalid Growth Warning Unit ' do
    chef_run.node.normal['hpe3par']['cpg']['create']['growth_warning_unit'] = 'INVALID'
    expect { chef_run.converge(described_recipe) }.to raise_error(Chef::Exceptions::ValidationFailed, 
      'Option growth_warning_unit must be equal to one of: TiB, GiB, MiB!  You passed "INVALID".')    
  end
end
