[![CircleCI](https://circleci.com/gh/k2works/etude_for_rails.svg?style=svg)](https://circleci.com/gh/k2works/etude_for_rails)

# Etude for Rails

+ [BeerList](https://etude-for-rails.herokuapp.com/beer_lists/beer_list)
+ [IntroToReact](https://etude-for-rails.herokuapp.com/intro_to_reacts/intro_to_react)

## Quick Start
### Using Vagrant
```bash
vagrant up
vagrant ssh
cd /vagrant
./bin/server
```

### Using Docker
```bash
docker build . -t app:base
docker run --name app --rm -p 5000:5000 -p 9292:9292 -v $(PWD):/container -i -t app:base /bin/bash
cd /container
./bin/server
```
or
```bash
docker-compose build
docker-compose up
```

### Documents
```bash
bundle exec yard server
```
Documents is [here](./docs/README.md)
