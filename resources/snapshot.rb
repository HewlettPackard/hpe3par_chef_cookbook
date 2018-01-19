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

actions :create, :delete, :modify, :restore_online, :restore_offline
default_action :create
property :storage_system, kind_of: Hash, required: true
property :snapshot_name, kind_of: String, required: true, name_attribute: true, callbacks: {
  'Name of the snapshot should not exceed 31 characters' => lambda {
    |name| name.length > 0 && name.length < 32
  }
}
property :base_volume_name, kind_of: String
property :read_only, kind_of: [TrueClass, FalseClass]
property :expiration_time, kind_of: Integer
property :retention_time, kind_of: Integer
property :expiration_unit, kind_of: String, default: 'Hours', equal_to: %w[Hours Days]
property :retention_unit, kind_of: String, default: 'Hours', equal_to: %w[Hours Days]
property :expiration_hours, kind_of: Integer, default: 0
property :retention_hours, kind_of: Integer, default: 0
property :online, kind_of: [TrueClass, FalseClass]
property :priority, kind_of: String, default: 'MEDIUM', equal_to: %w[HIGH MEDIUM LOW]
property :allow_remote_copy_parent, kind_of: [TrueClass, FalseClass]
property :new_name, kind_of: String
property :snap_cpg, kind_of: String
property :rm_exp_time, kind_of: [TrueClass, FalseClass]
property :debug, kind_of: [TrueClass, FalseClass], default: false
