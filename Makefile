.PHONY: all clean prep run hoedown clean-hoedown compile-hoedown update-hoedown

all: clean prep run

hoedown: clean-hoedown update-hoedown compile-hoedown

compile-hoedown:
	cd lib/hoedown && $(MAKE) && ln -s libhoedown.so.3 libhoedown.dylib 

clean-hoedown:
	cd lib/hoedown && $(MAKE) clean && rm libhoedown.so.3 libhoedown.dylib

update-hoedown:
	git submodule init
	git submodule update
	cd lib/hoedown
	git pull origin master
	cd ../..
	git status
	@echo "git add lib/hoedown"
	@echo "git commit -m \"hoedown updated\""

prep:
	@./scripts/prep.sh force

clean:
	@./scripts/clean.sh

run:
	@racket main.rkt
