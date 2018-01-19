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

include HPE3PAR::RestHelper

use_inline_resources

action :create do
 # validations
   fail ArgumentError, 'Attribute target name is required for qos creation' unless new_resource.qos_target_name
   if !new_resource.latency_goal.nil? and !new_resource.latency_goal_usecs.nil?
     fail ArgumentError, 'Attributes latency_goal and latency_goal_usecs cannot be given at the same time for qos rules creation'
   end
   if !qos_rule_exists?(new_resource.storage_system,  new_resource.qos_target_name, new_resource.type, new_resource.debug)
      converge_by("Create QoS on target #{new_resource.qos_target_name}") do
        create_qos_rules(new_resource.storage_system, new_resource.qos_target_name, new_resource.type,
                         new_resource.priority, new_resource.bwmin_goal_kb, new_resource.bwmax_limit_kb,
                         new_resource.iomin_goal, new_resource.iomax_limit, new_resource.bwmin_goal_op,
                         new_resource.bwmax_limit_op, new_resource.iomin_goal_op, new_resource.iomax_limit_op,
                         new_resource.latency_goal, new_resource.default_latency, new_resource.enable,
                         new_resource.latency_goal_usecs, new_resource.debug)
      end
   else
      Chef::Log.info("qos rule for  #{new_resource.qos_target_name} already exists. Nothing to do.")
   end
end

action :delete do
   fail ArgumentError, 'Attribute target name is required for qos deletion' unless new_resource.qos_target_name
   if qos_rule_exists?(new_resource.storage_system,  new_resource.qos_target_name,
                       new_resource.type, new_resource.debug)
     converge_by("Delete QoS on target #{new_resource.qos_target_name}") do
       delete_qos_rules(new_resource.storage_system, new_resource.qos_target_name,
                        new_resource.type, new_resource.debug)
     end
   else
     Chef::Log.info("qos rule for  #{new_resource.qos_target_name}does not  exists. Nothing to do.")
  end
end

action :modify do
   fail ArgumentError, 'Attribute target name is required for qos creation' unless new_resource.qos_target_name
   converge_by("Modify QoS on target #{new_resource.qos_target_name}") do
     modify_qos_rules(new_resource.storage_system, new_resource.qos_target_name,
                      new_resource.type, new_resource.priority, new_resource.bwmin_goal_kb,
                      new_resource.bwmax_limit_kb, new_resource.iomin_goal, new_resource.iomax_limit,
                      new_resource.bwmin_goal_op, new_resource.bwmax_limit_op, new_resource.iomin_goal_op,
                      new_resource.iomax_limit_op, new_resource.latency_goal, new_resource.default_latency,
                      new_resource.enable, new_resource.latency_goal_usecs, new_resource.debug)
   end
end
