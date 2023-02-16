(setq lsp-pyright-multi-root nil)
(setq lsp-pyright-auto-import-completions nil)

;; (setq lsp-document-sync-method 'lsp--sync-incremental)
;; (setq lsp-document-sync-method lsp--sync-full)
;; (setq lsp-pyright-diagnostic-mode "openFilesOnly")

(setq lsp-pyright-diagnostic-mode "workspace")
(setq lsp-pyright-typechecking-mode "basic")

(setq lsp-pyright-disable-organize-imports t)

(use-package
 lsp-pyright
 :straight
 '(lsp-pyright :type git :host github :repo "emacs-lsp/lsp-pyright")
 :config (setq lsp-pyright-log-level "trace"))

(provide 'pyright-lsp-settings)
