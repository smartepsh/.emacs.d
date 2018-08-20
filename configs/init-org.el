(use-package org
  :ensure org-plus-contrib
  :pin org-cn
  :defer t
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

(provide 'init-org)
