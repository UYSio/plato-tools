#!/usr/bin/env bash
# Prepares plato for development.
# - copies .plato config to user's home
# - modifies config to point to a couple of example content locations
# TODO - example locations to be used with tests

CONF=~/.plato 

fresh() {
	rm -rf $CONF

	echo "Copying .plato to $HOME"
	cp -R .plato $CONF

	echo "Using $PWD/examples as content locations..."
	EXAMPLES=$(pwd)/examples
	export LOC1=$EXAMPLES/over-here
	export LOC2=$EXAMPLES/over-there
	perl -pi -e 's/LOC1/$ENV{LOC1}/g' $CONF/config.rkt
	perl -pi -e 's/LOC2/$ENV{LOC2}/g' $CONF/config.rkt
}

while true; do
	if [ -d $CONF ]; then
		read -p "$CONF exists - rewrite? (y/n) or Ctrl-C " YN
		case $YN in
			[Yy]* ) fresh; break;;
			[Nn]* ) exit;;
			* ) echo "try y/n/Ctrl-C";;
		esac
	fi
done


