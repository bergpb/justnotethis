### JustTaskThis

- A task app made with Ruby and Sinatra.

Instructions:
- Clone this app,
- Install dependencies with ```bundler```,
- Run db migrations and seeders ```rake db:create db:migrate db:seed```,
- Start app in development mode: ```rake serve```.


Generating a new migration:
- ```rake db:create_migration NAME=name_of_migration```,
- Open file created in db/migrate,
- Run: ```rake db:migrate```,

