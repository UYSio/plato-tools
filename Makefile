.PHONY: hoedown clean-hoedown compile-hoedown update-hoedown

hoedown: clean-hoedown update-hoedown compile-hoedown

compile-hoedown:
	cd lib/hoedown && $(MAKE)

clean-hoedown:
	cd lib/hoedown && $(MAKE) clean

update-hoedown:
	git submodule init
	git submodule update
	cd lib/hoedown
	git pull origin master
	cd ../..
	git status
	@echo "git add lib/hoedown"
	@echo "git commit -m \"hoedown updated\""
