# 前端构建阶段（使用 Node 环境）
FROM node:16-alpine AS frontend-builder
WORKDIR /app/vue
COPY vue/ . 
RUN npm install && npm run build  # 安装依赖并构建前端

# 后端构建阶段（使用 Go 环境）
FROM golang:1.23-alpine AS backend-builder
WORKDIR /app
COPY go.mod go.sum ./  
RUN go mod download 
COPY . . 
COPY --from=frontend-builder /app/vue/dist ./public  
RUN CGO_ENABLED=0 GOOS=linux GOARCH=arm64 go build -o main main.go  # 编译 Go 二进制文件

# 最终运行阶段
FROM nginx:1.25.1-alpine
WORKDIR /app
COPY --from=backend-builder /app/main /usr/local/bin/main
COPY --from=frontend-builder /app/vue/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["sh", "-c", "nginx -g 'daemon off;' & main"]