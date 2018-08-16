(use-package restart-emacs
  :commands restart-emacs
  :init
  (global-set-key (kbd "H-r") 'restart-emacs))

(common-leader
  "SPC" 'execute-extended-command
  "ff" 'find-file)

;; (vimish-fold--vimish-overlay-p)

(provide 'init-emacs)
