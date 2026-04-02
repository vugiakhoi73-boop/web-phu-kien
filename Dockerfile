FROM php:7.4-apache 
# (Khuyên dùng bản -apache để chạy web luôn, nếu dùng -fpm bạn sẽ cần thêm Nginx)

RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip

RUN apt-get clean && rm -rf /var/lib/apt/lists/*
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd mysqli

# SỬA Ở ĐÂY: Trỏ đúng vào thư mục html của Apache
WORKDIR /var/www/html

# Copy toàn bộ code vào /var/www/html
COPY . /var/www/html

# Cấp quyền cho user của web server
RUN chown -R www-data:www-data /var/www/html

EXPOSE 80
CMD ["apache2-foreground"]
