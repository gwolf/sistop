#!/usr/bin/make -f
all:
	for i in *.org; do \
	    h=`echo $$i|sed s/.org$$/.html/`; \
	    if [ ! -f $$h -o $$i -nt $$h ] ; then \
		emacs -Q --batch --visit=$$i --funcall=org-mode --funcall=org-export-as-html ; \
	    fi ; done

clean:
	for i in *.org; do \
	    h=`echo $$i|sed s/.org$$/.html/`; \
	    l=`echo $$i|sed s/.org$$/.tex/`; \
	    p=`echo $$i|sed s/.org$$/.pdf/`; \
	    rm -f $$h $$l $$p; \
	done
