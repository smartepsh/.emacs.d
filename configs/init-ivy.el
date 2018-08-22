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
  :after ivy)

(use-package ivy-prescient
  :after ivy
  :config
  (setq ivy-prescient-retain-classic-highlighting t)
  (ivy-prescient-mode))


(provide 'init-ivy)
