# Dùng bản apache để có sẵn máy chủ web
FROM php:7.4-apache 

# Cài đặt các thư viện hệ thống cần thiết
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip

# Cài đặt các extension PHP để chạy MySQL và các hàm xử lý chuỗi
RUN docker-php-ext-install pdo_mysql mbstring mysqli

# QUAN TRỌNG: Chuyển vào đúng thư mục mà Apache yêu cầu
WORKDIR /var/www/html

# Copy toàn bộ code vào đúng thư mục html
COPY . /var/www/html

# Cấp quyền cho Apache có thể đọc/ghi file
RUN chown -R www-data:www-data /var/www/html

EXPOSE 80
CMD ["apache2-foreground"]
