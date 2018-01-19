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

actions :create, :delete
default_action :create

property :cpg_name, kind_of: String, required: true, name_attribute: true, callbacks: {
  'Name of the CPG should not exceed 31 characters' => lambda {
    |name| name.length > 0 && name.length < 32
  }
}
property :storage_system, kind_of: Hash, required: true
property :domain, kind_of: String
property :growth_increment , kind_of:Float, default: -1.0
property :growth_increment_unit, kind_of:String,default: 'GiB',equal_to: %w[TiB GiB MiB]
property :growth_limit, kind_of:Float, default: -1.0
property :growth_limit_unit, kind_of:String, default: 'GiB',equal_to: %w[TiB GiB MiB]
property :growth_warning, kind_of:Float, default: -1.0
property :growth_warning_unit, kind_of:String, default: 'GiB',equal_to: %w[TiB GiB MiB]
property :raid_type, kind_of:String, equal_to: %w[R0 R1 R5 R6]
property :set_size, kind_of: Integer, default: -1
property :high_availability, kind_of: String, equal_to: %w[PORT CAGE MAG]
property :disk_type, kind_of: String, equal_to: %w[FC NL SSD]
property :debug, kind_of: [TrueClass, FalseClass], default: false
