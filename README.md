# php-bilibili-danmu-docker

[php-bilibili-danmu](https://github.com/zxc7563598/php-bilibili-danmu) 的 Docker 部署方案，提供一键式环境搭建，帮助用户快速部署哔哩哔哩直播机器人。

> [!WARNING]
> 本项目仅供学习交流使用，禁止用于商业或非法用途。

## 项目简介

[bilibili-danmu](https://github.com/zxc7563598/php-bilibili-danmu) 是一个集弹幕监控、礼物答谢、定时广告、关注感谢、自动回复等功能于一体的综合性直播机器人。它内置了完整的积分商城系统，支持私有部署，无需审核限制。用户可通过签到或开通大航海等行为自动获取积分，并用于兑换礼物。

本仓库（`php-bilibili-danmu-docker`）提供以上项目的 Docker 容器化部署方案，包含 nginx、php、mysql、redis 四个服务，通过一条命令即可在全新服务器上完成部署。

## 主项目核心功能

- **积分商城**：用户可通过每日签到或开通直播间大航海获取积分，兑换商城中的虚拟道具或实体礼品
- **直播间打卡签到**：用户每日完成直播间签到，可累计/连续记录签到天数，并获得相应积分
- **PK 播报**：PK 对战开启前，系统将自动播报对手直播间成员活跃度及贡献榜单信息，支持自定义播报内容
- **礼物答谢**：收到观众礼物时自动触发答谢功能，支持自定义答谢金额门槛和多条个性化答谢文案
- **定时广告**：定时发送预设内容至直播间，支持配置多条文案并智能随机轮播
- **进房欢迎**：用户进入直播间时自动欢迎，支持配置多条差异化欢迎话术随机展示
- **感谢关注**：用户关注直播间时自动感谢，支持配置多条差异化欢迎话术随机展示
- **感谢分享**：用户分享直播间时自动感谢，支持配置多条差异化欢迎话术随机展示
- **自动回复**：当用户弹幕触发预设关键词时，系统将智能匹配并随机推送差异化回复内容，支持自定义多套回复方案
- **自动禁言**：基于自动回复功能，当触发自动回复规则时，可对违规用户执行临时禁言处罚，同时支持用户通过赠送指定价值的电池礼物来提前解除禁言状态

## 技术栈

| 服务 | 技术 |
|------|------|
| Web 服务器 | Nginx |
| 后端 | PHP 8.2 (Webman 框架) |
| 数据库 | MySQL 8.0 |
| 缓存 | Redis |
| 容器化 | Docker + Docker Compose |

## 目录结构

```
├── Dockerfile.php          # PHP 容器镜像（含 Composer、Node.js、PHP 扩展）
├── Dockerfile.nginx        # Nginx 容器镜像
├── docker-compose.yml      # 容器编排配置（nginx + php + mysql + redis）
├── setup.sh                # 初始化脚本（创建目录、拉取主项目）
├── .env.example            # 环境变量示例
├── nginx/
│   └── default.conf        # Nginx 站点配置
├── php/                    # 主项目代码挂载目录（由 setup.sh 自动拉取）
├── mysql/                  # MySQL 数据持久化目录
└── redis/                  # Redis 数据持久化目录
```

## 快速开始

### Docker 一键部署（推荐）

在全新服务器上执行以下命令，脚本将自动完成环境安装、项目拉取和容器启动：

```bash
curl -fsSL https://bilibili-danmu-scripts.oss-cn-hongkong.aliyuncs.com/install-docker-v2.sh | bash
```

> [!IMPORTANT]
> **推荐环境**：[阿里云](https://cn.aliyun.com) 香港地域，**Ubuntu 26.04 64 位**。这是一套经过验证的环境，能最大程度减少部署问题。其他云服务商或系统版本未做兼容性测试，不排除出现问题的可能性。

> [!NOTE]
> - 此命令仅适用于全新服务器（未安装任何运行环境）。脚本会自动安装 Docker，并将项目部署到 `/opt/bilibili-robots` 目录
> - 默认启动 nginx、php、mysql、redis 四个容器
> - 如果你已有服务器环境或需要自定义部署，请参考下文「手动部署」或查阅[说明文档](https://hejunjie.life/danmusuite/start/auto-deploy)
> - 不会购买服务器？参考下方「常见问题」

部署完成后，默认端口映射如下：

| 服务 | 宿主机端口 | 容器端口 | 说明 |
|------|-----------|---------|------|
| Nginx（主站） | 7777 | 80 | 管理后台入口 |
| Nginx（商城） | 5177 | 5176 | 移动端积分商城入口 |
| MySQL | 3307 | 3306 | 数据库 |

这些端口可在 `.env` 文件中自定义，详见「配置说明」。

### 手动部署

如果你具备一定的 PHP 环境搭建经验，也可以手动部署各组件。

**主项目（后端）**：[php-bilibili-danmu](https://github.com/zxc7563598/php-bilibili-danmu)

环境要求：LNMP 环境，PHP 8.2+，需安装 Redis、Brotli、GD 扩展。

```bash
git clone https://github.com/zxc7563598/php-bilibili-danmu.git ./
cp .env.example .env
# 修改 .env 配置，参考 .env.example 填写
composer install
vendor/bin/phinx migrate
php start.php start -d
```

项目基于 Webman 框架，详细说明可参考[官方文档](https://www.workerman.net/doc/webman/others/nginx-proxy.html)。

**管理后台（前端）**：[vue-bilibili-danmu-admin](https://github.com/zxc7563598/vue-bilibili-danmu-admin)

**移动端商城（前端）**：[vue-bilibili-danmu-shop](https://github.com/zxc7563598/vue-bilibili-danmu-shop)

环境要求：Node.js 本地环境。

```bash
git clone <对应仓库地址> ./
cp .env.example .env
# 修改 .env 配置，参考 .env.example 填写
npm install
npm run build
```

两个前端项目均基于 Vite 构建的 Vue 项目，通过 `npm run dev` 启动开发模式，`npm run build` 打包生产版本。

## 配置说明

复制环境变量示例文件并按需修改：

```bash
cp .env.example .env
```

| 变量 | 默认值 | 说明 |
|------|--------|------|
| `MYSQL_ROOT_PASSWORD` | `init0925` | MySQL root 密码 |
| `MYSQL_PORT` | `3307` | MySQL 宿主机端口映射 |
| `NGINX_PORT` | `7777` | 主站（管理后台）端口映射 |
| `SHOP_PORT` | `5177` | 移动端商城端口映射 |

## 常见问题

**关于购买服务器**

建议使用阿里云香港地域的轻量应用服务器，选择 Ubuntu 26.04 64 位镜像。香港地域到 B站 API 的网络延迟较低，有利于弹幕监控的实时性。

**购买了服务器如何使用**

登录阿里云控制台，找到你的服务器实例，使用 SSH 连接到服务器后执行 Docker 一键部署命令即可。如果不熟悉 SSH 操作，可搜索"如何通过 SSH 连接云服务器"。

**已有运行环境的服务器如何部署**

如果服务器上已安装了 MySQL、Redis 或其他服务，可能与 Docker 容器的默认端口发生冲突。请修改 `.env` 文件中的端口映射，或参考[说明文档](https://hejunjie.life/danmusuite/start/auto-deploy)了解如何忽略特定容器。

**遇到问题怎么办**

其他云服务商或系统版本未做兼容性测试，遇到问题可以提交 Issue。有动手能力的用户完全可以自行调整环境适配——一键部署脚本逻辑简单，不依赖复杂配置。

## 配套项目

[![Core](https://img.shields.io/badge/php--bilibili--danmu--core-B站交互核心模块-blueviolet?style=for-the-badge&logo=php)](https://github.com/zxc7563598/php-bilibili-danmu-core)
[![Docker](https://img.shields.io/badge/php--bilibili--danmu--docker-Docker一键部署容器-2496ed?style=for-the-badge&logo=docker)](https://github.com/zxc7563598/php-bilibili-danmu-docker)
[![API](https://img.shields.io/badge/php--bilibili--danmu-项目本体-007acc?style=for-the-badge&logo=php)](https://github.com/zxc7563598/php-bilibili-danmu)
[![Admin](https://img.shields.io/badge/vue--bilibili--danmu--admin-前端：管理后台-42b883?style=for-the-badge&logo=vue.js)](https://github.com/zxc7563598/vue-bilibili-danmu-admin)
[![Shop](https://img.shields.io/badge/vue--bilibili--danmu--shop-前端：移动端积分商城-3eaf7c?style=for-the-badge&logo=vue.js)](https://github.com/zxc7563598/vue-bilibili-danmu-shop)
