#!/usr/bin/make -f
baseurl = http://sistop.gwolf.org

publish_dest = gwolf@gwolf.org:/home/gwolf/sistop.gwolf.org

publish_src_html = ./html/*
publish_src_pdf = ./pdf/*
publish_src_pdf = ./biblio/*

publish:
	emacs --batch --load ~/.emacs --load publish.el --funcall org-publish-all

html:
	mkdir -p html/ltxpng
	echo html | emacs --batch --load ~/.emacs --load publish.el --funcall org-publish-project
	ln -s ../pdf html/pdf || true
	ln -s ../biblio html/biblio || true
	ln -s ../laminas html/laminas || true

pdf:
	mkdir -p pdf/ltxpng
	echo pdf | emacs --batch --load ~/.emacs --load publish.el --funcall org-publish-project

beamer:
	echo '#+TITLE: SISTEMAS OPERATIVOS — Láminas de clase' > laminas/index.org
	echo '#+AUTHOR: Gunnar Wolf' >> laminas/index.org
	echo '#+EMAIL: gwolf@sistop.org' >> laminas/index.org
	echo '#+LANGUAGE: es' >> laminas/index.org
	echo '* Láminas disponibles' >> laminas/index.org
	echo '| *Fecha* | Título |' >> laminas/index.org
	echo '|--|--|' >> laminas/index.org
	for i in `ls laminas/*.org | grep -v index.org | sort -n`; do \
	    title=`grep -i '#+title:' $$i | sed 's/#+title://i'` \
	    date=`grep -i '#+date:' $$i | sed 's/#+date://i'` \
	    pdf=`echo $$i|sed s/.org$$/.pdf/`; \
	    if [ ! -f $$pdf -o $$i -nt $$pdf ] ; then \
		emacs -Q --batch --visit=$$i --load ~/.emacs --eval '(setq org-confirm-babel-evaluate nil)' --funcall=org-mode --funcall=org-export-as-pdf ; \
	    fi ; \
	    echo "| $$date | [[$(baseurl)/$$pdf][$$title]] |" >> laminas/index.org; \
	done
	emacs -Q --batch --visit=laminas/index.org --load ~/.emacs --eval '(setq org-confirm-babel-evaluate nil)' --funcall=org-mode --funcall=org-export-as-html
	rm laminas/index.org

clean-publish-cache:
	rm -f ~/.org-timestamps/notas*.cache

clean: clean-publish-cache
	rm -f ltxpng/*.png dot notas/*.tex notas/*.html notas/*.pdf laminas/*.tex laminas/*.html laminas/*.pdf
	rm -rf html
	rm -rf pdf

push: push_html push_pdf push_biblio push_beamer

push_html: html
	rsync -av --delete ./html/* $(publish_dest)/html

push_pdf: pdf
	rsync -av --delete ./pdf/* $(publish_dest)/pdf

push_biblio:
	rsync -av --delete ./biblio/* $(publish_dest)/biblio

push_beamer:
	rsync -av --delete ./laminas/* $(publish_dest)/laminas

all: pdf html beamer
