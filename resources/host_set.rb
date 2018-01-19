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

actions :create, :delete, :add_host, :remove_host
default_action :create

property :storage_system, kind_of: Hash, required: true
property :host_set_name, kind_of: String, required: true, name_attribute: true, callbacks: {
  'Name of the Host set should not exceed 27 characters' => lambda {
    |name| name.length > 0 && name.length < 28
  }
}
property :domain, kind_of: String, default: nil
property :setmembers, kind_of: Array, default: nil
property :debug, kind_of: [TrueClass, FalseClass], default: false
