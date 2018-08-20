(use-package restart-emacs
  :bind ("H-r" . 'restart-emacs))

(common-leader
  "SPC" 'execute-extended-command
  "ff" 'find-file)

;; (vimish-fold--vimish-overlay-p)

(provide 'init-emacs)
