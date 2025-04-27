# 第一阶段：构建 Vue 项目
FROM --platform=$TARGETPLATFORM node:20 AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build  # 生成 dist 目录

# 第二阶段：使用 Nginx 服务静态文件

FROM --platform=$TARGETPLATFORM nginx:stable

COPY --from=builder /app/dist /usr/share/nginx/html
COPY nginx/nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
