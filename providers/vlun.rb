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

 action :export_volume_to_host do
 # validations
   if new_resource.host_name.nil? && (new_resource.node_val.nil? &&  new_resource.slot.nil? && new_resource.card_port.nil?)
     fail ArgumentError, 'Attribute host_name or port positions or both need to be specified to create a vlun'
   end
   if new_resource.host_name.nil?
     if new_resource.node_val.nil? ||  new_resource.slot.nil? || new_resource.card_port.nil?
      fail ArgumentError, 'Node, Slot and Port need to be specified to create a vlun'
     end
   end
   
   if (!new_resource.autolun and
       !vlun_exists?(new_resource.storage_system,
                     new_resource.volume_name,new_resource.lunid,
                     new_resource.host_name,
                     new_resource.node_val,
                     new_resource.slot,
                     new_resource.card_port, new_resource.debug)) or new_resource.autolun
       converge_by("Export volume #{new_resource.volume_name} to host #{new_resource.host_name}") do
          create_vlun(new_resource.storage_system, new_resource.volume_name,
                                 new_resource.lunid, new_resource.host_name, new_resource.node_val,
                                 new_resource.slot, new_resource.card_port, new_resource.autolun,
                      new_resource.debug)
          end
     else
        Chef::Log.info("Lun for   #{new_resource.volume_name}  exists. Nothing to do.")
end
end

action :export_volume_to_hostset do
  # validations
  fail ArgumentError, 'Attribute volume name is required for vlun creation' unless new_resource.volume_name
  fail ArgumentError, 'Attribute hostset_name is required to export a vlun' unless new_resource.hostset_name
  if !new_resource.hostset_name.empty?
     new_resource.hostset_name = "set:"+ new_resource.hostset_name
  end
  if (!new_resource.autolun and
      !vlun_exists?(new_resource.storage_system, new_resource.volume_name,new_resource.lunid,
                    new_resource.hostset_name, new_resource.node_val, new_resource.slot,
                    new_resource.card_port, new_resource.debug)) or
      new_resource.autolun
    converge_by("Export volume #{new_resource.volume_name} to hostset #{new_resource.hostset_name}") do
      create_vlun(new_resource.storage_system, new_resource.volume_name, new_resource.lunid,
                  new_resource.hostset_name,new_resource.node_val, new_resource.slot, new_resource.card_port,
                  new_resource.autolun, new_resource.debug)
     end
    else
     Chef::Log.info("Lun for   #{new_resource.volume_name}  exists. Nothing to do.")
  end
end

action :export_volumeset_to_host do
  # validations
  fail ArgumentError, 'Attribute volumeset name is required for vlun creation' unless new_resource.volumeset_name
  if new_resource.host_name.nil? && (new_resource.node_val.nil? &&  new_resource.slot.nil? && new_resource.card_port.nil?)
    fail ArgumentError, 'Attribute host_name or port positions are required to create a vlun'
  end
  if new_resource.host_name.nil?
    if new_resource.node_val.nil? ||  new_resource.slot.nil? || new_resource.card_port.nil?
      fail ArgumentError, 'All port positions (node,slot,cardport) are required to create a vlun'
    end
  end
  if !new_resource.volumeset_name.empty?
    new_resource.volumeset_name = "set:" + new_resource.volumeset_name
  end
  
  if (!new_resource.autolun and !vlun_exists?(new_resource.storage_system, new_resource.volume_name,new_resource.lunid,
                                              new_resource.host_name, new_resource.node_val, new_resource.slot,
                                              new_resource.card_port, new_resource.debug)) or new_resource.autolun
    converge_by("Export volumeset #{new_resource.volumeset_name} to host #{new_resource.host_name}") do
    create_vlun(new_resource.storage_system, new_resource.volumeset_name, new_resource.lunid,
                new_resource.host_name, new_resource.node_val, new_resource.slot,
                new_resource.card_port, new_resource.autolun, new_resource.debug)
      end
    else
     Chef::Log.info("Lun for   #{new_resource.volume_name}  exists. Nothing to do.")
  end
end

action :export_volumeset_to_hostset do
  # validations
  fail ArgumentError, 'Attribute volumeset is required for vlun creation' unless new_resource.volumeset_name
  fail ArgumentError, 'Attribute hostset_name is required for vlun creation' unless new_resource.hostset_name
  if !new_resource.volumeset_name.empty? && !new_resource.hostset_name.empty?
    new_resource.volumeset_name = "set:" + new_resource.volumeset_name
    new_resource.hostset_name = "set:" + new_resource.hostset_name
  end
  if (!new_resource.autolun and !vlun_exists?(new_resource.storage_system, new_resource.volumeset_name,
                                              new_resource.lunid, new_resource.hostset_name, new_resource.node_val,
                                              new_resource.slot, new_resource.card_port, new_resource.debug)) or new_resource.autolun
  converge_by("Export volumeset #{new_resource.volumeset_name} to hostset #{new_resource.hostset_name}") do
    create_vlun(new_resource.storage_system, new_resource.volumeset_name, new_resource.lunid,
                new_resource.hostset_name,  new_resource.node_val, new_resource.slot,
                new_resource.card_port, new_resource.autolun, new_resource.debug)
      end
      else
     Chef::Log.info("Lun for   #{new_resource.volume_name}  exists. Nothing to do.")
  end
