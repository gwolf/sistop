%%
%% This is file `aipproc.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% aipproc.dtx  (with options: `class')
%% 
%% Class aipproc to use with LaTeX2e
%% (C) 1998,2000 American Institute of Physics and Frank Mittelbach
%% All rights reserved
%% 
%% Class aipproc to use with LaTeX2e
%%
%% Copyright (C) 1998, 2000, 2001, 2002, 2004, 2005 Frank Mittelbach
%% Copyright (C) 1998, 2000, 2001, 2002, 2004, 2005 American Institute of Physics
%% All rights reserved.
%%
%% Development of this class was commissioned by American Institute of Physics.
%%
\NeedsTeXFormat{LaTeX2e}[1999/06/01]
\ProvidesClass{aipproc}
       [2005/11/11 v1.5a AIP Proceedings (FMi)]
%% \CharacterTable
%%  {Upper-case    \A\B\C\D\E\F\G\H\I\J\K\L\M\N\O\P\Q\R\S\T\U\V\W\X\Y\Z
%%   Lower-case    \a\b\c\d\e\f\g\h\i\j\k\l\m\n\o\p\q\r\s\t\u\v\w\x\y\z
%%   Digits        \0\1\2\3\4\5\6\7\8\9
%%   Exclamation   \!     Double quote  \"     Hash (number) \#
%%   Dollar        \$     Percent       \%     Ampersand     \&
%%   Acute accent  \'     Left paren    \(     Right paren   \)
%%   Asterisk      \*     Plus          \+     Comma         \,
%%   Minus         \-     Point         \.     Solidus       \/
%%   Colon         \:     Semicolon     \;     Less than     \<
%%   Equals        \=     Greater than  \>     Question mark \?
%%   Commercial at \@     Left bracket  \[     Backslash     \\
%%   Right bracket \]     Circumflex    \^     Underscore    \_
%%   Grave accent  \`     Left brace    \{     Vertical bar  \|
%%   Right brace   \}     Tilde         \~}
%%
\IfFileExists{fixltx2e.sty}
  {\RequirePackage{fixltx2e}}
  {\RequirePackage{fix2col}[1998/08/17]}
\@ifpackageloaded{fixltx2e}{%
\@ifpackagelater{fixltx2e}{1999/12/02}{}{%
\def\addpenalty#1{%
  \ifvmode
    \if@minipage
    \else
      \if@nobreak
      \else
        \ifdim\lastskip=\z@
          \penalty#1\relax
        \else
          \@tempskipb\lastskip
          \advance \@tempskipb
               \ifdim\prevdepth>\maxdepth\maxdepth\else
                 \ifdim \prevdepth = -\@m\p@ \z@ \else \prevdepth \fi
               \fi
          \vskip -\@tempskipb
          \penalty#1%
          \vskip\@tempskipb
        \fi
      \fi
    \fi
  \else
    \@noitemerr
  \fi}
\def \@doclearpage {%
     \ifvoid\footins
       \setbox\@tempboxa\vsplit\@cclv to\z@ \unvbox\@tempboxa
       \setbox\@tempboxa\box\@cclv
       \xdef\@deferlist{\@toplist\@botlist\@deferlist}%
       \global \let \@toplist \@empty
       \global \let \@botlist \@empty
       \global \@colroom \@colht
       \ifx \@currlist\@empty
       \else
          \@latexerr{Float(s) lost}\@ehb
          \global \let \@currlist \@empty
       \fi
       \@makefcolumn\@deferlist
       \@whilesw\if@fcolmade \fi{\@opcol\@makefcolumn\@deferlist}%
       \if@twocolumn
         \if@firstcolumn
           \xdef\@deferlist{\@dbltoplist\@deferlist}%
           \global \let \@dbltoplist \@empty
           \global \@colht \textheight
           \begingroup
              \@dblfloatplacement
              \@makefcolumn\@deferlist
              \@whilesw\if@fcolmade \fi{\@outputpage
                                        \@makefcolumn\@deferlist}%
           \endgroup
         \else
           \vbox{}\clearpage
         \fi
       \fi
       \ifx\@deferlist\@empty \else\clearpage \fi
     \else
       \setbox\@cclv\vbox{\box\@cclv\vfil}%
       \@makecol\@opcol
       \clearpage
     \fi
}
\def \@addtocurcol {%
   \@insertfalse
   \@setfloattypecounts
   \ifnum \@fpstype=8
   \else
     \ifnum \@fpstype=24
     \else
       \@flsettextmin
       \advance \@textmin \@textfloatsheight
       \@reqcolroom \@pageht
       \ifdim \@textmin>\@reqcolroom
         \@reqcolroom \@textmin
       \fi
       \advance \@reqcolroom \ht\@currbox
       \ifdim \@colroom>\@reqcolroom
         \@flsetnum \@colnum
         \ifnum \@colnum>\z@
           \@bitor\@currtype\@deferlist
          \@testwrongwidth\@currbox
           \if@test
           \else
             \@bitor\@currtype\@botlist
             \if@test
               \@addtobot
             \else
               \ifodd \count\@currbox
                 \advance \@reqcolroom \intextsep
                 \ifdim \@colroom>\@reqcolroom
                   \global \advance \@colnum \m@ne
                   \global \advance \@textfloatsheight \ht\@currbox
                   \global \advance \@textfloatsheight 2\intextsep
                   \@cons \@midlist \@currbox
                   \if@nobreak
                     \nobreak
                     \@nobreakfalse
                     \everypar{}%
                   \else
                     \addpenalty \interlinepenalty
                   \fi
                   \vskip \intextsep
                   \box\@currbox
                   \penalty\interlinepenalty
                   \vskip\intextsep
                   \ifnum\outputpenalty <-\@Mii \vskip -\parskip\fi
                   \outputpenalty \z@
                   \@inserttrue
                 \fi
               \fi
               \if@insert
               \else
                 \@addtotoporbot
               \fi
             \fi
           \fi
         \fi
       \fi
     \fi
   \fi
   \if@insert
   \else
     \@resethfps
     \@cons\@deferlist\@currbox
   \fi
}}}
{}
\RequirePackage{calc}
\RequirePackage[latin1]{inputenc}
\RequirePackage{ifthen}
\RequirePackage[final]{graphicx}
\newif\if@load@natbib \@load@natbibtrue
\IfFileExists{url.sty}
  {\RequirePackage{url}%
  }
  {\def\url##1{\texttt{##1}}%
   \ClassWarningNoLine{aipproc}
      {\noexpand\url command might fail with
        this LaTeX \MessageBreak installation since url.sty
        is missing}%
  }
\IfFileExists{textcase.sty}
  {\RequirePackage{textcase}%
  }
  {\global\let\MakeTextUppercase\MakeUppercase
   \ClassWarningNoLine{aipproc}
      {\noexpand\section commands should not contain math
        as this on LaTeX \MessageBreak installation the textcase
        package is missing}%
  }
\newcommand\AIP@optionnotsupported[1]
    {\ClassWarningNoLine{aipproc}%
                {Option~ `#1'~ not~ supported~ ---~ request~ ignored}}
\newcommand\AIP@error{\ClassError{aipproc}}
\newcommand\AIP@cmdnotsupported[1]
    {\def#1{\AIP@error{Command \noexpand#1not supported by
                       class}\@eha}}
