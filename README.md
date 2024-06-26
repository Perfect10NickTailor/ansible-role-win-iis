# ansible-role-win-iis
Note: I have made a new role that bypasses the use of windows modules in ansible for IIS and written some custom PS code where if you have a complex IIS infra and hundreds of sites. The modular approach does not work for hundreds of sites and complicated infra. The new one i wrote will handle it all.
Its not publically available but it can copy an exsiting servers config and restore to another machine in minutes. (500-1000) sites. Pool, permissions, paths etc. 


Win-IIS - http://www.nicktailor.com/?p=1486
===========================================

Manage basic IIS (Internet Information Services) configuration on Windows
Server. The `Web-Server` feature will be installed if not present.

Role Variables
--------------

Use the following variables to create or update the app pool used by the site:

- `iis_app_pool_name`: The name of the app pool to create or update and
  associate with the site; default is `'DefaultAppPool'`.
- `iis_app_pool_attributes`: Additional attributes for configuration of the app
  pool; default is `''`, which will not specify any additional attributes.

Use the following variables to configure basic IIS site options:

- `iis_site_name`: Name of the IIS site; default is `'Default Web Site'`.
- `iis_site_id`: Numeric site ID, can only be specified when creating a new
  site; default is `''`, which omits the site ID.
- `iis_site_ip`: IP address to listen for connections; default is `'*'`, which
  listens on all addresses.
- `iis_site_port`: Port to listen for connections; default is `80`.
- `iis_site_ssl`: Enable the site to handle SSL traffic; default is `false`. Use
  the binding options below to specify the hostname, protocol and certificate
  information for the SSL site.
- `iis_site_hostname`: Primary hostname for the site, default is `''`, which
  will respond to any hostname not configured for another site on the same IP
  and port.
- `iis_site_path`: Directory containing the files served by this site, will be
  created if it does not yet exist. Default is `'C:\inetpub\wwwroot'`, which is
  the usual default path configured when IIS is installed.
- `iis_site_parameters`: Additional parameters for site configuration; default
  is `''`, which will not specify any additional parameters.
- `iis_site_state`: The state of the site; default is `'started'`. `'absent'`
  may be used to remove a site.
- `iis_site_web_config`: Local path to a Jinja template that will be used to
  create a `web.config` file in `iis_site_path`. Default is `""`, which does not
  create a `web.config` file.
- `iis_site_web_config_force`: Always write a `web.config` file even if one
  already exists; default is `true`.

Use the following variables to specify additional hostnames, addresses or ports
where the site should be served. The `iis_binding_*` variables provide defaults
for all bindings that may be override for each item in `iis_bindings`.

- `iis_binding_host_header`: Additional hostname for bindings, default is `''`.
- `iis_binding_ip`: Additional IP address to listen for connections; default is
  `'*'`.
- `iis_binding_port`: Additional port to listen for connections; default is
  `80`.
- `iis_binding_protocol`: Protocol to use for connections; default is `'http'`.
  Supported values are `'http'`, `'https'` and `'ftp'`.
- `iis_binding_state`: The state of the binding; default is `'present'`. Use
  `'absent'` to remove a binding.
- `iis_binding_certificate_store_name`: Certificate store name containing SSL
  certificate; default is `'My'`.
- `iis_binding_certificate_hash`: Certificate hash of SSL certificate; default
  is `''`, which doesn't specify a certificate.
- `iis_bindings`: A list of items specifying site bindings, where each item may
  use any of the following keys to override the defaults above:
  - `host_header`
  - `ip`
  - `port`
  - `protocol`
  - `state`
  - `certificate_store_name`
  - `certificate_hash`

Use the following variables to override the filesystem permissions set on the
site path:

- `iis_acl_path`: Path to update ACL, default is `iis_site_path`. Specify `""`
  (an empty string) to skip ACL updates.
- `iis_acl_user`: IIS user group; default is `'IIS_IUSRS'`.
- `iis_acl_rights`: Rights to assign to user or group; default is
  `'FullControl'`.
- `iis_acl_type`: ACL type; default is `'allow'`.
- `iis_acl_state`: ACL state; default is `'present'`.
- `iis_acl_inherit`: ACL inheritance options; default is
  `'ContainerInherit, ObjectInherit'`.
- `iis_acl_propagation`: ACL propagation options; default is `'None'`.

Example Playbook
----------------

The following example playbook removes the default IIS web site, then adds a new
site that is served on port `8080` in addition to port `80`:

    - hosts: all
      roles:
        - role: ansible-role-win-iis


ensure you inventory/host_vars/test.server.com has the following variables defined

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


