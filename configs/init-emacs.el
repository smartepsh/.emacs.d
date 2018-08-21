(use-package restart-emacs
  :bind ("H-r" . 'restart-emacs))

(defun open-config-file ()
  "open emacs configuration file"
  (interactive)
  (find-file (expand-file-name "~/.emacs.d/init.el")))

(common-leader
  "SPC" 'execute-extended-command
  "fed" 'open-config-file
  "ff" 'find-file)

;; (vimish-fold--vimish-overlay-p)

(provide 'init-emacs)
