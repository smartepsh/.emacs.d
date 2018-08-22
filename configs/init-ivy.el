(use-package ivy
  :defer t 
  :ensure-system-package (ag . the-silver-searcher)
  :init
  (add-hook 'after-init-hook #'ivy-mode)
  (setq ivy-use-virtual-buffers t
        enable-recursive-minibuffers t)
  :general
  (common-leader
    "/" 'counsel-ag))

(use-package swiper
  :commands (swiper)
  :general
  (general-define-key
   "C-s" 'swiper))

(use-package counsel
  :defer t
  :after ivy)

(provide 'init-ivy)
