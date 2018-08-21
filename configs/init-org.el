(use-package org
  :ensure org-plus-contrib
  :pin org-cn
  :defer t
  :general
  (common-leader
    "on" 'org-noter)
  )

(use-package org-mac-link
  :ensure org-plus-contrib
  :commands (org-mac-skim-insert-page
	     org-mac-chrome-insert-frontmost-url
	     org-mac-finder-insert-selected)
  :general
  (local-leader
    :keymaps 'org-mode-map
    "cc" 'org-mac-chrome-insert-frontmost-url
    "ck" 'org-mac-skim-insert-page
    "cf" 'org-mac-finder-insert-selected))

(use-package ob-elixir
  :defer t
  :after org
  :init
  (add-to-list 'org-babel-load-languages '(elixir . t)))

(use-package nov
  :mode ("\\.epub\\'" . nov-mode)
  :general
  ;; disable special "h" key action
  (general-define-key
   :keymaps '(nov-mode-map)
   "h" nil) 
  (clear-spc :keymaps '(nov-mode-map))
  (local-leader
    :keymaps 'nov-mode-map
    "n" 'nov-next-document
    "p" 'nov-previous-document
    "m" 'nov-goto-toc
    "," 'nov-brower-url
    :keymaps 'org-noter-doc-mode-map
    "i" 'org-noter-insert-note
    "I" 'org-noter-insert-precise-note
    "sC" 'org-noter-sync-current-page-or-chapter
    "sc" 'org-noter-sync-current-note
    "sN" 'org-noter-sync-next-page-or-chapter
    "sn" 'org-noter-sync-next-note
    "sP" 'org-noter-sync-prev-page-or-chapter
    "sp" 'org-noter-sync-prev-note))

(use-package org-noter
  :commands org-noter
  :hook (org-mode . org-noter-notes-mode)
  :init
  (setq org-noter-always-create-frame nil)
  :general
  (local-leader
    :keymaps 'org-noter-notes-mode-map
    "sC" 'org-noter-sync-current-page-or-chapter
    "sc" 'org-noter-sync-current-note
    "sN" 'org-noter-sync-next-page-or-chapter
    "sn" 'org-noter-sync-next-note
    "sP" 'org-noter-sync-prev-page-or-chapter
    "sp" 'org-noter-sync-prev-note))

;; (use-package calibre-mode
;;   :quelpa (calibre-mode :fetcher github :repo "smartepsh/calibre-mode")
;;   :commands (calibre-list calibre-find)
;;   :init
;;   (setq sql-sqlite-program "/usr/bin/sqlite3"
;; 	calibre-root-dir (expand-file-name "~/onedrive/calibre")
;; 	calibre-db (concat calibre-root-dir "/metadata.db")))

(provide 'init-org)