\newcommand\AIP@natbibnotavailable[1]
    {\def#1{\AIP@error{Command \noexpand#1not supported if natbib
                       not installed}\@eha}}
\newcommand*\DesignerError[1]{%
  \AIP@error{#1}{Probably bug in class file.}}
\newcommand*\InformationError[1]{%
  \AIP@error{#1}%
    {Add the necessary information to the document.}}
\newcommand\MakeSpaceIgnore{%
    \catcode`\~=10\relax
    \catcode`\ = 9\relax
    \catcode`\^^M = 9\relax
}
\newcommand\MakeSpaceNormal{%
    \catcode`\~= 13\relax
    \catcode`\ = 10\relax
    \catcode`\^^M = 5\relax
}
\let\UnbreakableSpace~
\MakeSpaceIgnore
\DeclareOption{a5paper}       {\AIP@optionnotsupported\CurrentOption}
\DeclareOption{b5paper}       {\AIP@optionnotsupported\CurrentOption}
\DeclareOption{legalpaper}    {\AIP@optionnotsupported\CurrentOption}
\DeclareOption{executivepaper}{\AIP@optionnotsupported\CurrentOption}
\DeclareOption{landscape}     {\AIP@optionnotsupported\CurrentOption}
\DeclareOption{10pt}          {\AIP@optionnotsupported\CurrentOption}
\DeclareOption{11pt}          {\AIP@optionnotsupported\CurrentOption}
\DeclareOption{12pt}          {\AIP@optionnotsupported\CurrentOption}
\DeclareOption{titlepage}     {\AIP@optionnotsupported\CurrentOption}
\DeclareOption{notitlepage}   {\AIP@optionnotsupported\CurrentOption}
\DeclareOption{oneside}       {\AIP@optionnotsupported\CurrentOption}
\DeclareOption{twoside}       {\AIP@optionnotsupported\CurrentOption}
\DeclareOption{onecolumn}     {\AIP@optionnotsupported\CurrentOption}
\DeclareOption{twocolumn}     {\AIP@optionnotsupported\CurrentOption}
\DeclareOption{leqno}         {\AIP@optionnotsupported\CurrentOption}
\DeclareOption{fleqn}         {\AIP@optionnotsupported\CurrentOption}
\DeclareOption{openbib}       {\AIP@optionnotsupported\CurrentOption}
\DeclareOption{tnotealph}  {\def\AIP@tnote@representation{\@alph}}
\DeclareOption{tnotesymbol}{\def\AIP@tnote@representation{\@fnsymbol}}
\newboolean{@cmrfonts}
\DeclareOption{cmfonts}    {\setboolean{@cmrfonts}{true}
                            \def\AIP@mathfontsused{0}}
\DeclareOption{mathptm}    {\def\AIP@mathfontsused{1}}
\DeclareOption{mathtime}   {\def\AIP@mathfontsused{2}}
\DeclareOption{nomathfonts}{\def\AIP@mathfontsused{3}}
\DeclareOption{mathptmx}   {\def\AIP@mathfontsused{4}}
\DeclareOption{mtpro}      {\def\AIP@mathfontsused{5}}
\def\pageref{0}
\DeclareOption{varioref}      {\def\pageref{1}}
\DeclareOption{nonvarioref}   {\def\pageref{2}}
\DeclareOption{numcites}      {\def\AIPcitestyleselect{num}}
\DeclareOption{bibliocites}   {\def\AIPcitestyleselect{biblio}}
\DeclareOption{nonatbib}      {\dont@load@natbibfalse}
\DeclareOption{numberedheadings}
    {\AtEndOfClass{\setcounter{secnumdepth}{3}}}
\DeclareOption{unnumberedheadings}
    {\AtEndOfClass{\setcounter{secnumdepth}{-\maxdimen}}}
\DeclareOption{draft}{\PassOptionsToClass{\CurrentOption}{article}%
    \@drafttrue
    \AtEndOfPackage{
          \let\AIP@pagenumerror\@gobble
          \def\@oddfoot{\reset@font
            \AIPfoliofont
            \AIPfolioformat\@shorttitle\@date\thepage
            }}}
\newif\if@draft
\DeclareOption{final}{\PassOptionsToClass{\CurrentOption}{article}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ExecuteOptions{mathptmx,tnotesymbol,numcites,unnumberedheadings,letterpaper}
\ProcessOptions\relax
\MakeSpaceNormal
\LoadClass{article}
\MakeSpaceIgnore
\def\layoutstyle#1{%
    \expandafter\let\expandafter
       \AIP@layoutstylename
       \csname AIP@layout@style@#1 \endcsname
    \ifx\AIP@layoutstylename\relax
       \def\AIP@layoutstylename{#1}
    \fi
    \MakeSpaceIgnore
    \makeatletter
    \InputIfFileExists{aip-\AIP@layoutstylename.clo}
        {\let\AIP@check@layoutstyle\relax}
        {\AIP@error{The~ layout~ style~ `#1'~ is~ not~
                    known\MessageBreak  or~ its~
                    support~ file~ can~ not~ be~ found}
         {The~ \noexpand \layoutstyle command~ tried~ to~ load~ the~ file~
          aip-\AIP@layoutstylename.clo~ without~ success!\MessageBreak
          This~ might~ be~ due~ to~ misspelling~ the~ style~
          name.\MessageBreak
          Standard~ styles~ are~ `6x9',~ `8x11single',~
          `8x11double',~ and~ `arlo',~ but\MessageBreak there~
           might~ be~ others~ (see~ the~ class~
          documentation).\MessageBreak
          It~ could~ also~ be~ due~ to~ an~ incomplete~ installation~
          of~ the~ class.
         }
        }
    \MakeSpaceNormal
    \makeatother
    \ifdim\columnsep>\z@
       \@twocolumntrue
    \else
       \@twocolumnfalse
    \fi
}
\@onlypreamble\layoutstyle
\def\declare@layoutstyle#1#2{
  \@namedef{AIP@layout@style@#1}{#2}
}
\@onlypreamble\declare@layoutstyle
\declare@layoutstyle{6x9}{6s}
\declare@layoutstyle{8x11single}{8s}
\declare@layoutstyle{8x11double}{8d}
\def\AIP@check@layoutstyle{
  \AIP@error{No~ \noexpand\layoutstyle command~ seen}
    {The~ class~ requires~ a~ \noexpand\layoutstyle{<name>}~
     declaration~ in~ the~ preamble!\MessageBreak
     Standard~ styles~ are~ `6x9',~ `8x11single',~
    `8x11double',~ and~ `arlo',~ but\MessageBreak there~
     might~ be~ others~ (see~ the~ class~
     documentation).\MessageBreak
     To~ be~ able~ to~ proceed~ the~ 6x9~ style~ is~ assumed.
    }
    \layoutstyle{6x9}
  \@colht\textheight
  \@colroom\textheight \vsize\textheight
  \columnwidth\textwidth
  \@clubpenalty\clubpenalty
  \if@twocolumn
    \advance\columnwidth -\columnsep
    \divide\columnwidth\tw@ \hsize\columnwidth \@firstcolumntrue
  \fi
  \hsize\columnwidth \linewidth\hsize
}
\AtBeginDocument{\AIP@check@layoutstyle}
\newcommand*\SetInternalRegister[2]{#1=#2\relax}
\let\SetInternalCounter\count@assign
\newcommand*\DeclareParagraphLayout[9]{%
    \@namedef{#1Para}{
  \fontsize{#2}{#3}\selectfont
          #9
  \setlength\parindent  {#4}
  \setlength\leftskip   {#5}
  \setlength\rightskip  {#6}
  \@rightskip\rightskip
  \setlength\parfillskip{#7}
  \setlength\parskip    {#8}
}
}
\@onlypreamble\DeclareParagraphLayout
\newcommand*\UseParagraphLayout[1]{
    \@ifundefined{#1Para}
       {\DesignerError{Paragraph~ layout~ '#1'~ undefined}}
       {\@nameuse{#1Para}}
}
\newcommand*\DeclareParagraphLayoutAlias[2]{%
      \@ifundefined{#2Para}
           {\DesignerError{Paragraph~ layout~ '#2'~ undefined}}
           {\expandafter\let
              \csname#1Para\expandafter\endcsname
              \csname#2Para\endcsname
           }
}
\@onlypreamble\DeclareParagraphLayoutAlias
\newcommand*\UseBBskip[1]
  {\ifvmode
    \setlength\@tempskipa{#1 - \parskip - \baselineskip}
    \vskip\@tempskipa
   \else
    \DesignerError{\protect\UseBBskip\space outside~ vmode}
   \fi
  }
\newcommand*\DeclarePagestyle[5]
  {
   \@namedef{ps@#1}
     {
      \def\@oddhead {#2}
      \def\@oddfoot {#3}
      \def\@evenhead{#4}
      \def\@evenfoot{#5}
     }
   }
\newdimen\bodytextsize
\newdimen\bodytextbaselineskip
\newdimen\bodytextenspace
\newdimen\bodytextparindent
\pagestyle{empty}
\AIP@cmdnotsupported\pagestyle
\newcommand\AIP@pagenumerror[1]{%
  \AIP@error{Command~ \string#1~ can't~ be~ used~
       in~ production}%
      {This~ command~ will~ produce~ page~ numbers~ which~ will~
       be~ incorrect~ in~ the\MessageBreak final~ production.
       It~ should~ therefore~ only~ be~ used~ while~ producing~
       drafts.}}
\let\@@tableofcontents\tableofcontents
\let\@@listoffigures\listoffigures
\let\@@listoftables\listoftables
\renewcommand\tableofcontents{%
   \AIP@pagenumerror\tableofcontents\@@tableofcontents}
\renewcommand\listoffigures{%
   \AIP@pagenumerror\listoffigures\@@listoffigures}
\renewcommand\listoftables{%
   \AIP@pagenumerror\listoftables\@@listoftables}
\RequirePackage{aipxfm}
\MakeSpaceIgnore
\def\AIP@startsection#1#2#3#4#5{
    \@tempskipa#2\relax
    \advance\@tempskipa-\parskip
    \ifdim\@tempskipa<\z@
      \DesignerError{#2~ -~ \protect\parskip needs~ to~ be~
                     non-negative}
    \fi
    \ifthenelse{\equal#1{true}}
      \relax
      {\@tempskipa-\@tempskipa}
    \edef\AIP@preskip{\the\@tempskipa}
    \@tempskipa#4\relax
    \advance\@tempskipa-\parskip
    \ifdim\@tempskipa<\z@
      \DesignerError{#2~ -~ \protect\parskip needs~ to~ be~
                     non-negative}
    \fi
    \ifthenelse{\equal#3{true}}
      {\@tempskipa-\@tempskipa}
      \relax
    \edef\AIP@postskip{\the\@tempskipa}
    \@secpenalty#5\relax
    \@startsection
}
\renewcommand\section
   {\AIP@startsection
      \AIPsectionafterindent\AIPsectionpreskip
      \AIPsectionrunin\AIPsectionpostskip
      \AIPsectionpenalty
       {section}{1}{\AIPsectionindent}%
                   {\AIP@preskip}%
                   {\AIP@postskip}%
                   {\AIPsectionfont\AIPsectionformat}}
\renewcommand\subsection
   {\AIP@startsection
      \AIPsubsectionafterindent\AIPsubsectionpreskip
      \AIPsubsectionrunin\AIPsubsectionpostskip
      \AIPsubsectionpenalty
    {subsection}{2}{\AIPsubsectionindent}%
                   {\AIP@preskip}%
                   {\AIP@postskip}%
                   {\AIPsubsectionfont\AIPsubsectionformat}}
\renewcommand\subsubsection
   {\AIP@startsection
      \AIPsubsubsectionafterindent\AIPsubsubsectionpreskip
      \AIPsubsubsectionrunin\AIPsubsubsectionpostskip
      \AIPsubsubsectionpenalty
    {subsubsection}{3}{\AIPsubsubsectionindent}%
                   {\AIP@preskip}%
                   {\AIP@postskip}%
                   {\AIPsubsubsectionfont\AIPsubsubsectionformat}}
\renewcommand\paragraph
   {\AIP@startsection
      \AIPparagraphafterindent\AIPparagraphpreskip
      \AIPparagraphrunin\AIPparagraphpostskip
      \AIPparagraphpenalty
     {paragraph}{4}{\AIPparagraphindent}%
                   {\AIP@preskip}%
                   {\AIP@postskip}%
                   {\AIPparagraphfont\AIPparagraphformat}}
\renewcommand\subparagraph
   {\AIP@startsection
      \AIPsubparagraphafterindent\AIPsubparagraphpreskip
      \AIPsubparagraphrunin\AIPsubparagraphpostskip
      \AIPsubparagraphpenalty
  {subparagraph}{5}{\AIPsubparagraphindent}%
                   {\AIP@preskip}%
                   {\AIP@postskip}%
                   {\AIPsubparagraphfont\AIPsubparagraphformat}}
\newcommand\UseNoHyphens{\hyphenpenalty\@M\exhyphenpenalty\@M}
\ifcase \AIP@mathfontsused
                                 % 0 use cm for everything
\or
\MakeSpaceNormal
  \RequirePackage{mathptm}       % 1
\MakeSpaceIgnore
\or
\MakeSpaceNormal
  \RequirePackage{mathtime}      % 2
\MakeSpaceIgnore
\or
                                 % 3 use cm for math
\or
\MakeSpaceNormal
  \RequirePackage{mathptmx}      % 4
\MakeSpaceIgnore
\or
\MakeSpaceNormal
  \RequirePackage{mtpro}         % 5
\MakeSpaceIgnore
\fi
\ifnum \AIP@mathfontsused > 0
  \RequirePackage{times}
  \normalfont
  \RequirePackage[T1]{fontenc}
  \RequirePackage{textcomp}
\fi
\AtBeginDocument{\UseParagraphLayout{AIPbodytext}}
\renewcommand\footnoterule{
  \setlength\skip@{\AIPfootnoteruleheight+\AIPfootnoterulepostskip}
  \vskip-\skip@
  \moveright \AIPfootnoteruleindent\vbox{%
    \hrule \@width \AIPfootnoterulewidth
           \@height \AIPfootnoteruleheight}%
  \vskip \AIPfootnoterulepostskip \relax}
\AtBeginDocument{
  \setlength{\skip\footins}{\AIPfootnoterulepreskip
                            +\AIPfootnoterulepostskip}}
\renewcommand\@makefntext[1]{
    \UseParagraphLayout{AIPfootnote}
    \noindent
    \hbox{\AIPfootnotetextmarkerformat
             {\AIPfootnotetextmarkerfont\@thefnmark}}%
    \ignorespaces
    #1}
\def\@makefnmark{\hbox{%
  \AIPfootnotemarkerformat{\AIPfootnotemarkerfont\@thefnmark}}}
\def \@makecol {%
   \setbox\@outputbox \box\@cclv
   \@combinefloats
   \ifvoid\footins
   \else
     \setbox\@outputbox \vbox {%
       \boxmaxdepth \@maxdepth
       \unvbox \@outputbox
       \vskip \skip\footins
       \color@begingroup
         \normalcolor
         \footnoterule
         \unvbox \footins
       \color@endgroup
       }%
   \fi
   \xdef\@freelist{\@freelist\@midlist}%
   \global \let \@midlist \@empty
   \ifvbox\@kludgeins
     \@makespecialcolbox
   \else
     \setbox\@outputbox \vbox to\@colht {%
       \@texttop
       \dimen@ \dp\@outputbox
       \unvbox \@outputbox
       \vskip -\dimen@
       \@textbottom
       }%
   \fi
   \global \maxdepth \@maxdepth
}
\def\@fnsymbol#1{\ensuremath{\ifcase#1\or *\or \dagger\or **\or
   \ddagger\or \mathsection\or \mathparagraph\or \|\or \dagger\dagger
   \or \ddagger\ddagger \or\mathsection\mathsection
   \or \mathparagraph\mathparagraph \or *{*}*\or
   \dagger{\dagger}\dagger \or\ddagger{\ddagger}\ddagger\or
   \mathsection{\mathsection}\mathsection
   \or \mathparagraph{\mathparagraph}\mathparagraph \else\@ctrerr\fi}}
\def\@alph#1{\ifcase#1\or a\or b\or c\or d\or e\or f\or g\or h\or i\or
  j\or k\or l\or m\or n\or o\or p\or q\or r\or s\or t\or u\or v\or
  w\or x\or y\or z\or aa\or bb\or cc\or dd\or ee\or ff\or gg\or hh\or
  ii\or jj\or kk\or ll\or mm\or nn\or oo\or pp\or qq\or rr\or ss\or
  tt\or uu\or vv\or ww\or xx\or yy\or zz\else\@ctrerr\fi}
\AtBeginDocument{%
  \ifx\tagform@\@undefined
    \def\eqref#1{\mbox{\AIPeqreffont\AIPeqrefformat{\ref{#1}}}}%
  \else
    \def\tagform@#1{\mbox{\AIPeqreffont
      \AIPeqrefformat{\ignorespaces
                      #1\unskip\@@italiccorr}}}%
  \fi
  \def\@eqnnum{{\AIPeqfont\AIPeqformat\theequation}}
}
\ifnum\pageref>0
 \MakeSpaceNormal
  \RequirePackage{varioref}
 \MakeSpaceIgnore
 \renewcommand\reftextfaceafter {on~ the~ next~ page}
 \renewcommand\reftextfacebefore{on~ the~ \reftextvario{previous}
                                                     {preceding}~ page}
 \renewcommand\reftextafter     {on~ the~ \reftextvario{following}
                                                     {next}~ page}
 \renewcommand\reftextbefore    {on~ the~ \reftextvario{preceding~ page}
                                                     {page~ before}}
 \renewcommand\reftextcurrent   {on~ \reftextvario{this}%
                                                 {the~ current}~ page}
 \renewcommand\reftextfaraway[1]{%
   \is@pos@number\@tempb
    {\ifnum\@tempb<0\@tempa\relax
       \reftextearlier
     \else
       \reftextlater
     \fi}%
   {\@setref\relax\relax{#1}}}
 \newcommand\reftextearlier{\reftextvario{on~ an~ earlier~ page}
                                         {earlier~ on}}
 \newcommand\reftextlater  {\reftextvario{later~ on}{further~ down}}
 \ifnum\pageref=2
   \def\reftextvario#1#2{#1}
 \fi
 \let\pageref\vpageref
\else
  \renewcommand\pageref[1]
    {\AIP@error{Page~ references~ not~ supported}
      {This~ class~ does~ not~ support~ references~ to~ page~
       numbers~ unless~ the~ varioref~ or~ the~ nonvarioref~ option~
       is~ used,~ since~ it~ doesn't~ print~ page~ numbers.}}
\fi
\newcommand\AIP@maketablecaption[2]{%
  \UseParagraphLayout{AIPtable-singlelinecaption}
  \settowidth\@tempdima{%
      \noindent
      {\AIPtablecaptionheadfont\AIPtablecaptionheadformat{#1}}
      \AIPtablecaptiontextfont\ignorespaces#2}
  \ifdim\@tempdima>\hsize
     \UseParagraphLayout{AIPtable-multilinecaption}
  \fi
  \noindent
  {\AIPtablecaptionheadfont\AIPtablecaptionheadformat{#1}}
  \AIPtablecaptiontextfont\ignorespaces#2\par
  \vskip\AIPtablecaptionskip}
\newskip\AIPtablecaptionskip
\newcommand\AIP@makefigurecaption[2]{%
  \UseParagraphLayout{AIPfigure-singlelinecaption}
  \UseBBskip\AIPfigurecaptionBBskip
  \settowidth\@tempdima{%
      \noindent
      {\AIPfigurecaptionheadfont\AIPfigurecaptionheadformat{#1}}
      \AIPfigurecaptiontextfont\ignorespaces#2}
  \ifdim\@tempdima>\hsize
     \UseParagraphLayout{AIPfigure-multilinecaption}
  \fi
  \noindent
  {\AIPfigurecaptionheadfont\AIPfigurecaptionheadformat{#1}}
  \AIPfigurecaptiontextfont\ignorespaces#2\par
}
\newskip\AIPfigurecaptionBBskip
\newcommand\AIP@sourceerror{\AIP@error
  {\noexpand\source is only supported with `table' or `figure'
   environment}\@ehd}
\let\source\AIP@sourceerror
\newcommand\AIP@fsource@setup{%
    \def\source##1{\gdef\AIP@typeset@source
      {\addvspace\AIPfiguresourceskip
       \rightline{\AIPfiguresourceheadfont \AIPfiguresourceheadtext
                  \AIPfiguresourcetextfont ##1}
      }}
    \global\let\AIP@typeset@source\@empty}
\newcommand\AIP@tsource@setup{%
    \def\source##1{\gdef\AIP@typeset@source
      {\addvspace\AIPtablesourceskip
       \rightline{\AIPtablesourceheadfont \AIPtablesourceheadtext
                  \AIPtablesourcetextfont ##1}
      }}
    \global\let\AIP@typeset@source\@empty}
\newcommand\AIP@tablenoteerror{\AIP@error
  {\noexpand\tablenote is only supported inside `table'
   environment\MessageBreak and not allowed inside
   the \noexpand\caption or \noexpand\source command}\@ehd}
\let\tablenote\AIP@tablenoteerror
\newcommand\AIP@tablenote[2]{%
       \leavevmode
       \stepcounter\@mpfn
       \protected@xdef\@thefnmark{\thempfn}%
       #1\@footnotemark
       \protected@xdef\AIP@tnote@process
            {\AIP@tnote@process
             \protect\footnotetext
               [\the\c@mpfootnote]
               {\protect\UseParagraphLayout{AIPtablenote}#2}}%
}
\newcommand\AIP@tnote@setup{%
    \def\@mpfn{mpfootnote}%
    \def\thempfn{\thempfootnote}%
    \def\thempfootnote{\AIP@tnote@representation\c@mpfootnote}%
    \global\c@mpfootnote\z@
    \def\tablenote{\@ifstar{\AIP@tablenote\relax}
                           {\AIP@tablenote\rlap}}
    \gdef\AIP@tnote@process{}%
    \setlength{\skip\@mpfootins}{\AIPtablenoteskip}
    \let\footnoterule\relax
    \let\@footnotetext\@mpfootnotetext
}
\newskip\AIPtablenoteskip
\newcommand\AIP@tablehead[4]{\multicolumn{#1}{#2}%
   {\AIPtableheadfont\begin{tabular}[#3]{@{}#2@{}}%
    \vrule \@height \bodytextsize\@width \z@\relax
    \ignorespaces#4\unskip
    \vrule \@depth .5\bodytextsize\@width \z@\end{tabular}}}
\def\hline{%
  \noalign{\ifnum0=`}\fi\vskip\AIPhlinesep
      \hrule \@height \arrayrulewidth\vskip3\AIPhlinesep
      \futurelet \reserved@a\@xhline}
\newdimen\AIPhlinesep
\newenvironment{ltxtable}[1][tbp]
               {\@float{table}[#1]
                \let\tablehead\AIP@tablehead
                \let\@makecaption\AIP@maketablecaption
                \AIPtablefont}
               {\end@float}
\newenvironment{ltxtable*}[1][tbp]
               {\@dblfloat{table}[#1]
                \let\tablehead\AIP@tablehead
                \let\@makecaption\AIP@maketablecaption
                \AIPtablefont}
               {\end@dblfloat}
\renewenvironment{table*}[1][tbp]
   {\AIP@error{Environment `table*' not supported\MessageBreak
                         --- environment `table' used instead}%
    {The class automatically determines the position of the float
     according\MessageBreak
     to its size.}%
    \begin{table}}
   {\end{table}}
\renewenvironment{table}[1][tbp]
   {\def\AIP@floatspec{#1}%
    \let\tablehead\AIP@tablehead
    \let\@makecaption\AIP@maketablecaption
    \AIP@tsource@setup
    \AIP@tnote@setup
    \global \setbox\AIP@box
    \color@hbox
      \hbox \bgroup
      \@floatboxreset
         \def\caption##1{\gdef\AIP@save@caption{##1}\let\caption\AIP@caption@error}%
         \def\label##1{\gdef\AIP@save@label{##1}}%
         \global\let\AIP@save@caption\@undefined
         \global\let\AIP@save@label\@undefined
       \normalcolor
       \AIPtablefont
       \ignorespaces
   }
   {%
       \AIP@remove@any@previous@space
       \outer@nobreak
      \egroup
    \color@endbox
    \setlength\dimen@{\columnwidth+1pt}%
    \ifdim\wd\AIP@box >\dimen@
      \setlength\dimen@{\textwidth+1pt}%
      \ifdim\wd\AIP@box >\dimen@
        \def\@captype{table}%
        \sbox\@tempboxa{\AIP@make@table@body}%
        \setlength\dimen@{\ht\@tempboxa+\dp\@tempboxa}%
        \ifdim\dimen@ <\columnwidth
          \def\@tempa{\@float{table}}%
          \expandafter\@tempa\expandafter[\AIP@floatspec]%
            \centerline{\rotatebox{90}{\box\@tempboxa}}%
          \end@float
        \else
           \def\@tempa{\@dblfloat{table}}%
           \expandafter\@tempa\expandafter[\AIP@floatspec]%
           \setbox\@tempboxa\hbox{\rotatebox{90}{\box\@tempboxa}}
           \dimen@\wd\@tempboxa
           \advance\dimen@ -5\p@   % grace
           \ifdim \dimen@ >\textwidth
             \AIP@error{Table~ too~ wide~ (\the\wd\@tempboxa\space
                        >~\the\textwidth)}
                {Table~ doesn't~ fit~ even~ after~ turning~ it~
                 by~ 90~ degrees.~ You~ probably\MessageBreak
                 have~ to~ change~ it~ somewhat.}
           \fi
           \centerline{\unhbox \@tempboxa}
          \end@dblfloat
        \fi
      \else
        \def\@tempa{\@dblfloat{table}}%
        \expandafter\@tempa\expandafter[\AIP@floatspec]%
          \AIP@make@table@body
        \end@dblfloat
      \fi
    \else
      \def\@tempa{\@float{table}}%
      \expandafter\@tempa\expandafter[\AIP@floatspec]%
        \AIP@make@table@body
      \end@float
    \fi
}
\newcommand\AIP@caption@error{\AIP@error{Only~ one~
           \noexpand\caption command~ per~ float~ supported}
    {If~ you~ need~ more~ than~ one~ \noexpand\caption~ command~ try~ the~
     ltxfigure~ or~ ltxtable\MessageBreak
     environment~ as~ explained~ in~ the~ aipguide.}}
\newcommand\AIP@make@table@body{%
      \centering
      \@tempdima\wd\AIP@box
      \ifdim\@tempdima<\AIPtablecaptionminwidth
        \@tempdima\AIPtablecaptionminwidth
      \fi
      \begin{minipage}\@tempdima
        \ifx\AIP@save@caption\@undefined\else
          \let\tablenote\AIP@tablenoteerror
          \caption{\AIP@save@caption
                   \ifx\AIP@save@label\@undefined\else
                     \label\AIP@save@label
                   \fi}%
        \fi
        \par
        \offinterlineskip                % or we get \lineskip
        \vbox{\hsize\wd\AIP@box
                          \box\AIP@box
                          \AIP@typeset@source}%
        \AIP@tnote@process
     \end{minipage}%
}
\newdimen\AIPtablecaptionminwidth
\newcommand\AIP@remove@any@previous@space
  {\unskip\loop\unskip\ifdim\lastskip>\z@\repeat}
\newbox\AIP@box
\newenvironment{ltxfigure}[1][tbp]
               {\@float{figure}[#1]
                \let\@makecaption\AIP@makefigurecaption}
               {\end@float}
\newenvironment{ltxfigure*}[1][tbp]
               {\@dblfloat{figure}[#1]
                \let\@makecaption\AIP@makefigurecaption}
               {\end@dblfloat}
\renewenvironment{figure}[1][tbp]
   {\def\AIP@floatspec{#1}%
    \AIP@fsource@setup
    \global \setbox\AIP@box
    \color@hbox
      \hbox \bgroup
      \@floatboxreset
         \def\caption##1{\let\caption\AIP@caption@error\gdef\AIP@save@caption{##1}}%
         \def\label##1{\gdef\AIP@save@label{##1}}%
         \global\let\AIP@save@caption\@undefined
         \global\let\AIP@save@label\@undefined
       \normalcolor
       \normalfont
       \normalsize
       \ignorespaces
   }
   {%
       \AIP@remove@any@previous@space
       \outer@nobreak
      \egroup
    \color@endbox
    \def\@tempa{\@dblfloat{figure}}%
    \setlength\dimen@{\columnwidth+1pt}%
    \ifdim\wd\AIP@box >\dimen@
      \expandafter\@tempa\expandafter[\AIP@floatspec]%
        \AIP@make@figure@body
      \end@dblfloat
    \else
      \def\@tempa{\@float{figure}}%
      \expandafter\@tempa\expandafter[\AIP@floatspec]%
        \AIP@make@figure@body
      \end@float
    \fi
}
\renewenvironment{figure*}{\figure}{\endfigure}
\newcommand\AIP@make@figure@body{%
      \centering
      \setlength\@tempdima{\wd\AIP@box-1pt}%
      \ifdim\@tempdima>\columnwidth
         \@tempdima\textwidth
      \else
         \@tempdima\columnwidth
      \fi
      \begin{minipage}\@tempdima
        \centerline{\vbox{\hsize\wd\AIP@box
                          \box\AIP@box
                          \AIP@typeset@source}}%
        \ifx\AIP@save@caption\@undefined\else
          \let\@makecaption\AIP@makefigurecaption
          \caption{\AIP@save@caption
                   \ifx\AIP@save@label\@undefined\else
                     \label\AIP@save@label
                   \fi}%
        \fi
        \par
     \end{minipage}}
\renewcommand\fnum@figure{\thefigure}
\renewcommand\fnum@table{\thetable}
\newcommand\spaceforfigure[2]{\parbox{#1}{\mbox{}\vspace*{#2}}}
\AtBeginDocument{%
\newcommand\@@longtable{}%
\let\@@longtable\longtable
\def\longtable{%
  \begingroup
    \LTcapwidth\z@
    \advance\c@LT@tables\@ne   % local as stepcounter comes later
    \let\LT@entry\AIP@get@longtable@width
    \csname LT@\romannumeral\c@LT@tables\endcsname
    \ifdim \LTcapwidth=\z@ \global \LTcapwidth2in
    \else \global\LTcapwidth\LTcapwidth
    \fi
  \endgroup
  \AIPtablefont
  \let\tablehead\AIP@tablehead
  \@@longtable
}%
\def\LT@makecaption#1#2#3{%
  \LT@mcol\LT@cols {@{}l@{}}{\rlap{\parbox[t]\LTcapwidth{%
  \UseParagraphLayout{AIPtable-multilinecaption}
  \noindent
  {\AIPtablecaptionheadfont\AIPtablecaptionheadformat{#1#2}}
  \AIPtablecaptiontextfont\ignorespaces#3\endgraf
  \vspace*\AIPtablecaptionskip
  }}}}%
\def\LT@hline{%
  \noalign{\ifnum0=`}\fi
    \penalty\@M\vskip\AIPhlinesep
    \futurelet\@let@token\LT@@hline}
\def\LT@@hline{%
  \ifx\@let@token\hline
    \global\let\@gtempa\@gobble
    \gdef\LT@sep{\penalty-\@medpenalty\vskip\doublerulesep}%
  \else
    \global\let\@gtempa\@empty
    \gdef\LT@sep{\penalty-\@lowpenalty\vskip-\arrayrulewidth}%
  \fi
  \ifnum0=`{\fi}%
  \multispan\LT@cols
     \unskip\leaders\hrule\@height\arrayrulewidth\hfill\cr
  \noalign{\LT@sep}%
  \multispan\LT@cols
     \unskip\leaders\hrule\@height\arrayrulewidth\hfill\cr
  \noalign{\penalty\@M\vskip3\AIPhlinesep}%
  \@gtempa}
}
\newcommand\AIP@get@longtable@width[2]{\advance\LTcapwidth#2\relax }
\newenvironment{theacknowledgments}
     {\AIPacknowledgmentsheadtype\AIPacknowledgmentsheadtext
      \UseParagraphLayout{AIPacknowledgments}}
     {\par}
\renewenvironment{theindex}
               {
                \if@twocolumn
                  \@restonecolfalse
                  \AIPindexheadtype\indexname
                \else
                  \columnseprule \z@
                  \columnsep 35\p@
                  \@restonecoltrue
                  \twocolumn[\AIPindexheadtype\indexname]
                \fi
                \parindent\z@
                \parskip\z@ \@plus .3\p@\relax
                \let\item\@idxitem}
               {\if@restonecol\onecolumn\fi}
\IfFileExists{natbib.sty}
  {
   \if@load@natbib
     \AtBeginDocument{
        \citestyle
           {\csname AIP \AIPcitestyleselect citestyle\endcsname}
     }
    \MakeSpaceNormal
    \RequirePackage{natbib}
    \MakeSpaceIgnore
   \fi
   }{}
\ifx\citet\@undefined
   \def\citet{\AIP@natbibnotavailable\citet}
   \def\citep{\AIP@natbibnotavailable\citep}
   \def\citealt{\AIP@natbibnotavailable\citealt}
   \def\citealp{\AIP@natbibnotavailable\citealp}
   \def\citetext{\AIP@natbibnotavailable\citetext}
   \def\citeauthor{\AIP@natbibnotavailable\citeauthor}
   \def\citeyear{\AIP@natbibnotavailable\citeyear}
   \def\citeyearpar{\AIP@natbibnotavailable\citeyearpar}
   \def\Citet{\AIP@natbibnotavailable\Citet}
   \def\Citep{\AIP@natbibnotavailable\Citep}
   \def\Citealt{\AIP@natbibnotavailable\Citealt}
   \def\Citealp{\AIP@natbibnotavailable\Citealp}
   \def\Citetext{\AIP@natbibnotavailable\Citetext}
   \def\Citeauthor{\AIP@natbibnotavailable\Citeauthor}
   \def\Citeyear{\AIP@natbibnotavailable\Citeyear}
   \def\Citeyearpar{\AIP@natbibnotavailable\Citeyearpar}
   \renewenvironment{thebibliography}[1]
     {\AIPbibliographyheadtype\refname
      \list{\AIPbibliographymarkerformat{\@arabic\c@enumiv}}%
           {\settowidth\labelwidth{\AIPbibliographymarkerformat{#1}}%
            \UseParagraphLayout{AIPbibliography}
            \leftmargin\labelwidth
            \advance\leftmargin\labelsep
            \setlength\itemsep\AIPbibliographyitemsep
            \@openbib@code
            \usecounter{enumiv}%
            \let\p@enumiv\@empty
            \renewcommand\theenumiv{\@arabic\c@enumiv}}%
      \sfcode`\.\@m}
     {\def\@noitemerr
       {\@latex@warning{Empty `thebibliography' environment}}%
      \endlist}
  \renewcommand*\@cite[2]{{\AIPcitefont
     \AIPciteformat{#1\if@tempswa , #2\fi}}}
  \AtBeginDocument{
        \ifthenelse{\equal\AIPcitestyleselect{num}}
           {}
           {\AIP@error{Author/year~ citation~ style~ impossible}
              {Without~ the~ natbib~ system~ only~ numerical~ citations~ are~
               possible.~ But~ you~ (or~ the~ journal~ \string\layoutstyle)~
               requested~ a~ diffferent~ citation~ style.}
           }
    }
\else
   \renewcommand\bibsection{\AIPbibliographyheadtype\refname}
   \renewcommand\NAT@bibsetnum[1]{
      \ifdim\AIPbibliographylabelwidth=\maxdimen
\settowidth\labelwidth{\@biblabel{#1}}
        \setlength\leftmargin\labelwidth
      \else
        \setlength\labelwidth\AIPbibliographylabelwidth
        \setlength\leftmargin
          {\AIPbibliographyleftmargin+\AIPbibliographyleftmarginextra}
        \setlength\itemindent{-\AIPbibliographyleftmarginextra}
      \fi
      \addtolength\leftmargin\AIPbibliographylabelsep
      \setlength\labelsep\AIPbibliographylabelsep
      \setlength\itemsep\AIPbibliographyitemsep
      \UseParagraphLayout{AIPbibliography}
      \setlength\parsep{\parskip}
   }
  \renewcommand\NAT@bibsetup[1]{
       \setlength\leftmargin
          {\AIPbibliographyleftmargin+\AIPbibliographyleftmarginextra}
       \setlength\itemindent{-\AIPbibliographyleftmarginextra}
       \setlength\itemsep\AIPbibliographyitemsep
       \UseParagraphLayout{AIPbibliography}
       \setlength\parsep{\parskip}
      }
  \newcommand\bibstyle@arlonum{\bibpunct{}{}{,}{s}{}{\textsuperscript{,}}%
     \gdef\NAT@biblabelnum##1{\textsuperscript{##1}}
     \gdef\thefootnote{\alph{footnote}}
  }
  \newcommand\bibstyle@aipproc{\bibpunct{[}{]}{,}{n}{}{,}
     \gdef\NAT@biblabelnum##1{##1.\hfill}}
\fi
\MakeSpaceNormal
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\endinput
%%
%% End of file `aipproc.cls'.
