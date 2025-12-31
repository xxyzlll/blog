#!/bin/bash

# 本地快速部署脚本
# 使用方法: ./deploy.sh 或 npm run deploy

set -e  # 遇到错误立即退出

# 加载配置文件
if [ -f ".deploy.config" ]; then
  echo "📋 加载配置文件 .deploy.config"
  source .deploy.config
else
  echo "❌ 配置文件 .deploy.config 不存在！"
  echo "请复制 .deploy.config.example 为 .deploy.config 并填入你的服务器信息"
  echo "命令: cp .deploy.config.example .deploy.config"
  exit 1
fi

# 验证必需的配置
if [ -z "$SERVER_USER" ] || [ -z "$SERVER_HOST" ] || [ -z "$TARGET_PATH" ]; then
  echo "❌ 配置不完整，请检查 .deploy.config 文件"
  exit 1
fi

# 设置默认端口和密钥
SSH_PORT=${SSH_PORT:-22}

# 展开 ~ 为实际路径
if [ -n "$SSH_KEY" ]; then
  SSH_KEY="${SSH_KEY/#\~/$HOME}"
  if [ ! -f "$SSH_KEY" ]; then
    echo "❌ SSH 密钥不存在: $SSH_KEY"
    exit 1
  fi
  SSH_CMD="ssh -i $SSH_KEY -p $SSH_PORT"
  echo "🔑 使用 SSH 密钥: $SSH_KEY"
else
  SSH_CMD="ssh -p $SSH_PORT"
fi

echo "🚀 开始本地构建..."

# 1. 构建项目
npm run build

echo "✅ 构建完成！"
echo ""
echo "📦 准备部署到服务器..."
echo "   服务器: $SERVER_USER@$SERVER_HOST:$SSH_PORT"
echo "   目标路径: $TARGET_PATH"
echo ""

# 2. 使用 rsync 同步文件（推荐，更高效）
# 如果服务器没有 rsync，可以注释掉这行，使用下面的 scp 方式
rsync -avz --delete \
  -e "$SSH_CMD" \
  blog/ \
  $SERVER_USER@$SERVER_HOST:$TARGET_PATH/

# 或者使用 scp 方式（注释掉上面的 rsync，取消下面的注释）
# if [ -n "$SSH_KEY" ]; then
#   scp -i "$SSH_KEY" -r -P $SSH_PORT blog/* $SERVER_USER@$SERVER_HOST:$TARGET_PATH/
# else
#   scp -r -P $SSH_PORT blog/* $SERVER_USER@$SERVER_HOST:$TARGET_PATH/
# fi

echo ""
echo "✅ 部署完成！"
echo ""
echo "🔍 验证部署..."

# 3. 验证部署
if [ -n "$SSH_KEY" ]; then
  ssh -i "$SSH_KEY" -p $SSH_PORT $SERVER_USER@$SERVER_HOST << ENDSSH
echo "目标目录内容:"
ls -lh $TARGET_PATH | head -15
echo ""
if [ -f "$TARGET_PATH/index.html" ]; then
  echo "✅ index.html 存在"
else
  echo "❌ index.html 不存在，部署可能有问题！"
fi
ENDSSH
else
  ssh -p $SSH_PORT $SERVER_USER@$SERVER_HOST << ENDSSH
echo "目标目录内容:"
ls -lh $TARGET_PATH | head -15
echo ""
if [ -f "$TARGET_PATH/index.html" ]; then
  echo "✅ index.html 存在"
else
  echo "❌ index.html 不存在，部署可能有问题！"
fi
ENDSSH
fi

echo ""
echo "🎉 部署成功！你的网站已更新。"

