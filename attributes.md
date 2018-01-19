# Attributes listing

## storage system
node['hpe3par']['storage_system'] = {
    name: 'SRA_205',
    ip: '15.213.67.205',
    user: 'esi_user',
    password: 'esi_user'
}


## qos create
node['hpe3par']['qos']['create']['qos_target_name'] = 'chef_3par_vvset'
node['hpe3par']['qos']['create']['bwmin_goal_kb'] = 200
node['hpe3par']['qos']['create']['bwmax_limit_kb'] = 200
node['hpe3par']['qos']['create']['bwmin_goal_op'] = 'NOLIMIT'
node['hpe3par']['qos']['create']['bwmax_limit_op'] = 'NOLIMIT'
node['hpe3par']['qos']['create']['type'] = 'vvset'
node['hpe3par']['qos']['create']['priority'] = 'LOW'
node['hpe3par']['qos']['create']['iomin_goal'] =  300
node['hpe3par']['qos']['create']['iomax_limit'] = 300
node['hpe3par']['qos']['create']['iomin_goal_op'] = 'NOLIMIT'
node['hpe3par']['qos']['create']['iomax_limit_op'] = 'NOLIMIT'
node['hpe3par']['qos']['create']['latency_goal'] = 50
node['hpe3par']['qos']['create']['node_latency'] = true
node['hpe3par']['qos']['create']['latency_goal_usecs'] = 20
node['hpe3par']['qos']['create']['enable'] = true
  
## qos modify
node['hpe3par']['qos']['modify']['qos_target_name'] = 'chef_3par_vvset'
node['hpe3par']['qos']['modify']['type'] =  'vvset'
node['hpe3par']['qos']['modify']['enable'] = true
node['hpe3par']['qos']['modify']['bwmin_goal_kb'] = 2300
node['hpe3par']['qos']['modify']['bwmax_limit_kb'] = 2500
node['hpe3par']['qos']['modify']['bwmin_goal_op'] = 'NOLIMIT'
node['hpe3par']['qos']['modify']['bwmax_limit_op'] = 'NOLIMIT'
node['hpe3par']['qos']['modify']['priority'] = 'LOW'
node['hpe3par']['qos']['modify']['iomin_goal'] =  400
node['hpe3par']['qos']['modify']['iomax_limit'] = 500
node['hpe3par']['qos']['modify']['iomin_goal_op'] = 'NOLIMIT'
node['hpe3par']['qos']['modify']['iomax_limit_op'] = 'NOLIMIT'
node['hpe3par']['qos']['modify']['latency_goal'] = 40
node['hpe3par']['qos']['modify']['node_latency'] = false
node['hpe3par']['qos']['modify']['latency_goal_usecs'] = 2000

## qos delete
node['hpe3par']['qos']['delete']['qos_target_name'] = 'chef_3par_vvset'
node['hpe3par']['qos']['delete']['type'] =  'vvset'

## virtual_volume create
node['hpe3par']['virtual_volume']['name'] = 'chef_vol_thin2'
node['hpe3par']['virtual_volume']['cpg'] = 'FC_r1'
node['hpe3par']['virtual_volume']['size'] = 1024.0
node['hpe3par']['virtual_volume']['size_unit'] = 'MiB'
node['hpe3par']['virtual_volume']['type'] = 'thin'
node['hpe3par']['virtual_volume']['compression'] = false
node['hpe3par']['virtual_volume']['snap_cpg'] = 'FC_r1'

## virtual_volume modify
node['hpe3par']['virtual_volume']['modify']['snap_cpg'] = 'FC_r1'
node['hpe3par']['virtual_volume']['modify']['new_name'] = 'chef_vol_thin2_1'
node['hpe3par']['virtual_volume']['modify']['ss_spc_alloc_warning_pct'] = 0
node['hpe3par']['virtual_volume']['modify']['ss_spc_alloc_limit_pct'] = 0
node['hpe3par']['virtual_volume']['modify']['rm_ss_spc_alloc_warning'] = false
node['hpe3par']['virtual_volume']['modify']['usr_spc_alloc_warning_pct'] = 0
node['hpe3par']['virtual_volume']['modify']['usr_spc_alloc_limit_pct'] = 0
node['hpe3par']['virtual_volume']['modify']['rm_usr_spc_alloc_warning'] = false
node['hpe3par']['virtual_volume']['modify']['expiration_hours'] = 0
node['hpe3par']['virtual_volume']['modify']['retention_hours'] = 0
node['hpe3par']['virtual_volume']['modify']['rm_exp_time'] = false
node['hpe3par']['virtual_volume']['modify']['rm_ss_spc_alloc_limit'] = false
node['hpe3par']['virtual_volume']['modify']['rm_usr_spc_alloc_limit'] = false

