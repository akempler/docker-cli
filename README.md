# Drupal Development CLI Tools

CLI tools for Drupal development such as php, drush, console, composer, npm, gulp, nodejs, etc.


## Compose

```yml
cli:
    depends_on:
      mysql:
        condition: service_started
    build: ./docker/cli
    volumes:
      - ./db:/var/db # Used to import databases from command line
    volumes_from:
      - apache
    links:
      - mysql
      - apache
    environment:
      MYSQL_HOST: mysql
      MYSQL_ROOT_PASSWORD: rootpassword
      MYSQL_DATABASE: drupal
      MYSQL_USER: drupal
      MYSQL_PASSWORD: password
```

## Run

```sh
docker run -d akempler/cli:7.2
docker run -it akempler/cli:7.2 /bin/bash
```
