#!/usr/bin/make -f
baseurl = http://sistop.gwolf.org

publish_dest_html = gwolf@gwolf.org:/home/gwolf/sistop.gwolf.org/html/
publish_dest_pdf = gwolf@gwolf.org:/home/gwolf/sistop.gwolf.org/pdf/

publish_src_html = ./html/*
publish_src_pdf = ./pdf/*

publish:
	emacs --batch --load ~/.emacs --load publish.el --funcall org-publish-all

html:
	echo html | emacs --batch --load ~/.emacs --load publish.el --funcall org-publish-project

pdf:
	echo pdf | emacs --batch --load ~/.emacs --load publish.el --funcall org-publish-project

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

clean-publish-cache:
	rm -f ~/.org-timestamps/notas*.cache

clean: clean-publish-cache
	rm -f ltxpng/*.png dot
	rm -rf html
	rm -rf pdf

push: push_html push_pdf

push_html: html
	rsync -av --delete $(publish_src_html) $(publish_dest_html)

push_pdf: pdf
	rsync -av --delete $(publish_src_pdf) $(publish_dest_pdf)

all: pdf html beamer
