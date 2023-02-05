(use-package eglot :straight t)
(setq my/lsp-package 'eglot)

;; (add-to-list 'eglot-server-programs
;;              `(python-base-mode . ("pyls" "-v" "--tcp" "--host"
;;                               "localhost" "--port" :autoport)))
(add-hook 'python-base-mode-hook 'eglot-ensure)
(add-hook 'shell-script-mode 'eglot-ensure)
(add-hook 'yaml-mode 'eglot-ensure)
(add-hook 'js-mode 'eglot-ensure)

; Disable flymake in eglot buffers
(add-hook 'eglot--managed-mode-hook (lambda () (flymake-mode -1)))
(provide 'eglot-settings)
