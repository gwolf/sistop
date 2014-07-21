%
% this is a fast hack to format the documentation
%


\NeedsTeXFormat{LaTeX2e}[1994/12/01]
\ProvidesClass{aipdoc}[2000/08/21 v1.0a internal documentation class]

\LoadClass[a4paper,onecolumn]{article}

\addtolength\textheight{3cm}  % only if std article.cls is used
\addtolength\topmargin{-1.5cm}% only if std article.cls is used
\addtolength\textwidth {2cm}  % only if std article.cls is used
\setlength\parindent{0pt}
\setlength\parskip{2pt plus 1pt}

\usepackage[dvips]{graphics}

\usepackage{array}

\usepackage{doc}
\AtBeginDocument{\MakeShortVerb{\|}}
\CodelineIndex
\DisableCrossrefs
%\EnableCrossrefs
\setcounter{IndexColumns}{2}
\setlength\IndexMin{10\baselineskip}

\setcounter{StandardModuleDepth}{2}

\newcommand*\PBS[1]{\let\temp\\#1\let\\\temp}

\newenvironment{decl}
    {\par\small\addvspace{3.5ex plus 1ex}%
     \noindent\hspace{-\leftmargini}%
     \begin{tabular}{|l>{\PBS\raggedright}p{.9\linewidth}|}%
      \hline\ignorespaces}%
    {\crcr\hline\end{tabular}
     \vspace{2.3ex}\vskip -\parskip}
\newcommand\describeregister[4][]{%
  \textsf{R}#1 & \texttt{\string#2}\SpecialUsageIndex{#2}  (#3) \\[1pt]
      & #4\\[3pt]}
\newcommand\describemacro[4][]{%
   \textsf{M}#1 & \texttt{\string#2}\SpecialUsageIndex{#2}
                  #3  \\[1pt]  & #4\\[3pt]}
\newcommand\describecounter[3][]{%
   \textsf{C}#1 & \texttt{#2}\SpecialLayoutIndex{#2}{counter}
                  (counter) \\[1pt]  & #3\\[3pt]}
\newcommand\describeplayout[3][*]{%
   \textsf{L}#1 & \texttt{#2}\SpecialLayoutIndex{#2}{paragraph layout}
                  (paragraph layout) \\[1pt]  & #3\\[3pt]}
\newcommand\describepslayout[3][*]{%
   \textsf{L}#1 & \texttt{#2}\SpecialLayoutIndex{#2}{page style layout}
                 (page style layout) \\[1pt]  & #3\\[3pt]}
\newcommand\describeenvironment[4][]{%
   \textsf{E}#1 & \texttt{#2}\SpecialEnvIndex{#2}  #3 \\[1pt]  & #4\\[3pt]}

\newcommand\SpecialLayoutIndex[2]{%
    \index{#1\actualchar{\protect\ttfamily#1}
           (#2)\encapchar usage}%
    \index{#2s:\levelchar{\protect\ttfamily#1}\encapchar
           usage}}


\newenvironment{note}{\par\smallskip
 \footnotesize
 \setlength\parindent{0pt}%
 \setlength\parskip{1pt}%
 \textbf{Remarks:}%
}
{\par\medskip}
\newcommand*\Lenv[1]{{\normalfont\ttfamily #1}}
\newcommand\cs[1]{\textnormal{\ttfamily\bslash#1}}
\renewcommand{\arg}[1]{\unskip\nobreak\space
  {\ttfamily\string{}\meta{#1}{\ttfamily\string}}%
  \hspace{-2em}\allowbreak\hspace*{2em}%
  \ignorespaces}
\newcommand{\oarg}[1]{\unskip\nobreak\space
  {\ttfamily[}{#1}{\ttfamily]}%
  \hspace{-2em}\allowbreak\hspace*{2em}%
  \ignorespaces}
\newcommand{\type}[1]{\unskip\nobreak\space
  (#1) \ignorespaces}

\IndexPrologue
  {\section*{Index}%
   \markboth{Index}{Index}%
   Italic numbers refer to \emph{pages} on which the corresponding
   entry is described.
   Underlined numbers (if any) refer to \emph{numbered code
   lines} and point to the definition of a complex command.
  }


% temp fix for bug in makeindex version 2.13 
% it generate a null character
%
\catcode`\^^@=9

\endinput
