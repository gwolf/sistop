#!/usr/bin/make -f
baseurl = http://sistop.gwolf.org

publish_dest = gwolf@gwolf.org:/home/gwolf/sistop.gwolf.org

publish_src_html = ./html/*
publish_src_pdf = ./pdf/*
publish_src_pdf = ./biblio/*

dir_semestre = por_semestre/2013-2
dir_laminas = laminas

idx_semestre = $(dir_semestre)/index.org
idx_laminas = $(dir_laminas)/index.org
exam_resueltos = examenes/resueltos

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
	echo '#+TITLE: SISTEMAS OPERATIVOS — Láminas de clase' > $(idx_laminas)
	echo '#+AUTHOR: Gunnar Wolf' >> $(idx_laminas)
	echo '#+EMAIL: gwolf@sistop.org' >> $(idx_laminas)
	echo '#+LANGUAGE: es' >> $(idx_laminas)
	echo '#+STYLE: <link rel="stylesheet" type="text/css" href="/css/sistop.css" />' >> $(idx_laminas)
	echo '* Láminas disponibles' >> $(idx_laminas)
	echo '| *Fecha* | Título |' >> $(idx_laminas)
	echo '|--|--|' >> $(idx_laminas)
	for i in `ls laminas/*.org | grep -v index.org | sort -n`; do \
	    title=`grep -i '#+title:' $$i | sed 's/#+title://i'` \
	    date=`grep -i '#+date:' $$i | sed 's/#+date://i'` \
	    pdf=`echo $$i|sed s/.org$$/.pdf/`; \
	    if [ ! -f $$pdf -o $$i -nt $$pdf ] ; then \
		emacs --batch --visit=$$i --load ~/.emacs --eval '(setq org-confirm-babel-evaluate nil)' --funcall=org-mode --funcall=org-export-as-pdf ; \
	    fi ; \
	    echo "| $$date | [[$(baseurl)/$$pdf][$$title]] |" >> $(idx_laminas); \
	done
	emacs --batch --visit=$(idx_laminas) --load ~/.emacs --eval '(setq org-confirm-babel-evaluate nil)' --funcall=org-mode --funcall=org-export-as-html
	rm $(idx_laminas)

semestre:
	[ -d $(dir_semestre) ] || mkdir -p $(dir_semestre);
	echo '#+TITLE: SISTEMAS OPERATIVOS — Información para los alumnos del semestre actual' > $(idx_semestre)
	echo '#+AUTHOR: Gunnar Wolf' >> $(idx_semestre)
	echo '#+EMAIL: gwolf@sistop.org' >> $(idx_semestre)
	echo '#+LANGUAGE: es' >> $(idx_semestre)
	echo '#+OPTIONS: toc:nil' >> $(idx_semestre)
	echo '#+STYLE: <link rel="stylesheet" type="text/css" href="/css/sistop.css" />' >> $(idx_semestre)
	echo '* Listas' >> $(idx_semestre)
	echo '- [[./lista.html#sec-1][Asistencia]]' >> $(idx_semestre)
	echo '- [[./lista.html#sec-2][Tareas y participaciones]]' >> $(idx_semestre)
	echo '- [[./lista.html#sec-3][Exámenes]]' >> $(idx_semestre)
	emacs --batch --visit=docente/lista.org --load ~/.emacs --eval '(setq org-confirm-babel-evaluate nil)' --funcall=org-mode --funcall=org-export-as-html
	mv docente/lista.html $(dir_semestre)
	echo '* Exámenes resueltos' >> $(idx_semestre)
	mkdir -p $(exam_resueltos)/ltxpng
	for i in `ls $(exam_resueltos)/*.org | sort -n`; do \
	    title=`grep -i '#+title:' $$i | sed 's/#+title://i'` \
	    date=`grep -i '#+date:' $$i | sed 's/#+date://i'` \
	    pdf=`echo $$i|sed s/.org$$/.pdf/`; \
	    if [ ! -f $$pdf -o $$i -nt $$pdf ] ; then \
		emacs --batch --visit=$$i --load ~/.emacs --eval '(setq org-confirm-babel-evaluate nil)' --funcall=org-mode --funcall=org-export-as-pdf ; \
	    fi ; \
	    cp $$pdf $(dir_semestre); \
	    pdf_aqui=`basename $$pdf`; \
	    echo "- [[./$$pdf_aqui][$$title]] ($$date)" >> $(idx_semestre); \
	done

	emacs --batch --visit=$(idx_semestre) --load ~/.emacs --eval '(setq org-confirm-babel-evaluate nil)' --funcall=org-mode --funcall=org-export-as-html
clean-publish-cache:
	rm -f ~/.org-timestamps/notas*.cache

clean: clean-publish-cache
	rm -f ltxpng/*.png dot notas/*.tex notas/*.html notas/*.pdf laminas/*.tex laminas/*.html laminas/*.pdf
	rm -fr $(dir_semestre) $(idx_semestre) $(exam_resueltos)/*.tex $(exam_resueltos)/*.pdf
	rm -rf html
	rm -rf pdf

push: push_html push_pdf push_biblio push_beamer push_semestre

push_html: html
	rsync -av --delete ./html/* $(publish_dest)/html

push_pdf: pdf
	rsync -av --delete ./pdf/* $(publish_dest)/pdf

push_biblio:
	rsync -av --delete ./biblio/* $(publish_dest)/biblio

push_beamer:
	rsync -av --delete ./$(dir_laminas)/* $(publish_dest)/$(dir_laminas)

push_semestre: semestre
	rsync -av --delete ./$(dir_semestre)/* $(publish_dest)/$(dir_semestre)

all: pdf html beamer
