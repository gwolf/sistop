#!/usr/bin/make -f
baseurl = http://sistop.gwolf.org

publish_dest = gwolf@gwolf.org:/home/gwolf/sistop.gwolf.org

publish_src_html = ./html/*
publish_src_pdf = ./pdf/*
publish_src_pdf = ./biblio/*

dir_semestre = por_semestre/2014-1
dir_laminas = laminas

idx_semestre = $(dir_semestre)/index.org
idx_laminas = $(dir_laminas)/index.org
exam_resueltos = examenes/resueltos

temas_in = tareas/temas.org
temas_out = tareas/temas.html

publish:
	emacs --batch --load ~/.emacs --load publish.el --funcall org-publish-all

html: fig
	mkdir -p html/ltxpng
	echo html | emacs --batch --load ~/.emacs --load publish.el --funcall org-publish-project
	ln -s ../pdf html/pdf || true
	ln -s ../biblio html/biblio || true
	ln -s ../laminas html/laminas || true
	emacs --batch --visit=$(temas_in) --load ~/.emacs --eval '(setq org-confirm-babel-evaluate nil)' --funcall=org-mode --funcall=org-export-as-html
	mv $(temas_out) html/

pdf: fig
	mkdir -p pdf/ltxpng
	echo pdf | emacs --batch --load ~/.emacs --load publish.el --funcall org-publish-project

beamer: fig
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
#	echo '- [[./lista.html#sec-5][Globales]]' >> $(idx_semestre)
#	echo '- [[./lista.html#sec-6][Finales para actas]]' >> $(idx_semestre)
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

clean: clean-publish-cache clean_fig
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


fig: fig_dot fig_ditaa fig_gnuplot
clean_fig: clean_dot clean_ditaa clean_gnuplot

DOT_FIGS = $(wildcard fig/*.dot)
DOT_IMGS = $(patsubst fig/%.dot,img/dot/%.png,$(DOT_FIGS))
img/dot/%.png: fig/%.dot
	@[ -d img/dot ] || mkdir img/dot
	dot -Tpng $(patsubst img/dot/%.png,fig/%.dot,$@) > $@
fig_dot: $(DOT_IMGS)
clean_dot:
	-rm -f $(DOT_IMGS)

DITAA_FIGS = $(wildcard fig/*.ditaa)
DITAA_IMGS = $(patsubst fig/%.ditaa,img/ditaa/%.png,$(DITAA_FIGS))
img/ditaa/%.png: fig/%.ditaa
	@[ -d img/ditaa ] || mkdir img/ditaa
	ditaa -E -o $(patsubst img/ditaa/%.png,fig/%.ditaa,$@) $@
fig_ditaa: $(DITAA_IMGS)
clean_ditaa:
	-rm -f $(DITAA_IMGS)

GNUPLOT_FIGS = $(wildcard fig/*.gnuplot)
GNUPLOT_IMGS = $(patsubst fig/%.gnuplot,img/gnuplot/%.png,$(GNUPLOT_FIGS))
img/gnuplot/%.png: fig/%.gnuplot
	@[ -d img/gnuplot ] || mkdir img/gnuplot
	gnuplot $(patsubst img/gnuplot/%.png,fig/%.gnuplot,$@) > $@
fig_gnuplot: $(GNUPLOT_IMGS)
clean_gnuplot:
	-rm -f $(GNUPLOT_IMGS)


all: pdf html beamer

.PHONY: fig pdf html clean push
