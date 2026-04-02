FROM php:7.4-apache

# Cài đặt các thư viện hệ thống cần thiết
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    git \
    curl

# Xóa cache để giảm dung lượng image
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Cài đặt các extension PHP để kết nối MySQL (Database Server trong sơ đồ)
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd mysqli

# Thiết lập thư mục làm việc
WORKDIR /var/www/html

# Copy toàn bộ code từ GitHub vào container
COPY . /var/www/html

# Cấp quyền cho web server
RUN chown -R www-data:www-data /var/www/html

# Mở cổng 80
EXPOSE 80

# Chạy Apache
CMD ["apache2-foreground"]