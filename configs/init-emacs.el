(use-package restart-emacs
  :bind ("H-r" . 'restart-emacs))

(defun open-config-file ()
  "open emacs configuration file"
  (interactive)
  (find-file (expand-file-name "~/.emacs.d/init.el")))

(common-leader
  "SPC" 'execute-extended-command
  "fed" 'open-config-file
  "ff" 'counsel-find-file
  "fr" 'counsel-recentf
  "bb" 'counsel-ibuffer)

;; (vimish-fold--vimish-overlay-p)

(provide 'init-emacs)
