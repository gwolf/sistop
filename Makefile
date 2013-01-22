#!/usr/bin/make -f
baseurl = http://sistop.gwolf.org

html:
	for i in *.org; do \
	    html=`echo $$i|sed s/.org$$/.html/`; \
	    if [ ! -f $$html -o $$i -nt $$html ] ; then \
		emacs -Q --batch --visit=$$i --load ~/.emacs --eval '(setq org-confirm-babel-evaluate nil)' --funcall=org-mode --funcall=org-export-as-html ; \
	    fi ; done

pdf:
	for i in *.org; do \
	    pdf=`echo $$i|sed s/.org$$/.pdf/`; \
	    if [ ! -f $$pdf -o $$i -nt $$pdf ] ; then \
		emacs -Q --batch --visit=$$i --load ~/.emacs --eval '(setq org-confirm-babel-evaluate nil)' --funcall=org-mode --funcall=org-export-as-pdf ; \
	    fi ; done

beamer:
	echo '#+TITLE: SISTEMAS OPERATIVOS — Láminas de clase' > laminas/index.org
	echo '#+AUTHOR: Gunnar Wolf' >> laminas/index.org
	echo '#+EMAIL: gwolf@sistop.org' >> laminas/index.org
	echo '#+LANGUAGE: es' >> laminas/index.org
	echo '* Láminas disponibles'
	for i in `ls laminas/*.org | grep -v index.org | sort -n`; do \
	    title=`grep -i '#+title:' $$i | sed 's/#+title://i'` \
	    date=`grep -i '#+date:' $$i | sed 's/#+date://i'` \
	    pdf=`echo $$i|sed s/.org$$/.pdf/`; \
	    if [ ! -f $$pdf -o $$i -nt $$pdf ] ; then \
		emacs -Q --batch --visit=$$i --load ~/.emacs --eval '(setq org-confirm-babel-evaluate nil)' --funcall=org-mode --funcall=org-export-as-pdf ; \
	    fi ; \
	    echo "- [[$(baseurl)/$$pdf][$$title]] $$date" >> laminas/index.org; \
	done
	emacs -Q --batch --visit=laminas/index.org --load ~/.emacs --eval '(setq org-confirm-babel-evaluate nil)' --funcall=org-mode --funcall=org-export-as-html
	rm laminas/index.org

clean:
	rm -f ltxpng/*.png dot
	for i in *.org; do \
	    html=`echo $$i|sed s/.org$$/.html/`; \
	    tex=`echo $$i|sed s/.org$$/.tex/`; \
	    pdf=`echo $$i|sed s/.org$$/.pdf/`; \
	    rm -f $$html $$tex $$pdf; \
	done

all: pdf html beamer
