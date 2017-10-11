#!/bin/bash

rm -f .env.* \
    .gitignore \
    credential_key.json \
    phpcs.xml \
    phpmd.xml \
    phpunit.xml \
    README.md \
    web/app_dev.php

rm -Rf .circleci \
    tests