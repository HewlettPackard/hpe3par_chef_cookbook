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

actions :create, :delete, :modify, :grow, :grow_to_size, :change_snap_cpg, :change_user_cpg, :convert_type, :set_snap_cpg
default_action :create

property :volume_name, kind_of: String, required: true, name_attribute: true, callbacks: {
  'Name of the volume should not exceed 31 characters' => lambda {
    |name| name.length > 0 && name.length < 32
  }
}
property :cpg, kind_of: String
property :size, kind_of: Float
property :size_unit, kind_of: String, default: 'GiB', equal_to: %w(TiB GiB MiB)
property :storage_system, kind_of: Hash, required: true
property :type, kind_of: String, default: 'thin', equal_to: %w(thin thin_dedupe full)
property :snap_cpg, kind_of: String
property :compression, kind_of: [TrueClass, FalseClass], default: false
property :keep_vv, kind_of: String
property :new_name, kind_of: String
property :wait_for_task_to_end, kind_of: [TrueClass, FalseClass], default: false

#Volume modify properties
property :ss_spc_alloc_warning_pct, kind_of: Integer, default: 0
property :ss_spc_alloc_limit_pct, kind_of: Integer, default: 0
property :rm_ss_spc_alloc_warning, kind_of: [TrueClass, FalseClass], default: false


property :usr_spc_alloc_warning_pct, kind_of: Integer, default: 0
property :usr_spc_alloc_limit_pct, kind_of: Integer, default: 0
property :rm_usr_spc_alloc_warning, kind_of: [TrueClass, FalseClass], default: false

property :expiration_hours, kind_of: Integer, default: 0
property :retention_hours, kind_of: Integer, default: 0

property :rm_exp_time, kind_of: [TrueClass, FalseClass], default: false

property :rm_ss_spc_alloc_limit, kind_of: [TrueClass, FalseClass], default: false
property :rm_usr_spc_alloc_limit, kind_of: [TrueClass, FalseClass], default: false
property :debug, kind_of: [TrueClass, FalseClass], default: false


