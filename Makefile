.PHONY: install migrate run test

install:
	@bundle

migrate:
	@RACK_ENV=development rake db:create db:migrate db:seed

run:
	@RACK_ENV=development rake serve

test:
	@RACK_ENV=test rake test