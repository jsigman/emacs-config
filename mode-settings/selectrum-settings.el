(require 'projectile-settings)
(setq projectile-completion-system 'default)

;; (setq projectile-completion-system 'default)
(straight-use-package 'selectrum)
(require 'selectrum)
(selectrum-mode t)

(straight-use-package 'selectrum-prescient)
(require 'selectrum-prescient)
(selectrum-prescient-mode t)
(prescient-persist-mode t)


(setq enable-recursive-minibuffers t)

(straight-use-package 'orderless)
(require 'orderless)
(setq completion-styles '(orderless))
(setq orderless-component-separator "[ &]")

;; Persist history over Emacs restarts
(savehist-mode)

;; Optional performance optimization
;; by highlighting only the visible candidates.
(setq orderless-skip-highlighting (lambda () selectrum-is-active))
(setq selectrum-highlight-candidates-function
      #'orderless-highlight-matches)

;; (setq counsel-find-file-ignore-regexp "^\\.?#\\|^\\.\\(DS_Store\\|localized\\|AppleDouble\\)$\\|^\\.\\.$")
;; (global-set-key (kbd "C-x C-f") 'counsel-find-file) ;; gives C-x C-f counsel features
(provide 'selectrum-settings)
