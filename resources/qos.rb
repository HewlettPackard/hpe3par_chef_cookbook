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

actions :create, :delete, :modify
default_action :create

property :qos_target_name, kind_of: String, required: true, name_attribute: true
property :storage_system, kind_of: Hash, required: true
property :type, kind_of: String, equal_to: %w[vvset sys]
property :priority, kind_of: String, default:'LOW', equal_to: %w[LOW NORMAL HIGH]
property :bwmin_goal_kb, kind_of: Integer, default:-1
property :bwmax_limit_kb, kind_of: Integer, default:-1
property :iomin_goal, kind_of: Integer, default:-1
property :iomax_limit, kind_of: Integer , default:-1
property :bwmin_goal_op, kind_of: String, equal_to: %w[ZERO NOLIMIT]
property :bwmax_limit_op, kind_of: String ,equal_to: %w[ZERO NOLIMIT]
property :iomin_goal_op, kind_of: String ,equal_to: %w[ZERO NOLIMIT]
property :iomax_limit_op, kind_of: String ,equal_to: %w[ZERO NOLIMIT]
property :latency_goal, kind_of: Integer
property :default_latency, kind_of: [TrueClass, FalseClass], :default => false
property :enable, kind_of: [TrueClass, FalseClass],:default => false
property :latency_goal_usecs, kind_of: Integer
property :debug, kind_of: [TrueClass, FalseClass], default: false