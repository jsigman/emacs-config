;----------------AUTO COMPLETE MODE--------------;
(straight-use-package 'company)
(require 'company)
(straight-use-package 'company-quickhelp)
(require 'company-quickhelp)

;; Sort by recent use
(company-quickhelp-mode)

;; Dont wait to show completions
(setq company-idle-delay 0)
(setq company-minimum-prefix-length 1)
(setq company-quickhelp-delay nil)

(global-company-mode t)

(straight-use-package
 '(company-async-files
   :type git
   :host github
   :repo "CeleritasCelery/company-async-files"))
(require 'company-async-files)
; I dont want these company backends
(setq company-backends (remove 'company-bbdb company-backends))
(setq company-backends (remove 'company-eclim company-backends))
(setq company-backends (remove 'company-semantic company-backends))
(setq company-backends (remove 'company-clang company-backends))
(setq company-backends (remove 'company-xcode company-backends))
(setq company-backends (remove 'company-cmake company-backends))
;; (setq company-backends (remove 'company-files company-backends))
(setq company-backends
      (remove 'company-dabbrev-code company-backends))
(setq company-backends (remove 'company-dabbrev company-backends))

;; (setq company-backends (remove '(company-dabbrev-code company-gtags company-etags company-keywords . #1#) company-backends))
;; (company-dabbrev . #1#))


(setq company-backends (remove 'company-gtags company-backends))
(setq company-backends (remove 'company-etags company-backends))
;; (setq company-backends (remove 'company-keywords company-backends))
(setq company-backends (remove 'company-oddmuse company-backends))

(add-to-list 'company-backends 'company-capf)
(add-to-list 'company-backends 'company-elisp)
;; (add-to-list 'company-backends 'company-async-files)


;; (straight-use-package
;;  '(icons-in-terminal.el :type git :host github :repo "seagle0128/icons-in-terminal.el"))
;; (straight-use-package 'icons-in-terminal)
;; (require 'icons-in-terminal)
;; (icons-in-terminal-icon-for-mode 'python-base-mode) 


;; (straight-use-package 'company-box)
;; (require 'company-box)
;; (add-hook 'company-mode-hook 'company-box-mode)

(setq company-dabbrev-downcase nil)


(straight-use-package 'company-box)
(require 'company-box)
(add-hook 'company-mode 'company-box-mode)

(straight-use-package 'company-prescient)
(require 'company-prescient)
(company-prescient-mode t)

;; Add yasnippet support for all company backends
;; https://github.com/syl20bnr/spacemacs/pull/179
(defvar company-mode/enable-yas t
  "Enable yasnippet for all backends.")
(defun company-mode/backend-with-yas (backend)
  (if (or (not company-mode/enable-yas)
          (and (listp backend) (member 'company-yasnippet backend)))
      backend
    (append
     (if (consp backend)
         backend
       (list backend))
     '(:with company-yasnippet))))
(setq company-backends
      (mapcar #'company-mode/backend-with-yas company-backends))


(straight-use-package 'company-posframe)
(require 'company-posframe)
(company-posframe-mode t)

(provide 'company-settings)