## virtual_volume tune
node['hpe3par']['virtual_volume']['tune']['user_cpg'] = 'FC_r1'
node['hpe3par']['virtual_volume']['tune']['snap_cpg'] = 'FC_r1'
node['hpe3par']['virtual_volume']['tune']['type'] = 'full'
node['hpe3par']['virtual_volume']['tune']['keep_vv'] = 'vol_bkup'
node['hpe3par']['virtual_volume']['tune']['compression'] = false

## volumeset create
node['hpe3par']['volume_set']['create']['name'] = 'chef_volume_set'
node['hpe3par']['volume_set']['create']['domain'] = 'my_domain'
node['hpe3par']['volume_set']['create']['setmembers'] = ['chef_vol_thin2']
  
## volumeset delete
node['hpe3par']['volume_set']['delete']['name'] = 'chef_volume_set'
  
## volumeset add_volume
node['hpe3par']['volume_set']['add_volume']['name'] = 'chef_volume_set'
node['hpe3par']['volume_set']['add_volume']['setmembers'] = ['chef_vol_thin2']
  
## volumeset add_volume
node['hpe3par']['volume_set']['remove_volume']['name'] = 'chef_volume_set'
node['hpe3par']['volume_set']['remove_volume']['setmembers'] = ['chef_vol_thin2']
  
## snapshot create
node['hpe3par']['snapshot']['create']['snapshot_name'] = 'chef_thin_volume_vc'
node['hpe3par']['snapshot']['create']['base_volume_name'] = 'chef_vol_thin'
node['hpe3par']['snapshot']['create']['read_only'] = false
node['hpe3par']['snapshot']['create']['expiration_time'] = 0
node['hpe3par']['snapshot']['create']['expiration_unit'] = 'Days'
node['hpe3par']['snapshot']['create']['retention_time'] = 0
node['hpe3par']['snapshot']['create']['retention_unit'] = 'Days'
  
## snapshot restore
node['hpe3par']['snapshot']['restore']['snapshot_name'] = 'chef_thin_volume_vc'
node['hpe3par']['snapshot']['restore']['priority'] = 'MEDIUM'
node['hpe3par']['snapshot']['restore']['allow_remote_copy_parent'] = false
  
## snapshot delete
node['hpe3par']['snapshot']['delete']['snapshot_name'] = 'chef_thin_volume_vc'
  
## snapshot modify
node['hpe3par']['snapshot']['modify']['snapshot_name'] = 'chef_thin_volume_vc'
node['hpe3par']['snapshot']['modify']['new_name'] = 'chef_vol_thin_cc_chef'
node['hpe3par']['snapshot']['modify']['retention_hours'] = 0
node['hpe3par']['snapshot']['modify']['expiration_hours'] = 0
node['hpe3par']['snapshot']['modify']['rm_exp_time'] = false


## CPG
node['hpe3par']['cpg']['create']['name'] = 'test_3par_tryone'
node['hpe3par']['cpg']['create']['raid_type'] = 'R0'
node['hpe3par']['cpg']['create']['high_availability'] = 'PORT'
node['hpe3par']['cpg']['create']['disk_type']='FC'
node['hpe3par']['cpg']['delete']['name'] = 'test_3par_tryone'

