(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(setq straight-use-package-by-default t)
(straight-use-package 'use-package)
(require 'use-package)
(setq use-package-compute-statistics t)

(use-package general)
(use-package org)

(use-package
  literate-elisp
  :demand t
  :config
  ;; ;; To make `elisp-refs' work with `literate-elisp', we need to add an advice to `elisp-refs--read-all-buffer-forms'.
  (eval-after-load "elisp-refs"
    '(advice-add
      'elisp-refs--read-all-buffer-forms
      :around #'literate-elisp-refs--read-all-buffer-forms))
  ;; To make `elisp-refs' work with `literate-elisp', we need to add an advice to `elisp-refs--loaded-paths'.
  (eval-after-load "elisp-refs"
    '(advice-add
      'elisp-refs--loaded-paths
      :filter-return #'literate-elisp-refs--loaded-paths))
  ;; To make `helpful' work with `literate-elisp', we need to add an advice to `helpful--find-by-macroexpanding'.
  (eval-after-load 'helpful
    '(advice-add
      'helpful--find-by-macroexpanding
      :around #'literate-elisp-helpful--find-by-macroexpanding)))

(require 'org-element) ; TODO: until org-element--cache-active-p autoload fixed in literate-elisp upstream
(provide 'packages-settings)
