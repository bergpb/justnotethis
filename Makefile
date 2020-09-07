.PHONY: install migrate run test

install:
	@bundle

migrate:
	@rake db:create db:migrate db:seed

run:
	@rake serve

test:
	@RACK_ENV=test rake test