(straight-use-package 'ivy)
(straight-use-package 'counsel)
(straight-use-package 'swiper)
(require 'ivy)
(require 'swiper)
(require 'counsel)

;; Case insensitive searchs
(setq completion-ignore-case t)
(setq case-fold-search nil)

(setq
 counsel-find-file-ignore-regexp
 "^\\.?#\\|^\\.\\(DS_Store\\|localized\\|AppleDouble\\)$\\|^\\.\\.$")

(ivy-mode 1) ;; Turn on ivy by default
(setq ivy-use-virtual-buffers t) ;; no idea, but recommended by project maintainer
(setq enable-recursive-minibuffers t) ;; no idea, but recommended by project maintainer
(setq ivy-count-format "(%d/%d) ") ;; changes the format of the number of results


(global-set-key
 (kbd "C-s")
 'swiper) ;; replaces i-search with swiper
(global-set-key
 (kbd "M-x")
 'counsel-M-x) ;; Gives M-x command counsel features
(global-set-key
 (kbd "C-x C-f")
 'counsel-find-file) ;; gives C-x C-f counsel features

(global-set-key
 (kbd "C-x b")
 'counsel-switch-buffer) ;; gives C-x C-f counsel features
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> l") 'counsel-find-library)
(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
(global-set-key (kbd "<f2> u") 'counsel-unicode-char)
(global-set-key (kbd "C-c C-r") 'ivy-resume)

(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c j") 'counsel-git-grep)
(global-set-key
 (kbd "C-c k")
 'counsel-ag) ;; add counsel/ivy features to ag package
(global-set-key (kbd "C-x l") 'counsel-locate)
(global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
;;(define-key read-expression-map (kbd "C-r") 'counsel-expression-history)

(define-key ivy-minibuffer-map (kbd "C-j") 'ivy-immediate-done)
(define-key ivy-minibuffer-map (kbd "C-M-j") nil)

;;set action options during execution of counsel-find-file
;; replace "frame" with window to open in new window
(ivy-set-actions
 'counsel-find-file
 '(("j" find-file-other-frame "other frame")
   ("b" counsel-find-file-cd-bookmark-action "cd bookmark")
   ("x" counsel-find-file-extern "open externally")
   ("d" delete-file "delete")
   ("r" counsel-find-file-as-root "open as root")))

;; set actions when running C-x b
;; replace "frame" with window to open in new window
(ivy-set-actions
 'ivy-switch-buffer
 '(("j" switch-to-buffer-other-frame "other frame")
   ("k" kill-buffer "kill")
   ("r" ivy--rename-buffer-action "rename")))

;; Use fuzzy matching for ivy in modes that aren't swiper
(setq ivy-re-builders-alist
      '((swiper . ivy--regex-plus) (t . ivy--regex-fuzzy)))

;; Don't list .. and . in the ivy files search
(setq ivy-extra-directories ())

;; Persist histories across startups
(straight-use-package 'prescient)
(straight-use-package 'ivy-prescient)
(require 'prescient)
(require 'ivy-prescient)
;; Use prescient to store history of search results and preference based on these
(ivy-prescient-mode)

(prescient-persist-mode t)

;; ------------------IVY POSFRAME-----------------;;
;; (require 'ivy-posframe)
;; ;; Different command can use different display function.
;; ;; (setq ivy-posframe-height-alist '((swiper . 20)
;; ;;                                   (t      . 40)))

;; (setq ivy-posframe-display-functions-alist
;;       '((swiper          . nil)
;;         (complete-symbol . ivy-posframe-display-at-point)
;;         ;; (counsel-M-x     . ivy-posframe-display-at-point)
;;         ;; (counsel-find-file   . ivy-posframe-display-at-point)
;;         (t               . nil)))
;; (ivy-posframe-mode t)


(require 'projectile-settings)
(straight-use-package 'counsel-projectile)
(require 'counsel-projectile)
;; (add-hook 'projectile-mode-hook 'counsel-projectile-mode)
(counsel-projectile-mode)
(setq projectile-completion-system 'ivy)

(straight-use-package 'all-the-icons-ivy-rich)
(require 'all-the-icons-ivy-rich)
(straight-use-package 'ivy-rich)
(require 'ivy-rich)
(all-the-icons-ivy-rich-mode t)
(ivy-rich-mode t)

(provide 'ivy-counsel-swiper-settings)
