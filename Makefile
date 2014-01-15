#!/usr/bin/make -f
baseurl = http://sistop.gwolf.org

# Bajo este esquema, sólo Gunnar puede llamar a "make publish" y
# derivados. Bueno, confío en que quien quiera publicar a otro
# depósito lo modifique ;-)
publish_dest = gwolf@gwolf.org:/home/gwolf/sistop.gwolf.org

publish_src_html = ./html/*
publish_src_pdf = ./pdf/*
publish_src_pdf = ./biblio/*

dir_laminas = laminas
idx_laminas = $(dir_laminas)/index.org

libro = notas/sistemas_operativos.org

publish:
	emacs --batch --load ~/.emacs --load publish.el --funcall org-publish-all

html: fig
	mkdir -p html/ltxpng
	echo html | emacs --batch --load ~/.emacs --load publish.el --funcall org-publish-project
	ln -s ../pdf html/pdf || true
	ln -s ../biblio html/biblio || true
	ln -s ../laminas html/laminas || true
	emacs --batch --visit=$(temas_in) --load ~/.emacs --funcall=org-mode --funcall=org-export-as-html
	mv $(temas_out) html/

pdf: fig
	mkdir -p pdf/ltxpng
	echo pdf | emacs --batch --load ~/.emacs --load publish.el --funcall org-publish-project

libro_index:
	[ ! -f $(libro) ] || rm -f $(libro)
	echo '#+options: toc:4 H:4' > $(libro)
	echo '#+setupfile: ../setup_notas.org' >> $(libro)
	echo '#+latex_class: book' >> $(libro)
	echo '#+latex_header: \usepackage[T1]{fontenc}' >> $(libro)
	echo '#+latex_header: \usepackage{mathpazo}' >> $(libro)
	echo '#+latex_header: \linespread{1.05}' >> $(libro)
	echo '#+latex_header: \usepackage[scaled]{helvet}' >> $(libro)
	echo '#+latex_header: \usepackage{courier}' >> $(libro)
	echo '#+title: Sistemas Operativos' >> $(libro)

	echo '' >> $(libro)
	echo '#+latex: \\frontmatter' >> $(libro)
	echo '* Presentación' >> $(libro)
	echo '#+include: 00_presentacion.org :minlevel 1' >> $(libro)

	echo '' >> $(libro)
	echo '#+latex: \\mainmatter' >> $(libro)
	for CAPITULO in notas/01_introduccion.org \
			notas/02_estructuras_basicas.org \
			notas/03_administracion_de_procesos.org \
			notas/04_planificacion_de_procesos.org \
			notas/05_administracion_de_memoria.org \
			notas/06_organizacion_de_archivos.org \
			notas/07_sistemas_de_archivos.org ; do \
		FILE=`echo $$CAPITULO | sed s/notas.//`; \
		TITULO=`grep -i ^#+title: notas/$$FILE | sed s/^.*://`; \
		echo "* $$TITULO" >> $(libro) ; \
		echo "#+include: $$FILE :minlevel 1" >> $(libro); \
	done

	echo '' >> $(libro)
	echo '#+latex: \\appendix' >> $(libro)
	for APDX in notas/A1_sl_licenciamiento.org \
		notas/A2_virtualizacion.org \
	        notas/A3_medio_fisico.org; do \
		APDX=`echo $$APDX | sed s/notas.//`; \
		TITULO=`grep -i ^#+title: notas/$$APDX | sed s/^.*://`; \
		echo "* $$TITULO" >> $(libro) ; \
		echo "#+include: $$APDX :minlevel 1" >> $(libro); \
	done
	# No hay muchas tablas, este listado no tiene tanto sentido
	# echo "#+latex: \listoftables" >> $(libro)
	echo "#+latex: \listoffigures" >> $(libro)

libro_pdf: fig libro_index
	# Si org-mode se queja de no tener definido "book" en
	# org-export-latex-classes, referirse a
	# http://orgmode.org/worg/org-tutorials/org-latex-export.html
	emacs --batch --visit=$(libro) --load ~/.emacs --funcall=org-mode --funcall=org-export-as-pdf
	sed 's/usepackage{hyperref}/usepackage[unicode=true]{hyperref}/g' -i notas/sistemas_operativos.tex
	cd notas && cp sistemas_operativos.tex final.tex && pdflatex final.tex

beamer: fig
	echo '#+TITLE: SISTEMAS OPERATIVOS — Láminas de clase' > $(idx_laminas)
	echo '#+AUTHOR: Gunnar Wolf' >> $(idx_laminas)
	echo '#+EMAIL: gwolf@sistop.org' >> $(idx_laminas)
	echo '#+LANGUAGE: es' >> $(idx_laminas)
	echo '#+STYLE: <link rel="stylesheet" type="text/css" href="/css/sistop.css" />' >> $(idx_laminas)
	echo '* Láminas disponibles' >> $(idx_laminas)
	echo '| *Fecha* | Título | Último cambio' >> $(idx_laminas)
	echo '|--|--|' >> $(idx_laminas)
	for i in `ls laminas/*.org | grep -v index.org | sort -n`; do \
	    lastmod=`stat --format=%y $$i | perl -p -e 's/(\d\d:\d\d):.+/$$1/'` \
	    title=`grep -i '#+title:' $$i | sed 's/#+title://i'` \
	    date=`grep -i '#+date:' $$i | sed 's/#+date://i'` \
	    pdf=`echo $$i|sed s/.org$$/.pdf/`; \
	    if [ ! -f $$pdf -o $$i -nt $$pdf ] ; then \
		emacs --batch --visit=$$i --load ~/.emacs --funcall=org-mode --funcall=org-export-as-pdf ; \
	    fi ; \
	    echo "| $$date | [[$(baseurl)/$$pdf][$$title]] | $$lastmod" >> $(idx_laminas); \
	done
	emacs --batch --visit=$(idx_laminas) --load ~/.emacs --funcall=org-mode --funcall=org-export-as-html
	rm $(idx_laminas)

clean-publish-cache:
	rm -f ~/.org-timestamps/notas*.cache

clean: clean-publish-cache clean_fig
	rm -f notas/sistemas_operativos.*
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
	rsync -av --delete ./$(dir_laminas)/* $(publish_dest)/$(dir_laminas)

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
	java -jar /usr/share/ditaa/ditaa.jar -E -o $(patsubst img/ditaa/%.png,fig/%.ditaa,$@) $@
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