## vlun export volume to host
node['hpe3par']['vlun']['export_volume_to_host']['volume_name'] = 'chef_vol_thin2'
node['hpe3par']['vlun']['export_volume_to_host']['host_name'] = 'test_chef_host1'
node['hpe3par']['vlun']['export_volume_to_host']['node_val'] = 1 
node['hpe3par']['vlun']['export_volume_to_host']['slot'] = 2
node['hpe3par']['vlun']['export_volume_to_host']['card_port'] = 1 
node['hpe3par']['vlun']['export_volume_to_host']['autolun'] = true
  
## vlun unexport volume to host
node['hpe3par']['vlun']['unexport_volume_to_host']['volume_name'] = 'chef_vol_thin2'
node['hpe3par']['vlun']['unexport_volume_to_host']['host_name'] = 'test_chef_host1'
node['hpe3par']['vlun']['unexport_volume_to_host']['lunid'] = 0
  
## vlun export volume to hostset
node['hpe3par']['vlun']['export_volume_to_hostset']['volume_name'] = 'chef_vol_thin2'
node['hpe3par']['vlun']['export_volume_to_hostset']['hostset_name'] = 'chef_host_set'
  
## vlun unexport volume to hostset
node['hpe3par']['vlun']['unexport_volume_to_hostset']['volume_name'] = 'chef_vol_thin2'
node['hpe3par']['vlun']['unexport_volume_to_hostset']['hostset_name'] = 'chef_host_set'
node['hpe3par']['vlun']['unexport_volume_to_hostset']['lunid'] = 0
  
## vlun export volumeset to host
node['hpe3par']['vlun']['export_volumeset_to_host']['volumeset_name'] = 'chef_volume_set'
node['hpe3par']['vlun']['export_volumeset_to_host']['host_name'] = 'test_chef_host1'

## vlun unexport volumeset to host
node['hpe3par']['vlun']['unexport_volumeset_to_host']['volumeset_name'] = 'chef_volume_set'
node['hpe3par']['vlun']['unexport_volumeset_to_host']['host_name'] = 'test_chef_host1'
node['hpe3par']['vlun']['unexport_volumeset_to_host']['lunid'] = 0
  
## vlun export volumeset to hostset
node['hpe3par']['vlun']['export_volumeset_to_hostset']['volumeset_name'] = 'chef_volume_set'
node['hpe3par']['vlun']['export_volumeset_to_hostset']['hostset_name'] = 'chef_host_set'
 
## vlun unexport volumeset to hostset
node['hpe3par']['vlun']['unexport_volumeset_to_hostset']['volumeset_name'] = 'chef_volume_set'
node['hpe3par']['vlun']['unexport_volumeset_to_hostset']['hostset_name'] = 'chef_host_set'
node['hpe3par']['vlun']['unexport_volumeset_to_hostset']['lunid'] = 0 

## clone create_online
node['hpe3par']['clone']['create_online']['clone_name'] = 'chef_test_vol_clone'
node['hpe3par']['clone']['create_online']['base_volume_name'] = 'chef_vol_thin2'
node['hpe3par']['clone']['create_online']['dest_cpg'] = 'FC_r1'
node['hpe3par']['clone']['create_online']['online'] = true
node['hpe3par']['clone']['create_online']['tpvv'] = false
node['hpe3par']['clone']['create_online']['tdvv'] = false
node['hpe3par']['clone']['create_online']['snap_cpg'] = 'FC_r1'
node['hpe3par']['clone']['create_online']['compression'] = false

## clone create_offline
node['hpe3par']['clone']['create_offline']['clone_name'] = 'chef_test_vol_clone'
node['hpe3par']['clone']['create_offline']['base_volume_name'] = 'chef_vol_thin2'
node['hpe3par']['clone']['create_offline']['dest_cpg'] = 'FC_r1'
node['hpe3par']['clone']['create_offline']['online'] = false
node['hpe3par']['clone']['create_offline']['save_snapshot'] = true
node['hpe3par']['clone']['create_offline']['priority'] = 'MEDIUM'
node['hpe3par']['clone']['create_offine']['skip_zero'] = false
  
## clone resync
node['hpe3par']['clone']['resync']['clone_name'] = 'chef_test_vol_clone'

## clone stop
node['hpe3par']['clone']['stop']['clone_name'] = 'chef_test_vol_clone'
  
