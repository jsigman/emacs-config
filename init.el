;;; init.el --- Emacs init file -*- lexical-binding: t -*-

;; IMPORTANT: lexical-binding must be on the first line with proper formatting
;; This is essential for compile-angel and native compilation to work correctly.
;; Errors like "Invalid read syntax: ")" or "file has no lexical-binding directive"
;; are usually related to missing or incorrect lexical-binding settings.

;; Fix for compile-angel related issues - pre-define variables that might be referenced
(defvar old-value nil)
(defvar original-noninteractive-value nil)
(setq comp-speed 2)

;; Configure straight.el to use GitHub mirrors for Savannah repositories
(setq straight-vc-git-default-clone-url
      '(("git\\.savannah\\.gnu\\.org"
         .
         "https://github.com/emacs-straight/%s")))

;; Override recipes for specific packages
(setq straight-recipe-overrides
      '((nil
         .
         ((nongnu-elpa
           :type git
           :host github
           :repo "emacsmirror/nongnu_elpa")
          (ws-butler
           :type git
           :host github
           :repo "emacsmirror/ws-butler")
          (org
           :type git
           :host github
           :repo "emacs-straight/org-mode"
           :local-repo "org")))))

;; Packages setup to prepare literate-elisp
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el"
                         (or (bound-and-true-p straight-base-dir)
                             user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent
         'inhibit-cookies)
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
 :straight
 '(literate-elisp
   :type git
   :host github
   :repo "jingtaozf/literate-elisp")
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

; Start literate load
(literate-elisp-load
 (expand-file-name "init.org" user-emacs-directory))

(setq custom-file (concat user-emacs-directory "custom.el"))
(if (not (file-exists-p custom-file))
    (f-touch custom-file))
(load custom-file)
