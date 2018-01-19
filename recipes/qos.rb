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

hpe3par_qos node['hpe3par']['qos']['create']['qos_target_name'] do
  storage_system node['hpe3par']['storage_system']
  type node['hpe3par']['qos']['create']['type']
  bwmin_goal_kb node['hpe3par']['qos']['create']['bwmin_goal_kb']
  bwmin_goal_op node['hpe3par']['qos']['create']['bwmin_goal_op']
  bwmax_limit_kb node['hpe3par']['qos']['create']['bwmax_limit_kb']
  bwmax_limit_op node['hpe3par']['qos']['create']['bwmax_limit_op']
  priority node['hpe3par']['qos']['create']['priority']
  iomin_goal node['hpe3par']['qos']['create']['iomin_goal']
  iomin_goal_op node['hpe3par']['qos']['create']['iomin_goal_op']
  iomax_limit node['hpe3par']['qos']['create']['iomax_limit']
  iomax_limit_op node['hpe3par']['qos']['create']['iomax_limit_op']
  default_latency node['hpe3par']['qos']['create']['default_latency']
  latency_goal node['hpe3par']['qos']['create']['latency_goal']
  latency_goal_usecs node['hpe3par']['qos']['create']['latency_goal_usecs']
  enable node['hpe3par']['qos']['create']['enable']
  action :create
end

hpe3par_qos node['hpe3par']['qos']['modify']['qos_target_name'] do
  storage_system node['hpe3par']['storage_system']
  type node['hpe3par']['qos']['modify']['type']
  enable node['hpe3par']['qos']['modify']['enable']
  priority node['hpe3par']['qos']['modify']['priority']
  bwmin_goal_kb node['hpe3par']['qos']['modify']['bwmin_goal_kb']
  bwmax_limit_kb node['hpe3par']['qos']['modify']['bwmax_limit_kb']
  iomin_goal node['hpe3par']['qos']['modify']['iomin_goal']
  iomax_limit node['hpe3par']['qos']['modify']['iomax_limit']
  bwmin_goal_op node['hpe3par']['qos']['modify']['bwmin_goal_op']
  bwmax_limit_op node['hpe3par']['qos']['modify']['bwmax_limit_op']
  iomin_goal_op node['hpe3par']['qos']['modify']['iomin_goal_op']
  iomax_limit_op node['hpe3par']['qos']['modify']['iomax_limit_op']
  latency_goal node['hpe3par']['qos']['modify']['latency_goal']
  default_latency node['hpe3par']['qos']['modify']['default_latency']
  latency_goal_usecs node['hpe3par']['qos']['modify']['latency_goal_usecs']
  action :modify
end

hpe3par_qos node['hpe3par']['qos']['delete']['qos_target_name'] do
  storage_system node['hpe3par']['storage_system']
  type node['hpe3par']['qos']['delete']['type'] 
  action :delete
end
