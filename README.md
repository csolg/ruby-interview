## Requirements

* [Docker & Docker compose](https://docs.docker.com/compose/install/)

## Install

### First install

### Install development environment

```bash
make provision
```

### Install test environment
```
RAILS_ENV=test make provision
```

## Usage

all actual tasks you can see in Makefile

### Launch tests

```
make test
```

### Go to app container

```
make bash
```

### Down containers

```
make down
```

down and remove all volumes:
```
make down-v
```
