# Ansible Role: create-tomcat

部署tomcat容器

## 要求

- 此角色仅在RHEL及其衍生产品上运行。

## 测试环境

ansible `2.3.0.0`
os `Centos 6.7 X64`
python `2.6.6`

## 应用信息
    # 注销
    tomcat_version: support tomcat-7.0.73 tomcat-8.0.44
    app_user: support any user, for run application
    project_name: target location does not exist
    project_port: service listen port
    jmx_port: for monitor

## 角色变量
    # 工作目录
    work_path: /home/ops/playbook

    # 默认存放位置
    default path: /home/{{ app_user }}/tomcat/{{ project_name }}

    # 发布用户
    app_user: "tomcat"

    # tomcat服务的端口
    project_port: "8080"

    # tomcat项目名称
    project_name: ""

    # jmx端口
    jmx_port: ""

## 依赖
tomcat

## Example Playbook

    # 发布代码
    ansible-playbook -i prod setup/08-install-tomcat.yml  -e "tomcat_version=tomcat-7.0.73 app_user=app project_name=tomcat8080 project_port=8080 jmx_port=18999" -l "target host"

    # 08-install-tomcat.yml
    - hosts: all                                                         #主机组
      remote_user: ops                                                   #被控端用户
      become: yes                                                        #是否以某人执行
      become_user: "{{app_user}}"                                        #以某个用户执行
      #become_method: sudo                                                #以sudo方式
      gather_facts: True
      pre_tasks:
        - name: include Globals
          include: "../includes/zq_vars.yml"
      roles: 
        - zq-create-tomcat
