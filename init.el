(require 'org)
(org-babel-load-file
   (expand-file-name "init_el.org" user-emacs-directory))
(put 'narrow-to-region 'disabled nil)
