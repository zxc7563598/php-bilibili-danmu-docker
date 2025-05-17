# php-bilibili-danmu-docker

⚠️ 本项目仅供学习交流使用，禁止用于商业或非法用途。

这是 [php-bilibili-danmu](https://github.com/zxc7563598/php-bilibili-danmu) 项目的 Docker 配置文件，旨在提供一键式的 Docker 环境搭建，帮助用户快速部署哔哩哔哩直播机器人。

---

[bilibili-danmu](https://github.com/zxc7563598/php-bilibili-danmu)是一个集弹幕监控、礼物答谢、定时广告、关注感谢、自动回复等功能于一体的综合性工具。它内置了完整的积分商城系统，支持私有部署，无需审核限制。用户可通过签到或开通大航海等行为自动获取积分，并用于兑换礼物。

这不仅让它超越了一般的弹幕机器人，更成为一个提升观众互动、增强直播粘性、助力主播变现的全方位解决方案。

## 核心功能

* **积分商城**：用户可通过每日签到或开通直播间大航海获取积分，兑换商城中的虚拟道具或实体礼品。
* **直播间打卡签到**：用户每日完成直播间签到，可累计/连续记录签到天数，并获得相应积分，用于兑换积分商城内的各类商品。
* **PK播报**：PK对战开启前，系统将自动播报对手直播间成员活跃度及贡献榜单信息，可自定义播报内容。
* **礼物答谢**：收到观众礼物时自动触发答谢功能，支持自定义答谢金额门槛和多条个性化答谢文案。
* **定时广告**：定时发送预设内容至直播间，支持配置多条文案并智能随机轮播。
* **进房欢迎**：用户进入直播间时自动欢迎，并支持配置多条差异化欢迎话术随机展示。
* **感谢关注**：用户关注直播间时自动感谢，并支持配置多条差异化欢迎话术随机展示。
* **感谢分享**：用户分享直播间时自动感谢，并支持配置多条差异化欢迎话术随机展示。
* **自动回复**：当用户弹幕触发预设关键词时，系统将智能匹配并随机推送差异化回复内容，支持自定义多套回复方案。
* **自动禁言**：基于自动回复功能，当触发自动回复规则时，可对违规用户执行临时禁言处罚，同时支持用户通过赠送指定价值的电池礼物来提前解除禁言状态。

## 部署方案

### 新手推荐方案：Docker一键部署

可能不是最完美的方案，但它一定是对新手最友好的选择：一键配置，命令执行后静待完成，项目会自动拉取、配置并保持更新，全程无需额外操作。

在你的服务器上执行：

```bash
curl -fsSL https://bilibili-danmu-scripts.oss-cn-hongkong.aliyuncs.com/install-docker.sh | bash 
```

> **没有开发基础的用户** 请确保您使用的是 [阿里云](https://cn.aliyun.com) 位于 **香港** 地域的 **Ubuntu  24.04 64位** 版本的服务器。这是一套经过验证的环境，能最大程度减少部署问题

> 其他云服务商或系统版本未做兼容性测试，不排除出现问题的可能性。如果你遇到问题，可以来问我，我乐意帮忙，全当交个朋友。但不保证解决。

> 一键部署脚本写得很简单，不依赖复杂逻辑，有动手能力的用户完全可以自行调整环境。完全不懂的朋友，建议按推荐环境来，别自找麻烦。

> 不会购买服务器看下方「一些问题」中的「关于购买服务器」

> 购买服务器不知道如何使用的看下方「一些问题」中的「购买了服务器要如何使用」

### 手动部署方案

> 以下是手动部署项目的推荐流程，适合具备基本 PHP 环境搭建经验的用户。

后台本体：[Github仓库](https://github.com/zxc7563598/php-bilibili-danmu)

* **环境要求**：LNMP 环境，PHP 8.1+，需安装 Redis、Brotli、GD 扩展
* **项目结构**：标准 PHP 项目，依赖管理采用 Composer，符合现代开发规范。首次运行前请执行 `composer install`​ 安装依赖。
* **数据库迁移**：使用 Phinx 进行管理。请在完成 `.env`​ 配置及依赖安装后，执行 `php vendor/bin/phinx migrate -e development`​ 进行数据库结构初始化（需提前创建一个 UTF8MB4 编码的数据库）。
* **运行方式**：基于 Webman 框架，启动流程与官方一致，详细说明可参考[官方文档](https://www.workerman.net/doc/webman/others/nginx-proxy.html)
    ```bash
    git clone https://github.com/zxc7563598/php-bilibili-danmu.git ./
    cp .env.example .env
    # 修改 .env 配置，参考 .env.example 填写
    composer install
    php vendor/bin/phinx migrate -e development
    php start.php start -d
    ```

[![Admin](https://img.shields.io/badge/vue--bilibili--danmu--admin-前端：管理后台-42b883?style=for-the-badge&logo=vue.js)](https://github.com/zxc7563598/vue-bilibili-danmu-admin)
[![Shop](https://img.shields.io/badge/vue--bilibili--danmu--shop-前端：移动端积分商城-3eaf7c?style=for-the-badge&logo=vue.js)](https://github.com/zxc7563598/vue-bilibili-danmu-shop)

* **环境要求**：本地 NodeJs 环境
* **项目结构**：基于 Vite 构建的 Vue 标准项目，首次使用请先通过 `npm install`​ 安装依赖。
* **运行方式**：所有 npm 命令均保持默认配置，通过 `npm run dev` 启动开发模式，通过 `npm run build` 打包生产版本。配置文件通过 `.env` 管理，可参考 `.env.example`
    ```bash
    git clone 对应的仓库 ./
    cp .env.example .env
    # 修改 .env 配置，参考 .env.example 填写
    npm install
    npm run build
    ```

---

## 🧩 配套项目

[![Core](https://img.shields.io/badge/php--bilibili--danmu--core-B站交互核心模块-blueviolet?style=for-the-badge&logo=php)](https://github.com/zxc7563598/php-bilibili-danmu-core)
[![Docker](https://img.shields.io/badge/php--bilibili--danmu--docker-Docker一键部署容器-2496ed?style=for-the-badge&logo=docker)](https://github.com/zxc7563598/php-bilibili-danmu-docker)
[![API](https://img.shields.io/badge/php--bilibili--danmu-项目本体-007acc?style=for-the-badge&logo=php)](https://github.com/zxc7563598/php-bilibili-danmu)
[![Admin](https://img.shields.io/badge/vue--bilibili--danmu--admin-前端：管理后台-42b883?style=for-the-badge&logo=vue.js)](https://github.com/zxc7563598/vue-bilibili-danmu-admin)
[![Shop](https://img.shields.io/badge/vue--bilibili--danmu--shop-前端：移动端积分商城-3eaf7c?style=for-the-badge&logo=vue.js)](https://github.com/zxc7563598/vue-bilibili-danmu-shop)