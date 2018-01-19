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

if defined?(ChefSpec)
  def create_hpe3par_virtual_volume(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:hpe3par_virtual_volume, :create, resource_name)
  end

  def delete_hpe3par_virtual_volume(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:hpe3par_virtual_volume, :delete, resource_name)
  end

  def grow_hpe3par_virtual_volume(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:hpe3par_virtual_volume, :grow, resource_name)
  end
  
  def grow_to_size_hpe3par_virtual_volume(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:hpe3par_virtual_volume, :grow_to_size, resource_name)
  end

  def change_snap_cpg_hpe3par_virtual_volume(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:hpe3par_virtual_volume, :change_snap_cpg, resource_name)
  end

  def change_user_cpg_hpe3par_virtual_volume(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:hpe3par_virtual_volume, :change_user_cpg, resource_name)
  end

  def convert_type_hpe3par_virtual_volume(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:hpe3par_virtual_volume, :convert_type, resource_name)
  end

  def create_hpe3par_cpg(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:hpe3par_cpg, :create, resource_name)
  end

  def delete_hpe3par_cpg(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:hpe3par_cpg, :delete, resource_name)
  end

  def create_hpe3par_flash_cache(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:hpe3par_flash_cache, :create, resource_name)
  end

  def delete_hpe3par_flash_cache(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:hpe3par_flash_cache, :delete, resource_name)
  end

  def export_volume_to_host_hpe3par_vlun(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:hpe3par_vlun, :export_volume_to_host, resource_name)
  end

  def unexport_volume_to_host_hpe3par_vlun(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:hpe3par_vlun, :unexport_volume_to_host, resource_name)
  end

  def export_volume_to_hostset_hpe3par_vlun(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:hpe3par_vlun, :export_volume_to_hostset, resource_name)
  end

  def unexport_volume_to_hostset_hpe3par_vlun(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:hpe3par_vlun, :unexport_volume_to_hostset, resource_name)
  end


  def export_volumeset_to_host_hpe3par_vlun(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:hpe3par_vlun, :export_volumeset_to_host, resource_name)
  end

  def unexport_volumeset_to_host_hpe3par_vlun(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:hpe3par_vlun, :unexport_volumeset_to_host, resource_name)
  end

  def export_volumeset_to_hostset_hpe3par_vlun(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:hpe3par_vlun, :export_volumeset_to_hostset, resource_name)
  end

  def unexport_volumeset_to_hostset_hpe3par_vlun(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:hpe3par_vlun, :unexport_volumeset_to_hostset, resource_name)
  end

  def create_hpe3par_qos(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:hpe3par_qos, :create, resource_name)
  end

  def modify_hpe3par_qos(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:hpe3par_qos, :modify, resource_name)
  end

  def delete_hpe3par_qos(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:hpe3par_qos, :delete, resource_name)
  end

  def create_hpe3par_host_set(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:hpe3par_host_set, :create, resource_name)
  end

  def delete_hpe3par_host_set(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:hpe3par_host_set, :delete, resource_name)
  end

  def add_hosts_hpe3par_host_set(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:hpe3par_host_set, :add_host, resource_name)
  end

  def remove_hosts_hpe3par_host_set(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:hpe3par_host_set, :remove_host, resource_name)
  end

  def create_hpe3par_host(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:hpe3par_host, :create, resource_name)
  end

  def remove_fc_path_from_host_hpe3par_host(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:hpe3par_host, :remove_fc_path_from_host, resource_name)
  end

  def add_fc_path_to_host_hpe3par_host(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:hpe3par_host, :add_fc_path_to_host, resource_name)
  end

  def add_iscsi_path_to_host_hpe3par_host(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:hpe3par_host, :add_iscsi_path_to_host, resource_name)
  end

  def remove_iscsi_path_from_host_hpe3par_host(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:hpe3par_host, :remove_iscsi_path_from_host, resource_name)
  end

  def modify_hpe3par_host(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:hpe3par_host, :modify, resource_name)
  end

  def add_initiator_chap_hpe3par_host(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:hpe3par_host, :add_initiator_chap, resource_name)
  end

  def add_target_chap_hpe3par_host(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:hpe3par_host, :add_target_chap, resource_name)
  end

  def remove_target_chap_hpe3par_host(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:hpe3par_host, :remove_target_chap, resource_name)
  end

  def remove_initiator_chap_hpe3par_host(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:hpe3par_host, :remove_initiator_chap, resource_name)
  end

  def delete_hpe3par_host(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:hpe3par_host, :delete, resource_name)
  end
  
  def create_hpe3par_volume_set(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:hpe3par_volume_set, :create, resource_name)
  end

  def delete_hpe3par_volume_set(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:hpe3par_volume_set, :delete, resource_name)
  end

  def add_volume_hpe3par_volume_set(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:hpe3par_volume_set, :add_volume, resource_name)
  end

  def remove_volume_hpe3par_volume_set(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:hpe3par_volume_set, :remove_volume, resource_name)
  end
  
  def create_hpe3par_snapshot(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:hpe3par_snapshot, :create, resource_name)
  end

  def delete_hpe3par_snapshot(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:hpe3par_snapshot, :delete, resource_name)
  end

  def modify_hpe3par_snapshot(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:hpe3par_snapshot, :modify, resource_name)
  end
  
  def restore_hpe3par_online_snapshot(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:hpe3par_snapshot, :restore_online, resource_name)
  end
  
  def restore_hpe3par_offline_snapshot(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:hpe3par_snapshot, :restore_offline, resource_name)
  end

  def create_offline_hpe3par_clone(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:hpe3par_clone, :create_online, resource_name)
  end

  def create_offline_hpe3par_clone(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:hpe3par_clone, :create_offline, resource_name)
  end
  
  def resync_hpe3par_clone(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:hpe3par_clone, :rersync, resource_name)
  end

  def stop_hpe3par_clone(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:hpe3par_clone, :stop, resource_name)
  end

  def delete_hpe3par_clone(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:hpe3par_clone, :delete, resource_name)
  end

end