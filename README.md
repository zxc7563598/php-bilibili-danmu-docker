# php-bilibili-danmu Docker 配置

这是 [php-bilibili-danmu](https://github.com/zxc7563598/php-bilibili-danmu) 项目的 Docker 配置文件，旨在提供一键式的 Docker 环境搭建，帮助用户快速部署哔哩哔哩直播机器人。

---

## 项目特点

- **快速部署**：只需几条命令，即可完成完整的项目环境搭建。
- **全自动运行**：支持自动启动、守护进程运行，减少维护成本。
- **平台兼容性**：适用于所有支持 Docker 的设备。

---

## 快速开始

### **1. 安装 Docker**
确保目标设备已安装 Docker 和 Docker Compose：
- **Docker 安装文档**：[官方指南](https://docs.docker.com/get-docker/)
- **Docker Compose 安装文档**：[官方指南](https://docs.docker.com/compose/install/)

### **2. 获取项目配置**
拉取项目代码：
```bash
git clone https://github.com/zxc7563598/php-bilibili-danmu-docker.git
cd php-bilibili-danmu-docker
```

### **3. 构建 Docker 镜像**
使用以下命令构建项目镜像：
```bash
docker-compose build
```

### **4. 启动项目**
启动容器并运行项目：
```bash
docker-compose up -d
```

## 项目访问
本地运行用户：通过以下地址访问控制台：
```
http://127.0.0.1:7777
```

非本地运行用户：通过服务器 IP 地址访问：
```
http://<服务器IP地址>:7777
```

## 注意事项
请确保服务器或设备支持 Docker 并正确安装。

若需修改默认配置（如端口），可以编辑 docker-compose.yml 文件。

如果遇到问题，可以通过以下命令查看容器日志：
```bash
docker-compose logs
```