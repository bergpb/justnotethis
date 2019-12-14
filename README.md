### JustNoteThis

[![Actions Status](https://github.com/bergpb/justnotethis/workflows/Ruby/badge.svg)](https://github.com/bergpb/justnotethis/actions)

- A note app made with Ruby and Sinatra.
- See demo here: [https://justnotethis.herokuapp.com](https://justnotethis.herokuapp.com).
- You can use user: justnotethis and password: justnotethis to test application.

Instructions:
- Clone this app,
- Install dependencies with ```bundler```,
- Run db migrations and seeders ```rake db:create db:migrate db:seed```,
- Start app in development mode: ```rake serve```.


Generating a new migration:
- ```rake db:create_migration NAME=name_of_migration```,
- Edit file created in db/migrate/,
- Run: ```rake db:migrate```,


Running tests:
- You can run a single test file with ```ruby -Itest tests/name_of_file.rb```
- Or running all tests: ```rake test```