end


 action :unexport_volume_to_host do
  # validations
  fail ArgumentError, 'Attribute volume name is required for vlun deletion' unless new_resource.volume_name
  fail ArgumentError, 'Attribute lunid is required for vlun deletion' unless new_resource.lunid
   if new_resource.host_name.nil?
     if new_resource.node_val.nil? ||  new_resource.slot.nil? || new_resource.card_port.nil?
      fail ArgumentError, 'Node, Slot and Port or host name need to be specified to unexport a vlun'
     end
   end
  if vlun_exists?(new_resource.storage_system, new_resource.volume_name,new_resource.lunid, new_resource.host_name,
                  new_resource.node_val, new_resource.slot, new_resource.card_port, new_resource.debug)
  converge_by("Unexport volume #{new_resource.volume_name} to host #{new_resource.host_name}") do
    delete_vlun(new_resource.storage_system, new_resource.volume_name, new_resource.lunid, new_resource.host_name,
                new_resource.node_val, new_resource.slot, new_resource.card_port, new_resource.debug)
  end
  else
     Chef::Log.info("vlun does not exist. Nothing to do.")
  end
 end

action :unexport_volume_to_hostset do
  # validations
  fail ArgumentError, 'Attribute volume name is required for vlun deletion' unless new_resource.volume_name
  fail ArgumentError, 'Attribute lunid is required for vlun deletion' unless new_resource.lunid
  if new_resource.hostset_name.nil?
    if new_resource.node_val.nil? ||  new_resource.slot.nil? || new_resource.card_port.nil?
     fail ArgumentError, 'Node, Slot and Port need or hostset name to be specified to unexport a vlun'
    end
  end
  if !new_resource.hostset_name.empty?
    new_resource.hostset_name = "set:" + new_resource.hostset_name
    end
    
   if vlun_exists?(new_resource.storage_system, new_resource.volume_name,new_resource.lunid, new_resource.hostset_name,
                   new_resource.node_val, new_resource.slot, new_resource.card_port, new_resource.debug)
         converge_by("Unexport volume #{new_resource.volume_name} to hostset #{new_resource.hostset_name}") do
             delete_vlun(new_resource.storage_system, new_resource.volume_name, new_resource.lunid,
                         new_resource.hostset_name, new_resource.debug)
          end
    else
      Chef::Log.info("vlun does not exist. Nothing to do.")
    end
  end

action :unexport_volumeset_to_host do
  # validations
  fail ArgumentError, 'Attribute volumeset name is required for vlun deletion' unless new_resource.volumeset_name
  fail ArgumentError, 'Attribute lunid is required for vlun deletion' unless new_resource.lunid
  if new_resource.host_name.nil?
    if new_resource.node_val.nil? ||  new_resource.slot.nil? || new_resource.card_port.nil?
     fail ArgumentError, 'Node, Slot and Port need or hostname to be specified to unexport a vlun'
    end
  end
  if !new_resource.volumeset_name.empty?
    new_resource.volumeset_name = "set:" + new_resource.volumeset_name
  end
   if vlun_exists?(new_resource.storage_system, new_resource.volumeset_name,new_resource.lunid,
                   new_resource.host_name, new_resource.node_val, new_resource.slot,
                   new_resource.card_port, new_resource.debug)
  converge_by("Unexport volumeset #{new_resource.volumeset_name} to host #{new_resource.host_name}") do
    delete_vlun(new_resource.storage_system, new_resource.volumeset_name, new_resource.lunid, new_resource.host_name,
                new_resource.node_val, new_resource.slot, new_resource.card_port, new_resource.debug)
  end
    else
      Chef::Log.info("vlun does not exist. Nothing to do.")
    end
end

action :unexport_volumeset_to_hostset do
  # validations
  fail ArgumentError, 'Attribute volumeset name is required for vlun deletion' unless new_resource.volumeset_name
  fail ArgumentError, 'Attribute lunid is required for vlun deletion' unless new_resource.lunid
  if new_resource.hostset_name.nil?
    if new_resource.node_val.nil? ||  new_resource.slot.nil? || new_resource.card_port.nil?
     fail ArgumentError, 'Node, Slot and Port need or hostset_name to be specified to unexport a vlun'
    end
  end
  if !new_resource.hostset_name.empty? && !new_resource.volumeset_name.empty?
    new_resource.volumeset_name = "set:" + new_resource.volumeset_name
    new_resource.hostset_name = "set:" + new_resource.hostset_name
  end
 if vlun_exists?(new_resource.storage_system, new_resource.volumeset_name, new_resource.lunid,
                 new_resource.hostset_name, new_resource.node_val, new_resource.slot,
                 new_resource.card_port, new_resource.debug)
  converge_by("Unexport volumeset #{new_resource.volumeset_name} to hostset #{new_resource.volumeset_name}") do
    delete_vlun(new_resource.storage_system, new_resource.volumeset_name,
                new_resource.lunid, new_resource.hostset_name, new_resource.debug)
  end
  else
    Chef::Log.info("vlun does not exist. Nothing to do.")
end
end