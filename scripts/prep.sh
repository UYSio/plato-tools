#!/usr/bin/env bash
# Prepares plato for development.
# - copies .plato config to user's home
# - modifies config to point to a couple of example content locations
# TODO - example locations to be used with tests

FORCE=${1:-"nah"}

CONF=~/.plato 
source scripts/dev-config

fresh() {
	rm -rf $CONF

	echo "$0 >> Copying .plato to $HOME"
	cp -R .plato $CONF

	echo "$0 >> Using $PWD/examples as content locations..."
	perl -pi -e 's/LOC1/$ENV{LOC1}/g' $CONF/config.rkt
	perl -pi -e 's/LOC2/$ENV{LOC2}/g' $CONF/config.rkt
	perl -pi -e 's/LOC3/$ENV{LOC3}/g' $CONF/config.rkt
	perl -pi -e 's/LOC4/$ENV{LOC4}/g' $CONF/config.rkt
	perl -pi -e 's/OUT_ROOT/$ENV{OUT_ROOT}/g' $CONF/config.rkt
	perl -pi -e 's/OUT_ENTRIES/$ENV{OUT_ENTRIES}/g' $CONF/config.rkt
}

while true; do
	if [ -d $CONF ]; then
		if [[ $FORCE == "nah" ]] ; then
			read -p "$CONF exists - rewrite? (y/n) or Ctrl-C " YN
		else
			YN=y
		fi
		case $YN in
			[Yy]* ) fresh; break;;
			[Nn]* ) exit;;
			* ) echo "try y/n/Ctrl-C";;
		esac
	fi
done


