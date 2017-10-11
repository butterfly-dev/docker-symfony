#!/bin/bash

bin/app.sh composer install -n
bin/app.sh console doctrine:schema:update -f
bin/app.sh console  doctrine:mongodb:schema:update