;;; Compiled snippets and support files for `org-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'org-mode
		     '(("isr" "#+name: ${}\n#+begin_src R :noweb yes\n  ${}\n#+end_src\n" "r-block" nil nil nil "/Users/smartepsh/.emacs.d/snippets/org-mode/r-block" nil nil)
		       ("<mermaid" "#+begin_mermaid\n$0\n#+end_mermaid" "mermaid" nil nil nil "/Users/smartepsh/.emacs.d/snippets/org-mode/mermaid" nil nil)
		       ("hugo" ":EXPORT_HUGO_SECTION: $1/$2\n:TITLE: $3\n:EXPORT_DATE: `(format-time-string \"%Y-%m-%d\")`\n:HUGO_AUTO_SET_LASTMOD: t\n:HUGO_TAGS: [$4]\n:HUGO_CATEGORIES: $5\n:EXPORT_FILE_NAME: $6\n:HUGO_DRAFT: false\n\n$0" "hugo" nil nil nil "/Users/smartepsh/.emacs.d/snippets/org-mode/hugo" nil nil)))


;;; Do not edit! File generated at Wed Dec  7 23:06:24 2022
