## 使用说明
本文件夹为docker compose 模板文件，运行之前需要放入对应的程序文件。

1. 将后端文件改名为cost_app.jar 放入conf\app 目录下,并设置为可运行程序

2. 将前端文件 放入conf\www目录下.

3. 将数据库脚本改名为init.sql 放入conf\init.d 目录下


最终效果如下：
├─conf
│  ├─app
│  │      ctl-tools.sh
│  │      start.sh
│  │      wuyu-cost.jar
│  │
│  ├─init.d
│  │      init.sql
│  │
│
│  └─www
│      │  favicon.ico
│      │  index.html
│      │  robots.txt
│      │  template.xlsx
│      │
│      ├─html
│      │      ie.html
│      │
│      └─static


## 运行


### 准备工作

```bash
# 进入目录
cd docker-compose



# 设置程序运行权限
# chmod +x conf/app/ctl-tools.sh  conf/app/start.sh  conf/app/wuyu-cost.jar 

chmod +x conf/app/*

```


### 启动服务

```bash
# 方式1.直接启动

docker compose up

# 方式2.后台启动

docker compose up -d

```

浏览器访问 http://localhost




