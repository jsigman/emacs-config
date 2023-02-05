(require 'dap-settings)
(require 'dap-mode)
(require 'dap-python)
(require 'dap-ui)

(add-hook 'python-base-mode-hook 'dap-mode)
(add-hook 'python-base-mode-hook 'dap-ui-mode)
(add-hook 'python-base-mode-hook 'dap-tooltip-mode)

(define-key python-base-mode-map (kbd "C-r") 'dap-debug)
(define-key python-base-mode-map (kbd "M-D") #'dap-hydra)

;; (define-key python-base-mode-map (kbd "M-D") #'dap-ui-breakpoints)
;; (define-key prog-mode-map (kbd "M-\"") 'handle-debug)

(provide 'python-dap-settings)
