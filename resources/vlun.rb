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

actions :export_volume_to_host, :export_volume_to_hostset, :export_volumeset_to_host,
        :export_volumeset_to_hostset, :unexport_volume_to_host, :unexport_volume_to_hostset,
        :unexport_volumeset_to_host, :unexport_volumeset_to_hostset
default_action :export_volume_to_host

property :volume_name, kind_of: String, required: true,name_property: true
property :lunid, kind_of: Integer
property :storage_system, kind_of: Hash, required: true
property :volumeset_name, kind_of: String
property :hostset_name, kind_of: String
property :host_name, kind_of: String
property :node_val, kind_of: Integer
property :slot, kind_of: Integer
property :card_port, kind_of: Integer
property :autolun, kind_of: [TrueClass, FalseClass], :default => true
property :debug, kind_of: [TrueClass, FalseClass], default: false