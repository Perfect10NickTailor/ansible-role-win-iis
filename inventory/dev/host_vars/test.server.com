---
domains:
  - name: "First website"
    host_header: ''
    ip: '*'
    iis_binding_port: '8082'
    protocol: 'http'
    state: 'absent'
    certificate_hash: ''
    certificate_store_name: 'My'
    iis_site_name: 'Default Web Site'
    iis_site_path: 'C:\inetpub\wwwroot1'
    iis_acl_path:  'C:\inetpub\wwwroot1'
    iis_site_state: absent
    iis_site_port: '80'
    iis_site_id: ''
    iis_site_ip: '*'
    iis_site_ssl: false
    iis_site_hostname: '*'
    iis_site_parameters: ''
    iis_site_state_start: stopped
    iis_site_web_config: ''
    iis_site_web_config_force: true

  - name: "Second website"
    host_header: ''
    ip: '*'
    iis_binding_port: '8081'
    protocol: 'http'
    state: 'present'
    certificate_hash: ''
    certificate_store_name: 'My'
    iis_site_name: 'site2'
    iis_acl_path: 'C:\inetpub\wwwroot2'
    iis_site_path: 'C:\inetpub\wwwroot2'
    iis_site_state: present
    iis_site_port: '80'
    iis_site_id: ''
    iis_site_ip: '*'
    iis_site_ssl: false
    iis_site_hostname: '*'
    iis_site_parameters: ''
    iis_site_state_start: started
    iis_site_web_config: ''
    iis_site_web_config_force: true