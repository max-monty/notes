install:
	ln -fs $(HOME)/projects/notes/main.rb /usr/local/bin/notes
	chmod +x /usr/local/bin/notes
	ln -fs /usr/local/bin/notes /usr/local/bin/note	
	mkdir -p $(NOTESPATH)/stacks
	mkdir -p $(NOTESPATH)/projects
	touch $(NOTESPATH)/stacks/.notestack
