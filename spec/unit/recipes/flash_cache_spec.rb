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

describe 'hpe3par::flash_cache' do

  let(:chef_run) do
    ChefSpec::SoloRunner.new(platform: PLATFORM, version: PLATFORM_VERSION,
                             step_into: ['flah_cache']) do |node|
   node.override['hpe3par']['storage_system'] = {
       name: 'MY_3PAR',
       ip: '1.1.1.1.1',
       user: 'chef',
       password: 'chef'
   }
    node.override['hpe3par']['flash_cache']['size_in_gib'] = 64
    end.converge(described_recipe)
  end

  it 'creates the flash cache through create_flash_cache' do
    expect(chef_run).to create_hpe3par_flash_cache('Create flash cache')
  end

  it 'deletes the flash cache through delete_flash_cache' do
    expect(chef_run).to delete_hpe3par_flash_cache('Delete flash cache')
  end

end
