.PHONY: hoedown clean-hoedown compile-hoedown update-hoedown

hoedown: clean-hoedown update-hoedown compile-hoedown

compile-hoedown:
	cd lib/hoedown && $(MAKE)

clean-hoedown:
	cd lib/hoedown && $(MAKE) clean

update-hoedown:
	git submodule init
	git submodule update
	echo "If the submodule was updated, remember to push!"
