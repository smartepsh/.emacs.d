(use-package ivy
  :init
  (ivy-mode 1)
  :config
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)
  (global-set-key "\C-s" 'swiper))

(use-package swiper
  :after ivy)

(use-package counsel
  :after ivy)

(provide 'init-ivy)
