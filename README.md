[![CircleCI](https://circleci.com/gh/k2works/etude_for_rails.svg?style=svg)](https://circleci.com/gh/k2works/etude_for_rails)
[![Code Climate](https://codeclimate.com/github/k2works/etude_for_rails/badges/gpa.svg)](https://codeclimate.com/github/k2works/etude_for_rails)
[![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/k2works/etude_for_rails/master/MIT-LICENSE.txt)


# Etude for Rails

+ [BeerList](https://etude-for-rails.herokuapp.com/beer_lists/beer_list)
+ [IntroToReact](https://etude-for-rails.herokuapp.com/intro_to_reacts/intro_to_react)
+ [Excel](https://etude-for-rails.herokuapp.com/react_beginners_guide/excel)
+ [Whinepad](https://etude-for-rails.herokuapp.com/react_beginners_guide/whinepad/)

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
