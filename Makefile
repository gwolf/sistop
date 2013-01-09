#!/usr/bin/make -f
html: dot
	for i in *.org; do \
	    h=`echo $$i|sed s/.org$$/.html/`; \
	    if [ ! -f $$h -o $$i -nt $$h ] ; then \
		emacs -Q --batch --visit=$$i --eval '(setq make-backup-files nil)' --funcall=org-mode --funcall=org-export-as-html ; \
	    fi ; done

pdf: dot
	for i in *.org; do \
	    h=`echo $$i|sed s/.org$$/.pdf/`; \
	    if [ ! -f $$h -o $$i -nt $$h ] ; then \
		emacs -Q --batch --visit=$$i --eval '(setq make-backup-files nil)' --funcall=org-mode --funcall=org-export-as-pdf ; \
	    fi ; done

all: html

dot: img/*.dot
	for i in img/*.dot; do \
	    p=`echo $$i|sed s/.dot$$/.png/`; \
	    dot -Tpng $$i > $$p ; \
	done
	touch dot

clean:
	rm -f ltxpng/*.png dot
	for i in *.org; do \
	    h=`echo $$i|sed s/.org$$/.html/`; \
	    l=`echo $$i|sed s/.org$$/.tex/`; \
	    p=`echo $$i|sed s/.org$$/.pdf/`; \
	    rm -f $$h $$l $$p; \
	done
	for i in img/*.dot; do \
	    p=`echo $$i|sed s/.dot$$/.png/`; \
	    rm -f $$p; \
	done
