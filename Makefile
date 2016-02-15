default : check kitchen

check : rubocop foodcritic

rubocop :
	/opt/chefdk/bin/rubocop .

foodcritic :
	/opt/chefdk/bin/foodcritic -P -f any .

travis : check
	kitchen verify

kitchen :
	/opt/chefdk/bin/kitchen test

.PHONY:
	rubocop foodcritic kitchen
