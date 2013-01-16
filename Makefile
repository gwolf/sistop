#!/usr/bin/make -f
html:
	for i in *.org; do \
	    h=`echo $$i|sed s/.org$$/.html/`; \
	    if [ ! -f $$h -o $$i -nt $$h ] ; then \
		emacs -Q --batch --visit=$$i --load ~/.emacs --eval '(setq org-confirm-babel-evaluate nil)' --funcall=org-mode --funcall=org-export-as-html ; \
	    fi ; done

pdf:
	for i in *.org; do \
	    h=`echo $$i|sed s/.org$$/.pdf/`; \
	    if [ ! -f $$h -o $$i -nt $$h ] ; then \
		emacs -Q --batch --visit=$$i --load ~/.emacs --eval '(setq org-confirm-babel-evaluate nil)' --funcall=org-mode --funcall=org-export-as-pdf ; \
	    fi ; done

all: html

clean:
	rm -f ltxpng/*.png dot
	for i in *.org; do \
	    h=`echo $$i|sed s/.org$$/.html/`; \
	    l=`echo $$i|sed s/.org$$/.tex/`; \
	    p=`echo $$i|sed s/.org$$/.pdf/`; \
	    rm -f $$h $$l $$p; \
	done
