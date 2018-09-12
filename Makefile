default : check kitchen

check : rubocop foodcritic

rubocop :
	/opt/chefdk/embedded/bin/rubocop .

foodcritic :
	/opt/chefdk/embedded/bin/foodcritic -P -f any .

travis : check
	kitchen verify

kitchen :
	/opt/chefdk/embedded/bin/kitchen test

.PHONY:
	rubocop foodcritic kitchen
