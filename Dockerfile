FROM php:8.2-cli-alpine

# 安装 Composer
COPY --from=composer:2.7 /usr/bin/composer /usr/bin/composer

# 设置时区
ENV TZ=Asia/Shanghai

# 更新包并安装依赖
RUN apk update && apk add --no-cache \
    vim \
    bash \
    git \
    curl \
    brotli \
    build-base \
    autoconf \
    libtool \
    make \
    linux-headers \
    pcre-dev \
    libevent \
    libevent-dev \
    libpng-dev \
    libjpeg-turbo-dev \
    libwebp-dev \
    freetype-dev \
    $PHPIZE_DEPS \
    redis \
    busybox-suid \
    mysql-client \
    util-linux \
    nodejs \
    npm \
    sqlite-dev

# 安装 PHP 扩展
RUN docker-php-ext-install pdo_mysql pcntl

# 安装 PHP GD 扩展
RUN docker-php-ext-configure gd \
    --with-jpeg \
    --with-webp \
    --with-freetype \
    && docker-php-ext-install gd

# 安装 PHP Redis 扩展
RUN pecl install redis \
    && docker-php-ext-enable redis

# 安装 PHP Brotli 扩展
RUN pecl install brotli \
    && docker-php-ext-enable brotli

# 设置工作目录
WORKDIR /var/www/bilibili_danmu

# 复制项目文件到容器中（此时不需要挂载，直接放到工作目录）
COPY ./php /var/www/bilibili_danmu

# 添加 cron 任务
RUN echo "0 * * * * /var/www/bilibili_danmu/scripts/check_for_updates.sh" > /etc/crontabs/root