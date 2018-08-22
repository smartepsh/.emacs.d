(use-package ivy
  :defer t 
  :init
  (add-hook 'after-init-hook #'ivy-mode)
  :config
  (setq ivy-use-virtual-buffers t
        enable-recursive-minibuffers t)
  :general
  (general-define-key
   "C-s" 'swiper)
  (common-leader
    "/" 'counsel-ag))

(use-package swiper
  :defer t
  :after ivy)

(use-package counsel
  :defer t
  :after ivy)

(provide 'init-ivy)
