;------------PACKAGES------------------;
;; Bootstrap straight.el here
(setq straight-repository-branch "develop") ;; TODO: remove this once fixed upstream
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el"
                         user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent
         'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(setq straight-use-package-by-default t)
(straight-use-package 'use-package)
(require 'use-package)

(use-package general :straight t)
(use-package org :straight t :demand t)

(use-package literate-elisp :straight t)
(require 'org-element) ; TODO: until org-element--cache-active-p autoload fixed in literate-elisp upstream

(provide 'packages-settings)
