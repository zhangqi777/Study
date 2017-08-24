# Ansible Role: deploy-tomcat

部署war包至tomcat容器

## 要求

- 此角色仅在RHEL及其衍生产品上运行。

## 测试环境

ansible `2.3.0.0`
os `Centos 6.7 X64`
python `2.6.6`

## 角色变量
    # 发布的代码文件，包含绝对路径，如:/tmp/test.war
    deploy_file: ""

    # tomcat服务的端口
    deploy_port: "8080"

    # tomcat服务用户
    deploy_service_user: ""

    # tomcat服务类型   APP_TYPE
    deploy_service_type: "tomcat"

    # tomcat服务用户家目录   USER_ROOT
    deploy_service_home: "/home/{{ deploy_service_user }}"

    # tomcat服务的名称   PROJECT_NAME
    deploy_service_name: ""

    # 上线代码的存储目录  DEPLOY_ROOT
    deploy_new_path: "{{ deploy_service_home }}/deploy"

## 依赖
tomcat

## Example Playbook

    # 发布代码
    Environment='gds'
    TARGET='10.99.3.152,10.99.3.143'
    CMD='update'
    deploy_service_name='rc-server'
    WORK_DIR=`pwd`
    deploy_file="$WORK_DIR/rc-server.war"
    deploy_service_user=app

    cd ~/ansible
    ansible-playbook -i $Environment ./deploy/deploy_tomcat.yml -t "$CMD" -l "$TARGET"

      
    # 回滚代码
    Environment='gds'
    TARGET='10.99.3.152,10.99.3.143'
    CMD='rollback'
    deploy_service_name='rc-server'
    WORK_DIR=`pwd`
    deploy_file="$WORK_DIR/rc-server.war"
    deploy_service_user=app

    cd ~/ansible
    ansible-playbook -i $Environment ./deploy/deploy_tomcat.yml -t "$CMD" -l "$TARGET"