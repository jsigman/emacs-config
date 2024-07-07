(setq comp-speed 2)
(load (expand-file-name "packages-settings" user-emacs-directory))
(literate-elisp-load (expand-file-name "init.org" user-emacs-directory))

(setq custom-file (concat user-emacs-directory "custom.el"))
(if (not (file-exists-p custom-file))
    (f-touch custom-file))
(load custom-file)