## clone delete
node['hpe3par']['clone']['delete']['clone_name'] = 'chef_test_vol_clone'

## host Creation params
node['hpe3par']['host']['create']['name'] = 'test_chef_host1'
node['hpe3par']['host']['create']['domain'] = 'my_domain'
node['hpe3par']['host']['create']['fc_wwns'] = ['1000D89D676F3854']
node['hpe3par']['host']['create']['iscsi_names'] = ['iqn.1993-08.org.debian:01:ba4c8e542ae']
node['hpe3par']['host']['create']['persona'] = 'WINDOWS_SERVER'

## host add FC Path params
node['hpe3par']['host']['add_fc_path']['host_name'] = 'test_chef_host1'
node['hpe3par']['host']['add_fc_path']['fc_wwns'] = ['1000D89D676F3854']
  
## host remove FC Path params
node['hpe3par']['host']['remove_fc_path']['host_name'] = 'test_chef_host1'
node['hpe3par']['host']['remove_fc_path']['fc_wwns'] = ['1000D89D676F3854']
node['hpe3par']['host']['remove_fc_path']['force_path_removal'] = true
  
## host add iSCSI Path params
node['hpe3par']['host']['add_iscsi_path']['host_name'] = 'test_chef_host1'
node['hpe3par']['host']['add_iscsi_path']['iscsi_names'] = ['iqn.1993-08.org.debian:01:ba4c8e542ae']
  
## host remove iSCSI Path params
node['hpe3par']['host']['remove_iscsi_path']['host_name'] = 'test_chef_host1'
node['hpe3par']['host']['remove_iscsi_path']['iscsi_names'] = ['iqn.1993-08.org.debian:01:ba4c8e542ae']
node['hpe3par']['host']['remove_iscsi_path']['force_path_removal'] = false
  
## modify host params
node['hpe3par']['host']['modify']['host_name'] = 'test_chef_host1'
node['hpe3par']['host']['modify']['new_name'] = 'test_chef_host2'
node['hpe3par']['host']['modify']['domain'] = 'my_domain'
node['hpe3par']['host']['modify']['persona'] = 'AIX_LEGACY'

## add initiator chap params
node['hpe3par']['host']['add_initiator_chap']['host_name'] = 'test_chef_host2'
node['hpe3par']['host']['add_initiator_chap']['chap_name'] = 'initiator-chap-name'
node['hpe3par']['host']['add_initiator_chap']['chap_secret'] = 'ini-chap-secret'
node['hpe3par']['host']['add_initiator_chap']['chap_secret_hex'] = false
  
## add target chap params
node['hpe3par']['host']['add_target_chap']['host_name'] = 'test_chef_host2'
node['hpe3par']['host']['add_target_chap']['chap_name'] = 'target-chap-name'
node['hpe3par']['host']['add_target_chap']['chap_secret'] = '768EA6A5FBD6020ABEE4D4DEDBF9C5AE'
node['hpe3par']['host']['add_target_chap']['chap_secret_hex'] = true
  
## remove target chap params
node['hpe3par']['host']['remove_target_chap']['host_name'] = 'test_chef_host2'
  
## remove initiator chap params
node['hpe3par']['host']['remove_initiator_chap']['host_name'] = 'test_chef_host2'
  
## delete host params
node['hpe3par']['host']['delete']['host_name'] = 'test_chef_host2'

## host set create
node['hpe3par']['host_set']['create']['name'] = 'chef_host_set'
node['hpe3par']['host_set']['create']['setmembers'] = ['test_chef_host1']
node['hpe3par']['host_set']['create']['domain'] = nil
  
## host set delete
node['hpe3par']['host_set']['delete']['name'] = 'chef_host_set'
  
## host set add host
node['hpe3par']['host_set']['add_host']['name'] = 'chef_host_set'
node['hpe3par']['host_set']['add_host']['setmembers'] = ['test_chef_host1']
  
## host set remove host
node['hpe3par']['host_set']['remove_host']['name'] = 'chef_host_set'
node['hpe3par']['host_set']['remove_host']['setmembers'] = ['test_chef_host1']

## flash cache
node['hpe3par']['flash_cache']['size_in_gb'] = 64
