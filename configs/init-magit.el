(use-package magit
  :commands (magit-status magit-blame)
  :general
  (clear-spc
   :keymaps
   '(magit-mode-map
     magit-status-mode-map
     magit-diff-mode-map
     magit-process-mode-map
     magit-blame-read-only-mode-map
     magit-log-mode-map
     git-rebase-mode-map))
  (common-leader
  "gs" 'magit-status
  "gb" 'magit-blame
  "gi" 'vc-msg-show)
  (general-nmap
    :keymaps 'magit-mode-map
    "s-<return>" 'magit-diff-visit-file-other-window)
  )

(use-package evil-magit
  :after (magit))


(use-package vc-msg
  :defer t
  :commands (vc-msg-show)
  :init
  (eval-after-load 'vc-msg-git
  '(progn
     ;; show code of commit
     (setq vc-msg-git-show-commit-function 'magit-show-commit)
     ;; open file of certain revision
     (push '("m"
             "[m]agit-find-file"
             (lambda ()
               (let* ((info vc-msg-previous-commit-info)
                      (git-dir (locate-dominating-file default-directory ".git")))
                 (magit-find-file (plist-get info :id )
                                  (concat git-dir (plist-get info :filename))))))
           vc-msg-git-extra))))

(provide 'init-magit)
