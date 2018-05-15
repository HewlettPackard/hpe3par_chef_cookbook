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

actions :create, :delete, :modify, :add_fc_path_to_host, :remove_fc_path_from_host, :add_iscsi_path_to_host, :remove_iscsi_path_from_host, :add_initiator_chap, :remove_initiator_chap, :add_target_chap,:remove_target_chap
default_action :create

property :host_name, kind_of: String, required: true, name_property: true, callbacks: {
  'Name of the Host should not exceed 31 characters' => lambda {
    |name| name.length > 0 && name.length < 32
  }
}
property :storage_system, kind_of: Hash, required: true
property :domain, kind_of: String, default: nil
property :fc_wwns, kind_of: Array, default: nil
property :iscsi_names, kind_of: Array, default: nil
property :persona, kind_of: String, equal_to: %w[GENERIC GENERIC_ALUA GENERIC_LEGACY HPUX_LEGACY AIX_LEGACY EGENERA ONTAP_LEGACY VMWARE OPENVMS HPUX WINDOWS_SERVER]
property :new_name, kind_of: String, default: nil
property :force_path_removal, kind_of: [TrueClass, FalseClass], default: nil
property :chap_name, kind_of: String, default: nil
property :chap_secret, kind_of: String, default: nil
property :chap_secret_hex, kind_of: [TrueClass, FalseClass], default: nil
property :debug, kind_of: [TrueClass, FalseClass], default: false
