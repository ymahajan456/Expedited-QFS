
DIRS = 	$(wildcard ex_*)

.phony: build  tar
build:
	@echo "********** cleaning out objects **********"
	make clean
	make tar

tar:
	@echo "********** pack up examples **********"
	tar zcvf SmallExamples.tar.gz --exclude .svn ex* index.html README.txt Makefile.include

# call each directory and cleanup, just in case I forgot something
.phony: clean fullclean
fullclean clean: 
	@make $(foreach var,$(DIRS),$(var).clean)

# each directory gets called with "fullclean"
.phony: %.clean
%.clean: 
	cd $(subst .clean,,$@) && make fullclean
