# HPE 3PAR Cookbook for Chef

The hpe3par cookbook is a starter kit which provides types and providers, using which you can write recipes to manage HPE 3PAR storage arrays.
This cookbook uses the hpe3par_sdk to communicate with the 3PAR storage arrays over http/https through the WSAPI REST service
hosted on the array.

This cookbook is not intended to include any recipes. Use it by creating a new cookbook and specifying a dependency on this cookbook in your metadata. Then use any of the resources provided by this cookbook.

**Note: The cookbook name is 'hpe3par'. If you want to directly use from source, you need to rename the directory hpe3par_chef_cookbook to hpe3par in order to use the resources.**

# Requirements
* 3PAR OS
  * 3.2.2 MU4, MU6
  * 3.3.1 MU1, MU2
* Ruby - 2.4.x
* Chef - 12.x
* WSAPI service should be enabled on the 3PAR storage array.

# Usage
Add the following line to the <code>metadata.rb</code> file of your cookbook

```
 # my_cookbook/metadata.rb
 ...
 depends 'hpe3par'
```
Now, you can utilize the hpe3par cookbook resources in your recipes, for ex:

Creating a Virtual Volume

```ruby
hpe3par_virtual_volume node['hpe3par']['virtual_volume']['name'] do
  storage_system node['hpe3par']['storage_system']
  cpg node['hpe3par']['virtual_volume']['cpg']
  size node['hpe3par']['virtual_volume']['size']
  size_unit node['hpe3par']['virtual_volume']['size_unit']
  type node['hpe3par']['virtual_volume']['type']
  action :create
end
```

# HPE 3PAR Connection settings
The connection settings for connecting to a 3PAR array are defined through attributes. Every hpe3ar resource has a <code>storage_system</code> attribute which represents the connection to the 3PAR array. The attribute definition for this is as follows:

```ruby
node['hpe3par']['storage_system'] = {
    name: 'SRA_205',
    ip: '16.192.67.205',
    user: '3par_user',
    password: 'password'
}
```


# Recipes
These are intended as samples/reference only and can be found in the recipes folder. These recipes list out
all of the actions for each resource.

* hpe3par::clone
* hpe3par::cpg
* hpe3par::flash_cache
* hpe3par::host
* hpe3par::host_set
* hpe3par::qos
* hpe3par::snapshot
* hpe3par::virtual_volume
* hpe3par::vlun
* hpe3par::volume_set

# Resources
All of the resources have a <code>debug</code> parameter which can be set to <code>true</code> to enable debug logs or <code>false</code> to disable debug logs

