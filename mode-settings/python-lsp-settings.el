(when (string-equal my/lsp-package "lsp")
  (add-hook 'python-base-mode-hook #'lsp-deferred)
  (require 'pyright-lsp-settings)
  ;; (require 'mspyls-lsp-settings)
  ;; (require 'pyls-lsp-settings)
  (setq lsp-diagnostics-disabled-modes
        '(python-base-mode python-mode python-ts-mode)))
(provide 'python-lsp-settings)
