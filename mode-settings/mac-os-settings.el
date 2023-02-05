;----------------KEYS FOR MAC EMACS-------------;
(setq mac-command-modifier 'control)
(setq mac-right-command-modifier 'meta)

(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))

(add-to-list
 'default-frame-alist
 '(ns-appearance . light)) ;; or dark - depending on your theme

(straight-use-package
 '(osx-plist :type git :host github :repo "gonewest818/osx-plist"))
(require 'osx-plist)

(provide 'mac-os-settings)
