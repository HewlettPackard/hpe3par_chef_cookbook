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

actions :create_offline, :create_online, :delete, :resync, :stop
default_action :create_offline
property :storage_system, kind_of: Hash, required: true
property :base_volume_name, kind_of: String
property :clone_name, kind_of: String, required: true, name_property: true, callbacks: {
  'Name of the clone should not exceed 31 characters' => lambda {
    |name| name.length > 0 && name.length < 32
  }
}
property :dest_cpg, kind_of: String
property :online, kind_of: [TrueClass, FalseClass]
property :read_only, kind_of: [TrueClass, FalseClass]
property :tpvv, kind_of: [TrueClass, FalseClass]
property :tdvv, kind_of: [TrueClass, FalseClass]
property :snap_cpg, kind_of: String
property :skip_zero, kind_of: [TrueClass, FalseClass]
property :compression, kind_of: [TrueClass, FalseClass]
property :save_snapshot, kind_of: [TrueClass, FalseClass]
property :priority, kind_of: String, default: 'MEDIUM', equal_to: %w[HIGH MEDIUM LOW]
property :debug, kind_of: [TrueClass, FalseClass], default: false