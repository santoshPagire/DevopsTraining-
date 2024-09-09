# Use the official Nginx image from Docker Hub
FROM nginx:latest

# Copy custom Nginx configuration file into the container
# If you have custom configurations, you can include them
COPY nginx.conf /etc/nginx/nginx.conf

# Copy your web content into the container
# This example assumes you have a directory named `public-html` with your web content
COPY /css /usr/share/nginx/html/css
COPY /img /usr/share/nginx/html/img
COPY /js /usr/share/nginx/html/js
COPY /lib /usr/share/nginx/html/lib
COPY /scss /usr/share/nginx/html/scss
COPY  /*.html /usr/share/nginx/html/
COPY  /*.jpg /usr/share/nginx/html/
COPY  /*.txt /usr/share/nginx/html/
# Expose port 80 to the outside world
EXPOSE 80

# No CMD required as the base image already has a default CMD to start Nginx