* [hpe3par_clone](#hpe3par_clone)
* [hpe3par_cpg](#hpe3par_cpg)
* [hpe3par_flash_cache](#hpe3par_flash_cache)
* [hpe3par_host](#hpe3par_host)
* [hpe3par_host_set](#hpe3par_host_set)
* [hpe3par_qos](#hpe3par_qos)
* [hpe3par_snapshot](#hpe3par_snapshot)
* [hpe3par_virtual_volume](#hpe3par_virtual_volume)
* [hpe3par_vlun](#hpe3par_vlun)
* [hpe3par_volume_set](#hpe3par_volume_set)

## hpe3par_clone

### Actions

- create_offline:  Default action.
- create_online
- delete
- resync
- stop

### Attribute Parameters

- [storage_system](#hpe-3par-connection-settings): Hash (Required)
- base_volume_name: String (Required)
- clone_name: String (Required)
- dest_cpg: String
- online: Boolean
- read_only: Boolean
- tpvv: Boolean
- tdvv: Boolean
- snap_cpg: String
- skip_zero: Boolean
- compression: Boolean
- save_snapshot: Boolean
- priority: String, Defaults to <code>"MEDIUM"</code>.
- debug: Boolean, Defaults to <code>false</code>.

## hpe3par_cpg

### Actions

- create:  Default action.
- delete

### Attribute Parameters

- cpg_name: String (Required)
- [storage_system](#hpe-3par-connection-settings): Hash (Required)
- domain: String
- growth_increment: Float, Defaults to <code>-1.0</code>.
- growth_increment_unit: String, Defaults to <code>"GiB"</code>.
- growth_limit: Float, Defaults to <code>-1.0</code>.
- growth_limit_unit: String, Defaults to <code>"GiB"</code>.
- growth_warning: Float, Defaults to <code>-1.0</code>.
- growth_warning_unit: String, Defaults to <code>"GiB"</code>.
- raid_type: String
- set_size: Integer, Defaults to <code>-1</code>.
- high_availability: String
- disk_type: String
- debug: Boolean, Defaults to <code>false</code>.

## hpe3par_flash_cache

### Actions

- create:  Default action.
- delete

### Attribute Parameters

- [storage_system](#hpe-3par-connection-settings): Hash (Required)
- size_in_gib: Integer (Required)
- mode: Integer
- debug: Boolean, Defaults to <code>false</code>.

## hpe3par_host

### Actions

- create:  Default action.
- add_fc_path_to_host
- add_initiator_chap
- add_iscsi_path_to_host
- add_target_chap
- delete
- modify
- remove_fc_path_from_host
- remove_initiator_chap
- remove_iscsi_path_from_host
- remove_target_chap

### Attribute Parameters

- [storage_system](#hpe-3par-connection-settings): Hash (Required)
- host_name: String (Required)
- domain: String, Defaults to <code>nil</code>.
- fc_wwns: Array, Defaults to <code>nil</code>.
- iscsi_names: Array, Defaults to <code>nil</code>.
- persona: String
- new_name: String, Defaults to <code>nil</code>.
- force_path_removal: Boolean, Defaults to <code>nil</code>.
- chap_name: String, Defaults to <code>nil</code>.
- chap_secret: String, Defaults to <code>nil</code>.
- chap_secret_hex: Boolean, Defaults to <code>nil</code>.
- debug: Boolean, Defaults to <code>false</code>.

## hpe3par_host_set

### Actions

- create:  Default action.
- add_host
- delete
- remove_host

### Attribute Parameters

- [storage_system](#hpe-3par-connection-settings): Hash (Required)
- host_set_name: String (Required)
- domain: String, Defaults to <code>nil</code>.
- setmembers: Array, Defaults to <code>nil</code>.
- debug: Boolean, Defaults to <code>false</code>

## hpe3par_qos

### Actions

- create:  Default action.
- delete
- modify

### Attribute Parameters

- [storage_system](#hpe-3par-connection-settings): Hash (Required)
- qos_target_name: String (Required)
- type: String
- priority: String, Defaults to <code>"LOW"</code>.
- bwmin_goal_kb: Integer, Defaults to <code>-1</code>.
- bwmax_limit_kb: Integer, Defaults to <code>-1</code>.
- iomin_goal: Integer, Defaults to <code>-1</code>.
- iomax_limit: Integer, Defaults to <code>-1</code>.
- bwmin_goal_op: String
- bwmax_limit_op: String
- iomin_goal_op: String
- iomax_limit_op: String
- latency_goal: Integer
- default_latency: Boolean, Defaults to <code>false</code>.
- enable: Boolean, Defaults to <code>false</code>.
- latency_goal_usecs: Integer
- debug: Boolean, Defaults to <code>false</code>.

## hpe3par_snapshot

### Actions

- create:  Default action.
- delete
- modify
- restore_offline
- restore_online

### Attribute Parameters

- [storage_system](#hpe-3par-connection-settings): Hash (Required)
- snapshot_name: String (Required)
- base_volume_name: String
- read_only: Boolean
- expiration_time: Integer
- retention_time: Integer
- expiration_unit: String, Defaults to <code>"Hours"</code>.
- retention_unit: String, Defaults to <code>"Hours"</code>.
- expiration_hours: Integer, Defaults to <code>0</code>.
- retention_hours: Integer, Defaults to <code>0</code>.
- online: Boolean
- priority: String, Defaults to <code>"MEDIUM"</code>.
- allow_remote_copy_parent: Boolean
- new_name: String
- snap_cpg: String
- rm_exp_time: Boolean
- debug: Boolean, Defaults to <code>false</code>.

## hpe3par_virtual_volume

### Actions

- create:  Default action.
- change_snap_cpg
- change_user_cpg
- convert_type
- delete
- grow: This action grows the volume <em>by</em> the specified size. This action is non-idempotent
- grow_to_size: This action grows the volume <em>to</em> the specified size. This action is idempotent
- modify
- set_snap_cpg

### Attribute Parameters

- [storage_system](#hpe-3par-connection-settings): Hash (Required)
- volume_name: String (Required)
- cpg: String
- size: Float
- size_unit: String, Defaults to <code>"GiB"</code>.
- type: String, Defaults to <code>"thin"</code>.
- snap_cpg: String
- compression: Boolean, Defaults to <code>false</code>.
- keep_vv: String
- new_name: String
- wait_for_task_to_end: Boolean, Defaults to <code>false</code>.
- ss_spc_alloc_warning_pct: Integer, Defaults to <code>0</code>.
- ss_spc_alloc_limit_pct: Integer, Defaults to <code>0</code>.
- rm_ss_spc_alloc_warning: Boolean, Defaults to <code>false</code>.
- usr_spc_alloc_warning_pct: Integer, Defaults to <code>0</code>.
- usr_spc_alloc_limit_pct: Integer, Defaults to <code>0</code>.
- rm_usr_spc_alloc_warning: Boolean, Defaults to <code>false</code>.
- expiration_hours: Integer, Defaults to <code>0</code>.
- retention_hours: Integer, Defaults to <code>0</code>.
- rm_exp_time: Boolean, Defaults to <code>false</code>.
- rm_ss_spc_alloc_limit: Boolean, Defaults to <code>false</code>.
- rm_usr_spc_alloc_limit: Boolean, Defaults to <code>false</code>.
- debug: Boolean, Defaults to <code>false</code>.

## hpe3par_vlun

### Actions

- export_volume_to_host:  Default action.
- export_volume_to_hostset
- export_volumeset_to_host
- export_volumeset_to_hostset
- unexport_volume_to_host
- unexport_volume_to_hostset
- unexport_volumeset_to_host
- unexport_volumeset_to_hostset

### Attribute Parameters

- [storage_system](#hpe-3par-connection-settings): Hash (Required)
- volume_name: String (Required)
- lunid: Integer
- volumeset_name: String
- hostset_name: String
- host_name: String
- node_val: Integer
- slot: Integer
- card_port: Integer
- autolun: Boolean, Defaults to <code>true</code>.
- debug: Boolean, Defaults to <code>false</code>.

## hpe3par_volume_set

### Actions

- create:  Default action.
- add_volume
- delete
- remove_volume

### Attribute Parameters

- [storage_system](#hpe-3par-connection-settings): Hash (Required)
- volume_set_name: String (Required)
- domain: String
- setmembers: Array
- debug: Boolean, Defaults to <code>false</code>.

Non Idempotent Actions
-----------------------------
Actions are <em>Idempotent</em> when they can be run multiple times on the same system and the results will always be identical, without producing unintended side effects.

The following actions are <b><em>non-idempotent</em></b>:

- Clone: resync, create_offline
- Snapshot: restore online, restore offline
- Virtual Volume: grow (grow_to_size is idempotent)
- VLUN: All actions become non-idempotent when <em>autolun</em> is set to <em>true</em>

## Contributing/Development

Please read our [Community Contributions Guidelines](/CONTRIBUTING.md)

## License
This project is licensed under the Apache 2.0 license. Please see [LICENSE](/LICENSE) for more info

Maintainer: Hewlett Packard Enterprise (hpe_storage_cookbooks@groups.ext.hpe.com)
