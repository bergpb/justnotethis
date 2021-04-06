### JustNoteThis

[![Build Status](https://travis-ci.org/bergpb/justnotethis.svg?branch=master)](https://travis-ci.org/bergpb/justnotethis)
[![Actions Status](https://github.com/bergpb/justnotethis/workflows/Ruby/badge.svg)](https://github.com/bergpb/justnotethis/actions)
[![Requirements Status](https://requires.io/github/bergpb/justnotethis/requirements.svg?branch=master)](https://requires.io/github/bergpb/justnotethis/requirements/?branch=master)
[![codecov](https://codecov.io/gh/bergpb/justnotethis/branch/master/graph/badge.svg)](https://codecov.io/gh/bergpb/justnotethis)
[![Maintainability](https://api.codeclimate.com/v1/badges/3864ddc62c5a20293e0d/maintainability)](https://codeclimate.com/github/bergpb/justnotethis/maintainability)

- A note app made with Ruby and Sinatra.
- See demo here: [https://justnotethis.herokuapp.com](https://justnotethis.herokuapp.com).
- You can use user: justnotethis and password: justnotethis to test application.

- Using `rbenv` for ruby version management: [https://github.com/rbenv/rbenv](https://github.com/rbenv/rbenv)

Instructions:
- Clone this app,
- Enter in project folder,
- Set default ruby: ```rvm use ruby-2.6.5```,
- Install dependencies with ```bundle```,
- Run db migrations and seeders ```make migrate```,
- Start app in development mode: ```make serve```.


Generating a new migration:
- ```rake db:create_migration NAME=name_of_migration```,
- Edit file created in db/migrate/,
- Run: ```rake db:migrate```,


Running tests:
- Running tests: ```make test```
