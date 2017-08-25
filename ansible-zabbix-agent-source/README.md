# Ansible Role: zabbix-agentd

部署zabbix-agentd

## 要求

- 此角色仅在RHEL及其衍生产品上运行。

## 测试环境

ansible `2.3.0.0`
os `Centos 6.7 X64`
python `2.6.6`

## 文件来源
    # 编译完成的源代码文件
    zabbix-agent-32.rhel6.i386.tar.gz
    zabbix-agent-32.rhel6.X86_64.tar.gz
    zabbix-agent-32.rhel7.X86_64.tar.gz

## 角色变量
---
    # defaults file for zabbix-agent
    zabbix_version: 3.2
    agent_server: 192.168.1.77
    agent_serveractive: 192.168.1.77
    zabbix_repo: zabbix
    zabbix_agent_package: zabbix-agentd
    zabbix_agent_package_state: present # or latest

    # Zabbix API stuff
    zabbix_url: "http://192.168.1.77"
    zabbix_api_user: Admin
    zabbix_api_pass: zabbix
    zabbix_api_create_hostgroup: False
    zabbix_api_create_hosts: False
    zabbix_create_hostgroup: present  # or absent
    zabbix_create_host: present       # or absent
    zabbix_host_status: enabled       # or disabled
    zabbix_proxy: null
    zabbix_useuip: 1
    zabbix_host_groups:
      - Linux servers
    zabbix_link_templates:
      - Template OS Linux

    # zabbix-agent 配置文件
    agent_interfaces:
      - type: 1
        main: 1
        useip: "{{ zabbix_useuip }}"
        ip: "{{ agent_ip }}"
        dns: "{{ ansible_fqdn }}"
        port: "{{ agent_listenport }}"

    # Zabbix configuration variables
    agent_pidd: /var/run/zabbix
    agent_logd: /var/log/zabbix
    agent_pidfile: /var/run/zabbix/zabbix_agentd.pid
    agent_logfile: /var/log/zabbix/zabbix_agentd.log
    agent_logfilesize: 100
    agent_debuglevel: 3
    agent_sourceip:
    agent_enableremotecommands: 0
    agent_logremotecommands: 0
    agent_listenport: 10050
    agent_listeninterface:
    agent_listenip:
    agent_startagents: 3
    agent_hostname: "{{ inventory_hostname }}"
    agent_hostnameitem:
    agent_hostmetadata:
    agent_hostmetadataitem:
    agent_refreshactivechecks: 120
    agent_buffersend: 5
    agent_buffersize: 100
    agent_maxlinespersecond: 100
    agent_allowroot: 0
    agent_zabbix_alias:
    agent_timeout: 3
    agent_include: /usr/local/zabbix-agent/etc/zabbix_agentd.d
    agent_unsafeuserparameters: 0
    agent_userparameter:
    agent_loadmodulepath: ${libdir}/modules
    agent_loadmodule:

## 依赖
# 
zabbix-server  zabbix-agent

## Example Playbook

    # 源代码安装
    - hosts: all
      become: True
      become_user: root
      pre_tasks:
        - name: include Globals
          include: "../includes/zq_vars.yml"
          tags: "always"
      roles:
        - role: ansible-zabbix-agent-source
          vars:
            zabbix_repo: "local"
          tags: "zabbix"
