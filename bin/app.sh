#!/bin/bash

pull ()
{
    ${DOCKER_COMPOSE} pull
}

build ()
{
    ${DOCKER_COMPOSE} build --force-rm
}

run ()
{
    ${DOCKER_COMPOSE} up -d --build --force-recreate

}

stop ()
{
    ${DOCKER_COMPOSE} stop
}

destroy ()
{
    ${DOCKER_COMPOSE} down -v --rmi local
}

ps ()
{
    ${DOCKER_COMPOSE} ps
}

bash ()
{
    ${DOCKER_COMPOSE} exec --user www-data php bash
}

badmin ()
{
    ${DOCKER_COMPOSE} exec php bash
}

exec ()
{
    ARGS=$@

     ${DOCKER_COMPOSE} exec --user www-data -T php ${ARGS}
}

exec-root ()
{
    ARGS=$@

    ${DOCKER_COMPOSE} exec -T php ${ARGS}
}

composer ()
{
    ARGS=$@

    ${DOCKER_COMPOSE} exec -T --user www-data php composer ${ARGS}
}

console ()
{
    declare ARGS=$@
    ${DOCKER_COMPOSE} exec -T --user www-data php bin/console ${ARGS}
}

tests ()
{
    ${DOCKER_COMPOSE} exec -T --user www-data php ./vendor/bin/simple-phpunit --coverage-text --colors=never
}


lint ()
{
    echo "Lint..."
    ${DOCKER_COMPOSE} exec -T --user www-data php find src -name '*.php' -exec php -l {} \; || EXIT_STATUS=$?
    echo "PHP CS..."
    ${DOCKER_COMPOSE} exec -T --user www-data php ./vendor/bin/phpcs --standard=phpcs.xml --extensions=php --ignore='var/,vendor/,app/AppKernel.php' src || EXIT_STATUS=$?
    echo "PHP MD..."
    ${DOCKER_COMPOSE} exec -T --user www-data php ./vendor/bin/phpmd src/ text phpmd.xml --exclude 'tests/,var/,vendor/' --suffixes php || EXIT_STATUS=$?
    echo "PHP CPD..."
    ${DOCKER_COMPOSE} exec -T --user www-data php ./vendor/bin/phpcpd src/ || EXIT_STATUS=$?

    exit $EXIT_STATUS
}

usage ()
{
    echo "usage: bin/docker [ENV] COMMAND [ARGUMENTS]

    pull                Pull images for this project
    build               Build containers for this project
    run                 Run containers for this project
    stop                Stop containers for this project
    destroy             Remove containers for this project
    ps                  List containers for this container
    bash                Run bash inside app container
    badmin              Run bash inside app container has root
    exec                Execute command inside container app
    exec-root           Execute command has root inside container app
    composer            Execute composer inside container app
    console             Execute bin/console symfony inside container app
    tests               Run test inside app container
    lint                Run code style inside app container

    "
}

main ()
{
    CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
    DOCKER_COMPOSE_FILE="$CURRENT_DIR/../docker/docker-compose.yml"

    declare DOCKER_COMPOSE="docker-compose -f $DOCKER_COMPOSE_FILE"

    if [ -z $1 ]; then
        usage
        exit 0
    fi

    COMMAND=$1


    if [[ ! "$COMMAND" =~ ^pull|build|run|stop|destroy|ps|bash|badmin|exec|exec-root|composer|tests|lint$ ]]; then
        echo "$COMMAND is not a supported command"
        exit 1
    fi

    $@
}

main $@