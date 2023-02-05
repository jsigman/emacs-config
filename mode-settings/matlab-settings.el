
(straight-use-package
 '(matlab-mode
   :type git
   :repo "https://git.code.sf.net/p/matlab-emacs/src"))
(require 'matlab)

(setq matlab-shell-command-switches '("-nodesktop" "-nosplash"))

(provide 'matlab-settings)
