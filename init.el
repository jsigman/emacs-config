(add-to-list 'load-path "~/.emacs.d/mode-settings/")
(setq comp-speed 2)

(require 'packages-settings)
(literate-elisp-load "macos-settings.org")
(literate-elisp-load "path-settings.org")
(literate-elisp-load "colors-settings.org")
(literate-elisp-load "global-settings.org")
(literate-elisp-load "config-modes-settings.org")
(literate-elisp-load "parens-settings.org")
(literate-elisp-load "elisp-settings.org")
(literate-elisp-load "dired-settings.org")
(literate-elisp-load "projectile-settings.org")
(literate-elisp-load "corfu-vertico-settings.org")
(literate-elisp-load "consult-embark-marginalia-settings.org")
(literate-elisp-load "latex-settings.org")
(literate-elisp-load "snippets-settings.org")
(literate-elisp-load "term-settings.org")
(literate-elisp-load "rg-settings.org")
(literate-elisp-load "avy-settings.org")
(literate-elisp-load "lsp-settings.org")
(literate-elisp-load "python-settings.org")
(literate-elisp-load "copilot-settings.org")
(literate-elisp-load "flycheck-settings.org")
(literate-elisp-load "tramp-settings.org")
(literate-elisp-load "java-settings.org")
(literate-elisp-load "org-settings.org")
(literate-elisp-load "magit-settings.org")
(literate-elisp-load "multiple-cursors-settings.org")
(literate-elisp-load "modeline-settings.org")
(literate-elisp-load "docker-settings.org")
(literate-elisp-load "dap-settings.org")
(literate-elisp-load "treemacs-settings.org")
(literate-elisp-load "markdown-settings.org")

(setq custom-file (concat user-emacs-directory "custom.el"))
(if (not (file-exists-p custom-file))
    (f-touch custom-file))
(load custom-file)
