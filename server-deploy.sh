#!/bin/bash

echo "================================================="
echo " 『B站关注日报』后端一键部署脚本开始执行"
echo "================================================="

检查系统类型（Ubuntu / CentOS）
if command -v apt >/dev/null 2>&1; then
PKG="apt"
elif command -v yum >/dev/null 2>&1; then
PKG="yum"
else
echo "无法识别的系统，请使用 Ubuntu 或 CentOS"
exit 1
fi

echo "更新系统..."
$PKG update -y >/dev/null 2>&1

echo "安装 Node.js 18..."
curl -fsSL https://deb.nodesource.com/setup_18.x | bash - >/dev/null 2>&1 || true
curl -fsSL https://rpm.nodesource.com/setup_18.x | bash - >/dev/null 2>&1 || true

$PKG install -y nodejs >/dev/null 2>&1

echo "Node 版本："
node -v

echo "安装 PM2..."
npm install -g pm2 >/dev/null 2>&1

echo "创建项目目录..."
mkdir -p /root/bili-daily/backend
cd /root/bili-daily/backend

echo "安装项目依赖..."
npm install >/dev/null 2>&1

echo "初始化 SQLite 数据..."
mkdir -p ./data
touch ./data/bili.db

echo "启动后端服务..."
pm2 delete bili-daily >/dev/null 2>&1
pm2 start index.js --name bili-daily

echo "保存 PM2 配置..."
pm2 save >/dev/null 2>&1
pm2 startup >/dev/null 2>&1

echo "尝试开放端口 3000..."
firewall-cmd --permanent --add-port=3000/tcp >/dev/null 2>&1 || true
firewall-cmd --reload >/dev/null 2>&1 || true
ufw allow 3000/tcp >/dev/null 2>&1 || true

echo "================================================="
echo " 『B站关注日报』后端部署成功！"
echo "================================================="
echo " 访问接口地址：http://你的服务器IP:3000/api/today"
echo " PM2 命令：
pm2 status
pm2 logs bili-daily
pm2 restart bili-daily
"
