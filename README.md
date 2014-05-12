## Reflective

This project presents my portfolio. All my programming experience
is here - http://pempel.in/work. This site is available for viewing
in any *modern* browser.

## Creating Multiple Environments

Instead of installing all required software packages
on your host operating system, you can isolate them
using [vagrant](http://vagrantup.com). To create
complete development and test environments, you can use:

    vagrant up reflective-dev
    vagrant up reflective-test

## Deploying to Multiple Environments

To deploy the application to the development environment, you can use:

    vagrant ssh reflective-dev
    cd /var/apps/reflective
    mina app:deploy

To deploy the application to test and live environments for the first time,
you can use:

    vagrant ssh reflective-dev
    cd /var/apps/reflective
    mina app:deploy env=test password=vagrant

    vagrant ssh reflective-dev
    cd /var/apps/reflective
    mina app:deploy env=live password=your_favorite_secret_password

To deploy the application to test and live environments for the next time,
you can use:

    vagrant ssh reflective-dev
    cd /var/apps/reflective
    mina app:deploy env=test

    vagrant ssh reflective-dev
    cd /var/apps/reflective
    mina app:deploy env=live
