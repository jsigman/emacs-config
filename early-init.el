;;; early-init.el --- Early initialization -*- lexical-binding: t -*-
;; 
;; This lexical-binding directive is required for compile-angel to function correctly.
;; When using native compilation and compile-angel, all elisp files must have proper
;; lexical-binding directives on the first line to avoid compilation errors.
; increase for LSP
(setq gc-cons-threshold 50000000)
(let ((default-gc-threshold gc-cons-threshold)
      (default-gc-percentage gc-cons-percentage))
  (setq
   gc-cons-threshold most-positive-fixnum
   default-gc-percentage 0.8)
  (add-hook
   'after-init-hook
   `(lambda ()
      (setq
       gc-cons-percentage ,default-gc-percentage
       gc-cons-threshold ,default-gc-threshold))))

;; Optimize file-name-handler-alist during startup
(unless (daemonp)
  (let ((old-value (default-toplevel-value 'file-name-handler-alist)))
    (set-default-toplevel-value 'file-name-handler-alist 
                               (list (rassq 'jka-compr-handler old-value)))
    (add-hook 'emacs-startup-hook 
              (lambda () 
                (set-default-toplevel-value 'file-name-handler-alist old-value)) 101)))

;; Increase how much is read from processes in a single chunk (helps with LSP)
(setq read-process-output-max (* 2 1024 1024))  ; 2MB
(setq process-adaptive-read-buffering nil)

(setq load-prefer-newer t)
(setq package-enable-at-startup nil)
; ignore redefinition warnings
(set 'ad-redefinition-action 'accept)
(setq frame-inhibit-implied-resize t)
(setq inhibit-startup-message t)
