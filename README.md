### JustNoteThis

[![Actions Status](https://github.com/bergpb/justnotethis/workflows/Ruby/badge.svg)](https://github.com/bergpb/justnotethis/actions)

- A note app made with Ruby and Sinatra.
- See demo here: [https://justnotethis.herokuapp.com](https://justnotethis.herokuapp.com).
- You can use user: justnotethis and password: justnotethis to test application.

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
