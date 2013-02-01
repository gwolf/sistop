(require 'org-publish)
(setq org-publish-project-alist
      '(("notas-html"
	 :base-directory "~/vcs/sistemas_operativos/notas/"
	 :base-extension "org"
	 :publishing-directory "~/vcs/sistemas_operativos/html"
	 :recursive t
	 :publishing-function org-publish-org-to-html
	 :headline-levels 4
	 :timestamp nil
	 :creator-info nil
	 :todo-keywords nil
	 :html-preamble ""
	 :html-postamble ""
	 :auto-preamble t
;; Estaría bonito tener un sitemap... Pero como el ordenamiento es un desmadre,
;; dejo a la presentación como index :-/
;
;	 :auto-sitemap t
;	 :sitemap-sort-files "alphabetically"
;	 :sitemap-ignore-case t
;	 :sitemap-filename "index.org"
;	 :sitemap-title "Mapa de sitio"
	 :auto-sitemap nil
	 )

	("notas-html-static"
	 :base-directory "~/vcs/sistemas_operativos/notas/"
	 :base-extension "css\\|js\\|png\\|jpg\\|svg"
	 :publishing-directory "~/vcs/sistemas_operativos/html"
	 :recursive t
	 :publishing-function org-publish-attachment
	 )

	("notas-pdf-static"
	 :base-directory "~/vcs/sistemas_operativos/notas/"
	 :base-extension "png\\|jpg\\|svg"
	 :publishing-directory "~/vcs/sistemas_operativos/pdf"
	 :recursive t
	 :publishing-function org-publish-attachment
	 )

	("notas-pdf"
	 :base-directory "~/vcs/sistemas_operativos/notas/"
	 :base-extension "org"
	 :publishing-directory "~/vcs/sistemas_operativos/pdf"
	 :recursive t
	 :publishing-function org-publish-org-to-pdf
	 :headline-levels 4
	 :auto-preamble t
	 )

	("html" :components ("notas-html" "notas-html-static"))
	("pdf" :components ("notas-pdf-static" "notas-pdf"))
	)
      )
