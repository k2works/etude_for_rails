#!/usr/bin/env bash
export DEV_APPLICATION_NAME=${APPLICATION_NAME}Development
export DEV_APP_ENV=development
export DEV_APP_REPOSITORY=YourRepository
export DEV_BRANCH=development
export DEV_DB=${APPLICATION_PREFIX}_development
export DEV_SSH_KEY=dev-$APPLICATION_PREFIX.pem
export DEV_SSH_KEY_NAME=dev-$APPLICATION_PREFIX
