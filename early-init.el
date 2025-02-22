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

(setq load-prefer-newer t)
(setq package-enable-at-startup nil)
; ignore redefinition warnings
(set 'ad-redefinition-action 'accept)
(setq frame-inhibit-implied-resize t)
(setq inhibit-startup-message t)
