#!/usr/bin/ruby
# -*- coding: utf-8 -*-
#
# Creo este script en vez de emplear un 'diff', que sería más simple,
# porque nos da algo más de plasticidad ante un original que, a fin de
# cuentas, es autogenerado y puede cambiar de formas muy incómodas
# para un parchado automático

raise 'Indique el nombre de los archivos .tex fuente y destino.' unless ARGV.size == 2
src = ARGV[0]
dst = ARGV[1]
dstdir = File.dirname(dst)

raise 'Archivo fuente «%s» no legible' % src unless File.exists?(src) and File.readable?(src)
raise 'El archivo destino «%s» ya existe' % dst if File.exists?(dst)
raise 'El directorio destino «%s» es incorrecto o no permite escritura' % dstdir unless File.directory?(dstdir) and File.writable?(dstdir)

src = File.open(src, 'r')
dst = File.open(dst, 'w')

# El preámbulo de LATIn es distinto que el que generamos normalmente —
# Va antes de comenzar a procesar el archivo fuente.
dst.puts DATA.read

src.readlines.each do |line|
  # Líneas a excluir del documento resultante
  next if line =~ /^(\\documentclass\{book\}|\\usepackage\[utf8\]\{inputenc\}|\\linespread\{1.05\}|\\maketitle|\\setcounter{tocdepth}{2}|\\tableofcontents|\\vspace\*\{1cm\}|\\setcounter\{tocdepth\}\{2\})$/

  if line =~ /^\\definecolor\{string\}/
    dst.puts '\usepackage{anysize}'
  end

  if line =~ /^\\begin\{document\}/
    dst.puts '\input{structure} % Insert the commands.tex file which contains the majority of the structure behind the template',
    '\usepackage{pdfpages}',
    '\marginsize{3cm}{3cm}{1.5cm}{1.8cm}',
    '\pagestyle{empty}',
    '\begin{document}',
    '\includepdf{portada.png} %en esta imagen deben ir los nombres de los autores',
    '%----------------------------------------------------------------------------------------',
    '%	COPYRIGHT PAGE',
    '%----------------------------------------------------------------------------------------',
    '\pagestyle{empty}',
    '\include{primerapag}',
    '%----------------------------------------------------------------------------------------',
    '%	TABLE OF CONTENTS',
    '%----------------------------------------------------------------------------------------',
    '\chapterimage{cabecera.jpg}',
    '\pagestyle{empty} % No headers',
    '\tableofcontents % Print the table of contents itself',
    '\cleardoublepage % Forces the first chapter to start on an odd page so it\'s on the right',
    '\pagestyle{fancy} % Print headers again'
    next
  end

  if line =~ /\\end{document}/
    dst.puts '\\newpage', '\\pagestyle{empty}', '\\include{pagfinal}'
  end

  dst.puts line
end


__END__
%----------------------------------------------------------------------------------------
%	PACKAGES AND OTHER DOCUMENT CONFIGURATIONS
%----------------------------------------------------------------------------------------

\documentclass[11pt,fleqn]{book} % Default font size and left-justified equations

\usepackage[top=3cm,bottom=3cm,left=3.2cm,right=3.2cm,headsep=10pt,a4paper]{geometry} % Page margins

\usepackage{xcolor} % Required for specifying colors by name
\definecolor{Myblue}{RGB}{79,129,189}
% Font Settings
\usepackage{avant} % Use the Avantgarde font for headings
%\usepackage{times} % Use the Times font for headings
\usepackage{mathptmx} % Use the Adobe Times Roman as the default text font together with math symbols from the Sym­bol, Chancery and Com­puter Modern fonts

\usepackage{microtype} % Slightly tweak font spacing for aesthetics
\usepackage[utf8]{inputenc} % Required for including letters with accents
\usepackage[T1]{fontenc} % Use 8-bit encoding that has 256 glyphs

%\usepackage{hyperref}
\usepackage[pdfpagemode=UseOutlines,
            bookmarksnumbered,pdfpagelabels=true,plainpages=false,pdfstartview=FitH,
            colorlinks=true,linkcolor=black,citecolor=black,urlcolor=blue]{hyperref}

\usepackage{enumerate}
\usepackage[shortlabels]{enumitem}
\usepackage{media9}  
%\usepackage{ipa}


% Bibliography
\usepackage[style=alphabetic,sorting=nyt,sortcites=true,autopunct=true,babel=hyphen,hyperref=true,abbreviate=false,backref=true,backend=biber]{biblatex}
\addbibresource{bibliography.bib} % BibTeX bibliography file
\defbibheading{bibempty}{}


% Index
\usepackage{calc} % For simpler calculation - used for spacing the index letter headings correctly
\usepackage{makeidx} % Required to make an index
\makeindex % Tells LaTeX to create the files required for indexing


\usepackage[T1]{fontenc}
