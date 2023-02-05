(straight-use-package 'lsp-python-ms)
(require 'lsp-python-ms)


;; (setq lsp-python-ms-cache "Library")
(setq lsp-python-ms-cache "System")
;; (setq lsp-python-ms-cache "None")

(setq lsp-python-ms-completion-add-brackets t)
(setq lsp-python-ms-nupkg-channel "beta")
(setq lsp-python-ms-log-level "Warning")

;; (setq lsp-document-sync-method lsp--sync-incremental)
;; (setq lsp-document-sync-method lsp--sync-full)
(setq lsp-document-sync-method nil)
(setq lsp-auto-execute-action nil)

(setq lsp-python-ms-auto-install-server t)
;; (lsp-python-ms-update-server) ; install the server if you haven't already done so


(require 'lsp-settings)
(add-to-list 'company-lsp-filter-candidates '(mspyls . t))


(provide 'mspyls-lsp-settings)
