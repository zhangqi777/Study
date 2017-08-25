# Ansible Role: Java

部署java容器

## 要求
    # VARS
    jdk_version: support jdk1.7.0_80 jdk1.8.0_91 
    app_user: support any user 

- 此角色仅在RHEL及其衍生产品上运行。

## 测试环境

ansible `2.3.0.0`
os `Centos 6.7 X64`
python `2.6.6`

## 角色变量
    # java变量信息
    JAVA_ROOT: /usr/local/java/
    JAVA_CURRENT_ROOT: "{{ JAVA_ROOT }}{{ jdk_version }}"
    JAVA_BIN: "{{ JAVA_CURRENT_ROOT }}/bin/java"
    app_user: ""
    jdk_version: ""

## 依赖
#
none

## Example Playbook

    # 创建Java
    ansible-playbook -i prod setup/08-install-jdk.yml  -e "jdk_version=jdk1.8.0_91 app_user=app" -l "target host"

    - hosts: all                                                         #主机组
      remote_user: ops                                                   #被控端用户
      become: yes                                                        #是否以某人执行
      become_user: root                                                  #以root用户                                               
      become_method: sudo                                                #以sudo方式
      gather_facts: True
      pre_tasks:
        - name: include Globals
          include: "../includes/zq_vars.yml"
      roles: 
        - jdk   
