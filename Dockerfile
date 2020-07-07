## Builder phase. Build all the contents we need under "/app/build" inside the "builder" container
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

## Run phase. Use nginx image
FROM nginx
# Nginix automatically host the static files under "/usr/share/nginx/html" on port=80 when this
# container get started
COPY --from=builder /app/build /usr/share/nginx/html
