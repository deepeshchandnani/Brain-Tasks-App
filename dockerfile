FROM nginx:alpine

# Remove default nginx config
RUN rm /etc/nginx/conf.d/default.conf

# Copy custom nginx config
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy React build files from dist
COPY dist/index.html /usr/share/nginx/html/
COPY dist/assets /usr/share/nginx/html/assets

EXPOSE 3000

CMD ["nginx", "-g", "daemon off;"]

