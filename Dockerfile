FROM butterflydev/docker-symfony

COPY . .


RUN rm -Rf \
    .circle \
    docker \
    tests

RUN rm -f \
    bin/app.sh \
    bin/install.sh \
    web/app_dev.php \
    .env.dist \
    .gitignore \
    Dockerfile \
    Makefile \
    phpcs.xml \
    phpmd.xml \
    phpunit.xml \
    README.md

RUN composer install -n