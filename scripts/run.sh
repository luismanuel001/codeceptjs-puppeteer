#!/bin/sh

source /codecept/scripts/help.sh

# Check if tests are correctly mounted
if [[ -d "/tests/" ]]; then
    echo "CodeceptJS directory has been found."
    echo "Url: $TEST_ENV_PROTOCOL://$TEST_ENV_FQDN"

    # Run the tests
    cd /tests/

    if [[ ! -d "/tests/node_modules" ]]; then
        ln -sf /codecept/node_modules /tests
    fi
    if [ "$RUN_MULTIPLE" = true ]; then
        echo "Tests are split into chunks and executed in multiple processes."
        if [ ! "$CODECEPT_ARGS" ]; then
            echo "No CODECEPT_ARGS provided. Tests will procceed with --all option to run all configured runs"
            codeceptjs run-multiple --all
        else		
            codeceptjs run-multiple $CODECEPT_ARGS
        fi
    else
        codeceptjs run $CODECEPT_ARGS
    fi
else
    display_usage
fi