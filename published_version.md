
# Table of Contents

1.  [MacOS specific settings](#org870d8cf)
2.  [Path](#orga845b82)
3.  [Colors and Theme](#orgd2a400e)
    1.  [Emacs Theme](#org288271c)
    2.  [Nano](#org9fb8f9d)
    3.  [Colors in Dired](#orge2e96e0)
4.  [Global Settings for Editing](#org0d068ce)
    1.  [Window management](#org5bc9be5)
        1.  [Zoom](#org39ba8f2)
        2.  [Visual Fill Column](#org2c7059b)
        3.  [Centered window](#orgc824da5)
    2.  [Miscellaneous](#orgc290e14)
    3.  [Dashboard](#org6fc029e)
    4.  [Icons](#orgbb6286e)
    5.  [Fonts](#orgc16d5c9)
    6.  [Indentation](#orgdf3b94c)
    7.  [Autoformatting](#orge67d2de)
    8.  [Global Keybindings](#orgf7934ff)
    9.  [Copying syntax highlighting to the clipboard](#org3086117)
    10. [Breadcrumb mode](#org6486422)
5.  [Config Modes](#org3dac275)
    1.  [Yaml](#org41af74b)
6.  [Parens](#org26ace85)
7.  [Elisp](#org54a750d)
8.  [Dired Mode](#org44e9611)
9.  [Projectile](#org7527e15)
10. [Corfu-Vertico-Orderless](#org9f3a6be)
    1.  [Corfu](#org7ab3a32)
    2.  [Cape](#orgeaa31cd)
    3.  [Orderless](#org7ffcc4d)
11. [Selectrum](#org9eb6306)
12. [Ivy/Counsel/Swiper Settings](#org26d1b1d)
13. [Company Settings](#orgf905bff)
14. [MATLAB](#org59ed2b5)
15. [Consult/Embark/Marginalia](#org62a60e9)
    1.  [Marginalia](#org586558b)
    2.  [Embark](#org92e0e30)
    3.  [Consult](#orgad46058)
16. [Latex](#org39af113)
17. [Snippets](#orga811a52)
18. [Terminal](#org756ef24)
    1.  [Vterm](#orgb2f4620)



<a id="org870d8cf"></a>

# MacOS specific settings

    (when (eq system-type 'darwin)
    (setq mac-command-modifier 'control)
    (setq mac-right-command-modifier 'meta)
    
    (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
    
    (add-to-list
     'default-frame-alist
     '(ns-appearance . light)) ;; or dark - depending on your theme
    
    (straight-use-package
     '(osx-plist :type git :host github :repo "gonewest818/osx-plist"))
    (require 'osx-plist)
    )


<a id="orga845b82"></a>

# Path

;#+PROPERTY: header-args:emacs-lisp :load yes

    (setq default-directory "~/")
    
    (use-package package)
    (use-package
     exec-path-from-shell
     :demand t
     :config
     (when (memq window-system '(mac ns x))
       (exec-path-from-shell-initialize)))


<a id="orgd2a400e"></a>

# Colors and Theme

    ;; Treat all themes as safe; no query before use.
    (setf custom-safe-themes 't)
    (setq frame-title-format nil)


<a id="org288271c"></a>

## Emacs Theme

    ;-------------COLOR THEME----------------;
    (if (eq window-system nil)
        (progn
          (+ 1 2) ;; no-op if we're in terminal mode
          ;; (load-theme 'dracula t)
          (set-background-color "brightwhite"))
      (progn
        (use-package
         ef-themes
         :config
         ;; :config (load-theme 'ef-night t)
         (load-theme 'ef-day t))))


<a id="org9fb8f9d"></a>

## Nano

    (use-package
     nano
     :straight
     (nano-emacs :type git :host github :repo "rougier/nano-emacs")
     :config (require 'nano))


<a id="orge2e96e0"></a>

## Colors in Dired

    (use-package rainbow-mode :hook (LaTeX-mode . rainbow-mode))
    (use-package dired-hacks :hook (emacs-lisp-mode . rainbow-mode))


<a id="org0d068ce"></a>

# Global Settings for Editing



<a id="org5bc9be5"></a>

## Window management

    


<a id="org39ba8f2"></a>

### Zoom

I think this is a little too aggressive right now, but it's a cool idea.

    (use-package zoom :init (setq zoom-size '(0.618 . 0.618)) :config (zoom-mode))


<a id="org2c7059b"></a>

### Visual Fill Column

    (use-package
     visual-fill-column
     :init (setq visual-fill-column-center-text t)
     :config (visual-fill-column-mode 1))


<a id="orgc824da5"></a>

### Centered window

    (use-package
     centered-window
     :init (setq cwm-centered-window-width 180)
     :ensure t
     :config (centered-window-mode t))


<a id="orgc290e14"></a>

## Miscellaneous

    (setq native-comp-async-report-warnings-errors nil)
    ;; Show the line number of the cursor in the mode bar at the bottom of each buffer
    (setq line-number-mode t)
    
    ;; Make sure all backup files only live in one place
    (setq backup-directory-alist `((".*" . ,temporary-file-directory)))
    (setq auto-save-file-name-transforms
          `((".*" ,temporary-file-directory t)))
    ;; Don't truncate lines
    (setq truncate-lines t)
    (setq-default indent-tabs-mode nil)
    
    ;; Don't show the scroll bar on the side of buffers
    (scroll-bar-mode -1)
    ;; Don't show the toolbar, it just takes up space
    (tool-bar-mode -1)
    
    ;; Show column number in the modeline
    (setq column-number-mode t)
    (setq blink-paren-function nil)
    (setq inhibit-startup-screen t)
    (use-package direnv :config (direnv-mode 't))
    (use-package
     ctrlf
     :config
     (add-to-list
      'ctrlf-minibuffer-bindings '("C-r" . ctrlf-backward-default))
     (setq ctrlf-default-search-style 'fuzzy-regexp)
     (setq ctrlf-default-search-style 'literal)
     (ctrlf-mode t))
    
    (use-package
     whole-line-or-region
     :config (whole-line-or-region-global-mode t))
    
    (use-package
     popper
     :bind
     (("C-`" . popper-toggle-latest)
      ("M-`" . popper-cycle)
      ("C-M-`" . popper-toggle-type))
     :init
     (setq popper-reference-buffers
           '("\\*Messages\\*"
    	 "Output\\*$"
    	 "\\*Async Shell Command\\*"
    	 help-mode
    	 compilation-mode))
     (popper-mode +1) (popper-echo-mode +1))
    
    (literate-elisp-load "colors-settings.org")
    (use-package
     combobulate
     ;; Optional, but recommended.
     ;;
     ;; You can manually enable Combobulate with `M-x
     ;; combobulate-mode'.
     :hook ((python-mode . combobulate-mode) (yaml-mode . combobulate-mode))
     ;; Amend this to the directory where you keep Combobulate's source
     ;; code.
     :straight '(combobulate :type git :host github :repo "mickeynp/combobulate"))
    
    (use-package
     expand-region
     :config (global-set-key (kbd "M-J") 'er/expand-region))
    
    (use-package which-key :config (which-key-mode 1))
    
    (use-package
     ibuffer
     :config
     (global-set-key (kbd "C-x C-b") 'ibuffer)
     (define-key ibuffer-mode-map (kbd "M-o") nil))

    (literate-elisp-load "term-settings.org")
    
    (define-key term-raw-map (kbd "M-o") 'next-multiframe-window)
    (define-key term-raw-map (kbd "M-i") 'previous-multiframe-window)
    (define-key global-map (kbd "M-o") 'next-multiframe-window)
    (define-key global-map (kbd "M-i") 'previous-multiframe-window)
    
    (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
    
    (use-package
      anzu
    
      :bind
      (([remap query-replace] . #'anzu-query-replace)
       ([remap query-replace-regexp] . #'anzu-query-replace-regexp))
      :config (global-anzu-mode +1))
    
    ;; Disable the loud bell
    (setq ring-bell-function
          (lambda ()
    	(let ((orig-fg (face-foreground 'mode-line)))
    	  (set-face-foreground 'mode-line "#F2804F")
    	  (run-with-idle-timer 0.1 nil
    			       (lambda (fg)
    				 (set-face-foreground 'mode-line fg))
    			       orig-fg))))
    
    (use-package lin )
    (lin-global-mode t)
    
    (use-package hl-line 
      :config
    (add-hook
     'eshell-mode-hook (lambda () (setq-local global-hl-line-mode nil)))
    (add-hook
     'term-mode-hook (lambda () (setq-local global-hl-line-mode nil)))
    (add-hook
     'vterm-mode-hook (lambda () (setq-local global-hl-line-mode nil)))
    (global-hl-line-mode t)
    )
    
    (literate-elisp-load "term-settings.org")
    
    (use-package dash )
    (use-package ht )
    
    ;; Replace the text of selections
    (pending-delete-mode t)
    
    ;; UndoTree
    ;; (straight-use-package 'undo-tree)
    ;; (straight-use-package 'undo-tree)
    ;; (require 'undo-tree)
    ;; (global-undo-tree-mode)
    
    ;; Long lines
     ;; (global-so-long-mode t)
    
    ;; Info modes
    ;; (straight-use-package 'info-plus)
    ;; (straight-use-package 'info-colors)
    ;; (add-hook 'Info-selection-hook 'info-colors-fontify-node)
    
    (use-package
     page-break-lines
    
     :config (global-page-break-lines-mode))
    
    (use-package eldoc  :hook (prog-mode . eldoc-mode))


<a id="org6fc029e"></a>

## Dashboard

    (use-package
     dashboard
     :straight
     '(emacs-dashboard
       :type git
       :host github
       :repo "emacs-dashboard/emacs-dashboard"
       :files ("banners" :defaults))
    
     :config
     ;; Set the title
     (setq dashboard-banner-logo-title "Welcome to Emacs!")
     ;; Set the banner
     (setq dashboard-startup-banner 'official)
     (setq dashboard-items
           '((projects . 5)
    	 (recents . 5) (bookmarks . 5)
    	 ;; (agenda . 5)
    	 (registers . 5)))
     ;; ;; Value can be
     ;; ;; 'official which displays the official emacs logo
     ;; ;; 'logo which displays an alternative emacs logo
     ;; ;; 1, 2 or 3 which displays one of the text banners
     ;; ;; "path/to/your/image.png" which displays whatever image you would prefer
    
     ;; ;; Content is not centered by default. To center, set
     (setq dashboard-center-content t)
     (setq initial-buffer-choice (lambda () (get-buffer "*dashboard*")))
    
     ;; ;; To disable shortcut "jump" indicators for each section, set
     ;; (setq dashboard-show-shortcuts nil)
    
     ;; Override this function so that we can filter remote projects
     (defun dashboard-projects-backend-load-projects ()
       "Depending on `dashboard-projects-backend' load corresponding backend.
      Return function that returns a list of projects."
       (cl-remove-if
        (lambda (x) (string-search "/ssh" x))
        (cl-case
         dashboard-projects-backend
         (`projectile
          (require 'projectile)
          (dashboard-mute-apply (projectile-cleanup-known-projects))
          (projectile-load-known-projects))
         (`project-el
          (require 'project)
          (dashboard-mute-apply
           (dashboard-funcall-fboundp #'project-forget-zombie-projects))
          (project-known-project-roots))
         (t
          (display-warning
           '(dashboard) "Invalid value for `dashboard-projects-backend'"
           :error)))))
    
     (dashboard-setup-startup-hook))


<a id="orgbb6286e"></a>

## Icons

    (use-package all-the-icons )
    (use-package
     all-the-icons-ibuffer
    
     :hook (ibuffer-mode . all-the-icons-ibuffer-mode))
    
    ;; I don't think I like buffer expose after all
    ;; (straight-use-package 'buffer-expose)
    ;; (require 'buffer-expose)
    ;; (buffer-expose-mode 'nil)
    (use-package
     all-the-icons-completion
    
     :config (all-the-icons-completion-mode)
     :hook
     (marginalia-mode . all-the-icons-completion-marginalia-setup))
    
    (literate-elisp-load "projectile-settings.org")
    
    ; Re-enable with SVG support
    (use-package svg-lib
     :straight '(svg-lib :host github :repo "emacs-straight/svg-lib"))
    (use-package kind-icon :straight '(kind-icon :host github :repo "jdtsmith/kind-icon")  :ensure t
     :after corfu
     :custom
     (kind-icon-default-face 'corfu-default) ; to compute blended backgrounds correctly
     :config (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))


<a id="orgc16d5c9"></a>

## Fonts

    ;; Font settings
    (if (eq system-type 'darwin)
        (if (> (x-display-pixel-width) 1440)
    	;; Set default font larger if on a big screen
    	(set-face-font 'default "roboto mono-15")
          ;; (set-face-font 'default "arial-15")
    
          ;; else
          (set-face-font 'default "roboto mono-14")
          ;; (set-fontset-font "fontset-default" "Menlo 12")
          )
      ;; else
      (if (not (eq window-system nil))
          (if (> (x-display-pixel-width) 1440)
    	  ;; Set default font larger if on a big screen
    	  (set-face-font 'default "roboto mono-15")
    	;; else
    	(set-face-font 'default "roboto mono-14")
    	;; (set-fontset-font "fontset-default" "Menlo 12")
    	)
        ;; else
        ))
    
    ;; Use ace-popup-menu for completions
    (straight-use-package 'ace-popup-menu)
    (ace-popup-menu-mode 1)
    (setq ace-popup-menu-show-pane-header t)
    
    ;; Start-up profiler
    (use-package esup)
    
    ;; Scratch.el
    (use-package
     scratch
     :straight
     '(scratch
       :host nil
       :type git
       :repo "https://codeberg.org/emacs-weirdware/scratch.git")
     :config (scratch--create 'emacs-lisp-mode "*scratch*"))
    
    (use-package fuzzy)
    (use-package fuzzy-match)
    
    (use-package free-keys)
    (use-package restart-emacs)
    
    ; ---- Auto Revert Modes ----- ;
    (autoload 'eimp-mode "eimp" "Emacs Image Manipulation Package." t)
    (add-hook 'image-mode-hook 'auto-revert-mode)
    
    ; --- CSV --- ;
    (use-package
     csv-mode
     :straight
     '(csv-mode :type git :host github :repo "emacsmirror/csv-mode"))
    
    (use-package
     explain-pause-mode
     :straight
     '(explain-pause-mode
       :type git
       :host github
       :repo "lastquestion/explain-pause-mode")
     ;; :config (explain-pause-mode)
     )
    
    ;; use helpful instead of the normal help buffers
    ;; Note that the built-in `describe-function' includes both functions
    ;; and macros. `helpful-function' is functions only, so we provide
    ;; `helpful-callable' as a drop-in replacement.
    (use-package
     helpful
     ;; TODO: Add these back in when helpful plays nicely with literate-elisp
     ;; :bind
     ;; ("C-h f" . helpful-callable)
     ;; ("C-h v" . helpful-variable)
     ;; ("C-h k" . helpful-key)
     )
    
    (use-package
     dimmer
     :config
     (dimmer-configure-which-key)
     (dimmer-configure-org)
     (dimmer-configure-posframe)
     (dimmer-configure-magit)
     (dimmer-configure-hydra)
    
     (setq dimmer-fraction 0.15)
     (dimmer-mode t))
    
    (use-package
     volatile-highlights
    
     :config (volatile-highlights-mode t))
    
    (use-package hl-todo :init (global-hl-todo-mode))


<a id="orgdf3b94c"></a>

## Indentation

    ; disable electric indent
    (electric-indent-mode 0)
    ;; (use-package
    ;;  aggressive-indent
    ;;  :config (aggressive-indent-global-mode nil))


<a id="orge67d2de"></a>

## Autoformatting

    (use-package
     apheleia
    
     :config
     (setf (alist-get 'isort apheleia-formatters)
           '("isort" "--stdout" "-"))
     (setf (alist-get 'python-base-mode apheleia-mode-alist)
           '(isort black))
     (add-to-list
      'apheleia-formatters
      '(prettier-toml
        npx "prettier" "--stdin-filepath" filepath "--parser=toml"))
     (add-to-list 'apheleia-mode-alist '(conf-toml-mode . prettier-toml))
     (defun apheleia-indent-region+ (orig scratch callback)
       (with-current-buffer scratch
         (setq-local indent-line-function
    		 (buffer-local-value 'indent-line-function orig))
         (indent-region (point-min) (point-max))
         (funcall callback scratch)))
    
     (push '(jsonian-mode . prettier-json) apheleia-mode-alist)
     (apheleia-global-mode t))
    
    (literate-elisp-load "elisp-settings.org")
    (use-package
     elisp-autofmt
     :commands (elisp-autofmt-mode elisp-autofmt-buffer)
     :hook (emacs-lisp-mode . elisp-autofmt-mode)
     :straight
     '(elisp-autofmt
       ;; :files (:defaults "elisp-autofmt")
       :host nil
       :type git
       :repo "https://codeberg.org/ideasman42/emacs-elisp-autofmt.git")
     :config (setq elisp-autofmt-on-save-p nil))


<a id="orgf7934ff"></a>

## Global Keybindings

    ;-------------CUSTOM KEYBINDINGS-----------;
    (global-set-key (kbd "M-k") 'kill-this-buffer)
    ;Window management
    ;Switch window with M-k
    
    (global-set-key (kbd "C-c C-b") 'compile)
    (global-set-key (kbd "M-0") 'delete-window)
    (global-set-key (kbd "M-1") 'delete-other-windows)
    (global-set-key (kbd "M-2") 'split-window-below)
    (global-set-key (kbd "M-3") 'split-window-right)
    
    ; Unbind reverse search because we'll use swiper
    (global-unset-key (kbd "C-r"))
    
    (global-set-key (kbd "M-u") 'upcase-dwim)
    (global-set-key (kbd "M-l") 'downcase-dwim)
    
    (global-set-key (kbd "C-.") 'xref-find-definitions-other-window)
    (define-key global-map (kbd "RET") 'newline-and-indent)


<a id="org3086117"></a>

## Copying syntax highlighting to the clipboard

    (use-package
     highlight2clipboard
     :straight
     '(highlight2clipboard
       :type git
       :host github
       :repo "Lindydancer/highlight2clipboard"))


<a id="org6486422"></a>

## Breadcrumb mode

Because I'm using this, I'm going to disable LSP's breadcrumb mode, which I've been disappointed with.

    (use-package
     breadcrumb
     :straight
     '(breadcrumb :type git :host github :repo "joaotavora/breadcrumb")
     :config (breadcrumb-mode t) (breadcrumb-imenu-crumbs))


<a id="org3dac275"></a>

# Config Modes



<a id="org41af74b"></a>

## Yaml

    (use-package yaml-mode)


<a id="org26ace85"></a>

# Parens

    (setq show-paren-when-point-inside-paren 't)
    (setq show-paren-style 'mixed)
    (setq show-paren-context-when-offscreen 't)
    
    (use-package
     elec-pair
     :config ;; Disable electric pair in minibuffer
     (defun my/inhibit-electric-pair-mode (char)
       (or (minibufferp) (electric-pair-conservative-inhibit char)))
     (setq electric-pair-inhibit-predicate
           #'my/inhibit-electric-pair-mode)
    
     (electric-pair-mode t)
     ;; The ‘<’ and ‘>’ are not ‘parenthesis’, so give them no compleition.
     (setq electric-pair-inhibit-predicate
           (lambda (c)
    	 (or (member c '(?< ?> ?~))
    	     (electric-pair-default-inhibit c)))))
    
    (setq show-paren-context-when-offscreen t)
    (setq show-paren-style 'mixed)
    
    
    ;; Treat ‘<’ and ‘>’ as if they were words, instead of ‘parenthesis’.
    (modify-syntax-entry ?< "w<")
    (modify-syntax-entry ?> "w>")
    
    ;; Show matching parens
    (setq show-paren-delay 0)
    (show-paren-mode t)


<a id="org54a750d"></a>

# Elisp

    ;; elisp settings
    (use-package eros :config (eros-mode t))
    (use-package
     lisp-extra-font-lock
     :config (lisp-extra-font-lock-global-mode 1))
    
    (use-package elisp-docstring-mode)
    (use-package
     highlight-function-calls
     :hook (emacs-lisp-mode . highlight-function-calls-mode))
    
    (use-package format-all :hook (elisp-mode . format-all-mode))
    
    
    (use-package
     inspector
     :straight
     '(inspector :type git :host github :repo "mmontone/emacs-inspector"))
    
    ; print the full value of eval'ed variables
    (setq eval-expression-print-length nil)
    (setq eval-expression-print-level nil)
    
    (add-to-list
     'auto-mode-alist
     '("\\.dir-locals\\(?:-2\\)?\\.el\\'" . emacs-lisp-mode))


<a id="org44e9611"></a>

# Dired Mode

    (setq
     dired-omit-files
     "^\\.?#\\|^\\.\\(DS_Store\\|localized\\|AppleDouble\\)$\\|^\\.\\.$")
    (setq dired-kill-when-opening-new-dired-buffer t)
    (setq
     insert-directory-program "gls"
     dired-use-ls-dired t)
    (setq dired-listing-switches "-al --group-directories-first")
    
    ;; wdired settings
    (use-package
     wdired
     :config
     (setq wdired-allow-to-change-permissions t)
     (define-key dired-mode-map (kbd "e") 'wdired-change-to-wdired-mode)
     (define-key dired-mode-map (kbd "M-G") nil))


<a id="org7527e15"></a>

# Projectile

    (use-package
     projectile
     :init (setq projectile-git-submodule-command nil)
     ;; always ignore the home directory and root
     (setq projectile-ignored-projects
           `("/" "~/" ,(expand-file-name "~/")))
    
     (setq projectile-track-known-projects-automatically nil)
    
     ;; Use alien as the default, and project-wise add other files
     (setq projectile-indexing-method 'native)
     (setq projectile-enable-caching t)
     (setq projectile-files-cache-expire 300)
     (setq projectile-file-exists-remote-cache-expire nil)
    
     :config
     (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
     (define-key
      projectile-mode-map (kbd "C-c p") 'projectile-command-map)
     (define-key projectile-mode-map (kbd "M-K") 'projectile-kill-buffers)
    
     (add-to-list 'projectile-globally-ignored-directories "/venv")
     (add-to-list 'projectile-globally-ignored-directories "/data")
     (add-to-list 'projectile-globally-ignored-directories "/typings")
     (add-to-list 'projectile-globally-ignored-directories "/.mypy_cache")
     (add-to-list
      'projectile-globally-ignored-directories "/.pytest_cache")
     (add-to-list 'projectile-globally-ignored-directories "/.cache")
     (add-to-list 'projectile-globally-ignored-directories "/.dvc/cache")
     (add-to-list 'projectile-globally-ignored-directories "/.dvc/tmp")
     (add-to-list
      'projectile-globally-ignored-directories "/.jekyll-cache")
     (projectile-mode +1)
     ;; (add-hook 'magit-run-section-hook 'projectile-invalidate-cache)
     (add-hook
      'magit-section-post-command-hook 'projectile-invalidate-cache)
    )


<a id="org9f3a6be"></a>

# Corfu-Vertico-Orderless



<a id="org7ab3a32"></a>

## Corfu

    (use-package
     corfu
     ;; Optional customizations
     :custom
     (corfu-cycle t) ;; Enable cycling for `corfu-next/previous'
     (corfu-auto t) ;; Enable auto completion
     ;; (corfu-commit-predicate nil)   ;; Do not commit selected candidates on next input
     (corfu-quit-at-boundary 'separator) ;; Automatically quit at word boundary
     (corfu-quit-no-match 'separator) ;; Automatically quit if there is no match
     (corfu-scroll-margin 5) ;; Use scroll margin
     ;; (corfu-preview-current nil)    ;; Do not preview current candidate
     (corfu-auto-delay 0.0)
     (corfu-auto-prefix 1)
     (corfu-on-exact-match 'quit)
    
     ;; (corfu-separator ?\s)          ;; Orderless field separator
     ;; (corfu-preview-current nil)    ;; Disable current candidate preview
     ;; (corfu-preselect-first nil)    ;; Disable candidate preselection
     ;; (corfu-on-exact-match nil)     ;; Configure handling of exact matches
     ;; (corfu-echo-documentation nil) ;; Disable documentation in the echo area
     ;; (corfu-scroll-margin 5)        ;; Use scroll margin
    
     ;; You may want to enable Corfu only for certain modes.
     ;; :hook ((prog-mode . corfu-mode)
     ;;        (shell-mode . corfu-mode)
     ;;        (eshell-mode . corfu-mode))
    
     ;; Recommended: Enable Corfu globally.
     ;; This is recommended since dabbrev can be used globally (M-/).
     :init (global-corfu-mode)
    
     ;; :config
     ;; (define-key corfu-map (kbd "M-p") #'corfu-doc-scroll-down) ;; corfu-next
     ;; (define-key corfu-map (kbd "M-n") #'corfu-doc-scroll-up)  ;; corfu-previous
    
     ;; Quit on save
     :hook (before-save-hook . corfu-quit)
     :load-path "straight/build/corfu/extensions"
     :config
     (require 'corfu-history)
     (corfu-history-mode 1)
     (savehist-mode 1)
     (add-to-list 'savehist-additional-variables 'corfu-history)
     ;; (corfu-mode-hook . corfu-doc-mode)
     )


<a id="orgeaa31cd"></a>

## Cape

    (defun add-cape-completions ()
      (add-to-list 'completion-at-point-functions #'cape-file)
      ;; (add-to-list 'completion-at-point-functions
      ;;              #'cape-keyword)
      ;; (add-to-list 'completion-at-point-functions
      ;;              #'cape-symbol)
      )
    
    ;; Add extensions
    (use-package
     cape
     ;; Bind dedicated completion commands
     ;; :bind (("C-c p p" . completion-at-point) ;; capf
     ;;        ("C-c p t" . complete-tag)        ;; etags
     ;;        ("C-c p d" . cape-dabbrev)        ;; or dabbrev-completion
     ;;        ("C-c p f" . cape-file)
     ;;        ("C-c p k" . cape-keyword)
     ;;        ("C-c p s" . cape-symbol)
     ;;        ("C-c p a" . cape-abbrev)
     ;;        ("C-c p i" . cape-ispell)
     ;;        ("C-c p l" . cape-line)
     ;;        ("C-c p w" . cape-dict)
     ;;        ("C-c p \\" . cape-tex)
     ;;        ("C-c p _" . cape-tex)
     ;;        ("C-c p ^" . cape-tex)
     ;;        ("C-c p &" . cape-sgml)
     ;;        ("C-c p r" . cape-rfc1345))
     :hook (corfu-mode . add-cape-completions))
    ;; A few more useful configurations...
    (setq completion-cycle-threshold 3)


<a id="org7ffcc4d"></a>

## Orderless

    ;; Optionally use the `orderless' completion style.
    (use-package
     orderless
     :init
     ;; Tune the global completion style settings to your liking!
     ;; This affects the minibuffer and non-lsp completion at point.
     (setq
      completion-styles '(orderless partial-completion basic)
      completion-category-defaults nil
      completion-category-overrides nil))
    
    ;; ;; Use dabbrev with Corfu!
    ;; (use-package dabbrev
    ;;   ;; Swap M-/ and C-M-/
    ;;   :bind (("M-/" . dabbrev-completion)
    ;;          ("C-M-/" . dabbrev-expand)))
    
    ;; A few more useful configurations...
    (use-package
     emacs
     :init
     ;; TAB cycle if there are only few candidates
     (setq completion-cycle-threshold 3)
    
     ;; Emacs 28: Hide commands in M-x which do not apply to the current mode.
     ;; Corfu commands are hidden, since they are not supposed to be used via M-x.
     ;; (setq read-extended-command-predicate
     ;;       #'command-completion-default-include-p)
     )
    
    ;; Enable vertico
    (use-package
     vertico
     :init (vertico-mode)
     :bind (:map vertico-map ("C-j" . vertico-exit-input))
    
     ;; Different scroll margin
     ;; (setq vertico-scroll-margin 0)
    
     ;; Show more candidates
     ;; (setq vertico-count 20)
    
     ;; Grow and shrink the Vertico minibuffer
     ;; (setq vertico-resize t)
    
     ;; Optionally enable cycling for `vertico-next' and `vertico-previous'.
     ;; (setq vertico-cycle t)
     )
    
    ;; Persist history over Emacs restarts. Vertico sorts by history position.
    (use-package savehist :init (savehist-mode))
    
    ;; A few more useful configurations...
    (use-package
     emacs
     :init
     ;; Add prompt indicator to `completing-read-multiple'.
     ;; We display [CRM<separator>], e.g., [CRM,] if the separator is a comma.
     (defun crm-indicator (args)
       (cons
        (format "[CRM%s] %s"
    	    (replace-regexp-in-string
    	     "\\`\\[.*?]\\*\\|\\[.*?]\\*\\'" "" crm-separator)
    	    (car args))
        (cdr args)))
     (advice-add #'completing-read-multiple :filter-args #'crm-indicator)
    
     ;; Do not allow the cursor in the minibuffer prompt
     (setq minibuffer-prompt-properties
           '(read-only t cursor-intangible t face minibuffer-prompt))
     (add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)
    
     ;; Emacs 28: Hide commands in M-x which do not work in the current mode.
     ;; Vertico commands are hidden in normal buffers.
     ;; (setq read-extended-command-predicate
     ;;       #'command-completion-default-include-p)
    
     ;; Enable recursive minibuffers
     (setq enable-recursive-minibuffers t))


<a id="org9eb6306"></a>

# Selectrum

Currently using Vertico over this

    (setq projectile-completion-system 'default)
    ;; (setq projectile-completion-system 'default)
    (use-package selectrum :config (selectrum-mode t))
    
    (use-package
     selectrum-prescient
     :config (selectrum-prescient-mode t) (prescient-persist-mode t)
    
    
     (setq enable-recursive-minibuffers t)
    
     ;; Persist history over Emacs restarts
     (savehist-mode)
    
     ;; Optional performance optimization
     ;; by highlighting only the visible candidates.
     (setq orderless-skip-highlighting (lambda () selectrum-is-active))
     (setq selectrum-highlight-candidates-function
           #'orderless-highlight-matches))


<a id="org26d1b1d"></a>

# Ivy/Counsel/Swiper Settings

Currently not using this in favor of Vertico

    (use-package ivy)
    (use-package counsel)
    (use-package swiper)
    
    ;; Case insensitive searchs
    (setq completion-ignore-case t)
    (setq case-fold-search nil)
    
    (setq
     counsel-find-file-ignore-regexp
     "^\\.?#\\|^\\.\\(DS_Store\\|localized\\|AppleDouble\\)$\\|^\\.\\.$")
    
    (ivy-mode 1) ;; Turn on ivy by default
    (setq ivy-use-virtual-buffers t) ;; no idea, but recommended by project maintainer
    (setq enable-recursive-minibuffers t) ;; no idea, but recommended by project maintainer
    (setq ivy-count-format "(%d/%d) ") ;; changes the format of the number of results
    
    
    (global-set-key
     (kbd "C-s")
     'swiper) ;; replaces i-search with swiper
    (global-set-key
     (kbd "M-x")
     'counsel-M-x) ;; Gives M-x command counsel features
    (global-set-key
     (kbd "C-x C-f")
     'counsel-find-file) ;; gives C-x C-f counsel features
    
    (global-set-key
     (kbd "C-x b")
     'counsel-switch-buffer) ;; gives C-x C-f counsel features
    (global-set-key (kbd "<f1> f") 'counsel-describe-function)
    (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
    (global-set-key (kbd "<f1> l") 'counsel-find-library)
    (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
    (global-set-key (kbd "<f2> u") 'counsel-unicode-char)
    (global-set-key (kbd "C-c C-r") 'ivy-resume)
    
    (global-set-key (kbd "C-c g") 'counsel-git)
    (global-set-key (kbd "C-c j") 'counsel-git-grep)
    (global-set-key
     (kbd "C-c k")
     'counsel-ag) ;; add counsel/ivy features to ag package
    (global-set-key (kbd "C-x l") 'counsel-locate)
    (global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
    ;;(define-key read-expression-map (kbd "C-r") 'counsel-expression-history)
    
    (define-key ivy-minibuffer-map (kbd "C-j") 'ivy-immediate-done)
    (define-key ivy-minibuffer-map (kbd "C-M-j") nil)
    
    ;;set action options during execution of counsel-find-file
    ;; replace "frame" with window to open in new window
    (ivy-set-actions
     'counsel-find-file
     '(("j" find-file-other-frame "other frame")
       ("b" counsel-find-file-cd-bookmark-action "cd bookmark")
       ("x" counsel-find-file-extern "open externally")
       ("d" delete-file "delete")
       ("r" counsel-find-file-as-root "open as root")))
    
    ;; set actions when running C-x b
    ;; replace "frame" with window to open in new window
    (ivy-set-actions
     'ivy-switch-buffer
     '(("j" switch-to-buffer-other-frame "other frame")
       ("k" kill-buffer "kill")
       ("r" ivy--rename-buffer-action "rename")))
    
    ;; Use fuzzy matching for ivy in modes that aren't swiper
    (setq ivy-re-builders-alist
          '((swiper . ivy--regex-plus) (t . ivy--regex-fuzzy)))
    
    ;; Don't list .. and . in the ivy files search
    (setq ivy-extra-directories ())
    
    ;; Persist histories across startups
    (use-package prescient)
    (use-package ivy-prescient)
    ;; Use prescient to store history of search results and preference based on these
    (ivy-prescient-mode)
    
    (prescient-persist-mode t)
    
    (use-package counsel-projectile)
    (counsel-projectile-mode)
    (setq projectile-completion-system 'ivy)
    
    (use-package
     all-the-icons-ivy-rich
     :config (all-the-icons-ivy-rich-mode t))
    (use-package ivy-rich :config (ivy-rich-mode t))


<a id="orgf905bff"></a>

# Company Settings

Company was a great package, but I'm currently not using it. I migrated over to the simpler and more flexible Corfu.

    ;----------------AUTO COMPLETE MODE--------------;
    (use-package
     company
     :config
     ;; Dont wait to show completions
     (setq company-idle-delay 0)
     (setq company-minimum-prefix-length 1)
     (setq company-quickhelp-delay nil)
     (global-company-mode t)
     (use-package
      company-async-files
      :straight
      '(company-async-files
        :type git
        :host github
        :repo "CeleritasCelery/company-async-files"))
    
     ; I dont want these company backends
     (setq company-backends (remove 'company-bbdb company-backends))
     (setq company-backends (remove 'company-eclim company-backends))
     (setq company-backends (remove 'company-semantic company-backends))
     (setq company-backends (remove 'company-clang company-backends))
     (setq company-backends (remove 'company-xcode company-backends))
     (setq company-backends (remove 'company-cmake company-backends))
     ;; (setq company-backends (remove 'company-files company-backends))
     (setq company-backends
           (remove 'company-dabbrev-code company-backends))
     (setq company-backends (remove 'company-dabbrev company-backends))
     ; I dont want these company backends
     (setq company-backends (remove 'company-bbdb company-backends))
     (setq company-backends (remove 'company-eclim company-backends))
     (setq company-backends (remove 'company-semantic company-backends))
     (setq company-backends (remove 'company-clang company-backends))
     (setq company-backends (remove 'company-xcode company-backends))
     (setq company-backends (remove 'company-cmake company-backends))
     ;; (setq company-backends (remove 'company-files company-backends))
     (setq company-backends
           (remove 'company-dabbrev-code company-backends))
     (setq company-backends (remove 'company-dabbrev company-backends)))
    (use-package
     company-quickhelp
    
     :config ;; Sort by recent use
     (company-quickhelp-mode))
    
    (setq company-dabbrev-downcase nil)
    
    (use-package company-box :hook (company-mode . company-box-mode))
    (use-package company-prescient :config (company-prescient-mode t))
    
    ;; Add yasnippet support for all company backends
    ;; https://github.com/syl20bnr/spacemacs/pull/179
    (defvar company-mode/enable-yas t
      "Enable yasnippet for all backends.")
    (defun company-mode/backend-with-yas (backend)
      (if (or (not company-mode/enable-yas)
    	  (and (listp backend) (member 'company-yasnippet backend)))
          backend
        (append
         (if (consp backend)
    	 backend
           (list backend))
         '(:with company-yasnippet))))
    (setq company-backends
          (mapcar #'company-mode/backend-with-yas company-backends))
    
    
    (use-package company-posframe :config (company-posframe-mode t))


<a id="org59ed2b5"></a>

# MATLAB

    (use-package
     matlab-mode
     '(matlab-mode
       :type git
       :repo "https://git.code.sf.net/p/matlab-emacs/src"))
    (require 'matlab)
    
    (setq matlab-shell-command-switches '("-nodesktop" "-nosplash"))


<a id="org62a60e9"></a>

# Consult/Embark/Marginalia



<a id="org586558b"></a>

## Marginalia

    (use-package marginalia :demand t :config (marginalia-mode))


<a id="org92e0e30"></a>

## Embark

    (use-package
     embark
     :demand t
     :bind
     (("C-." . embark-act) ;; pick some comfortable binding
      ;; ("C-;" . embark-dwim) ;; good alternative: M-.
      ("C-h B" . embark-bindings)) ;; alternative for `describe-bindings'
    
     :init
     ;; Optionally replace the key help with a completing-read interface
     (setq prefix-help-command #'embark-prefix-help-command)
     :config
     ;; Hide the mode line of the Embark live/completions buffers
     (add-to-list
      'display-buffer-alist
      '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
        nil
        (window-parameters (mode-line-format . none)))))
    
    ;; Consult users will also want the embark-consult package.
    (use-package
     embark-consult
     :ensure t ; only need to install it, embark loads it after consult if found
     :after consult
     :hook (embark-collect-mode . consult-preview-at-point-mode))


<a id="orgad46058"></a>

## Consult

    ;; Example configuration for Consult
    (use-package
     consult
     :demand t
     ;; Replace bindings. Lazily loaded due by `use-package'.
     :bind
     ( ;; C-c bindings (mode-specific-map)
      ("C-c h" . consult-history)
      ("C-c m" . consult-mode-command)
      ("C-c b" . consult-bookmark)
      ("C-c k" . consult-kmacro)
      ;; C-x bindings (ctl-x-map)
      ("C-x M-:" . consult-complex-command) ;; orig. repeat-complex-command
      ("C-x b" . consult-buffer) ;; orig. switch-to-buffer
      ("C-x 4 b" . consult-buffer-other-window) ;; orig. switch-to-buffer-other-window
      ("C-x 5 b" . consult-buffer-other-frame) ;; orig. switch-to-buffer-other-frame
      ;; Custom M-# bindings for fast register access
      ("M-#" . consult-register-load)
      ("M-'" . consult-register-store) ;; orig. abbrev-prefix-mark (unrelated)
      ("C-M-#" . consult-register)
      ;; Other custom bindings
      ("M-y" . consult-yank-pop) ;; orig. yank-pop
      ("<help> a" . consult-apropos) ;; orig. apropos-command
      ;; M-g bindings (goto-map)
      ("M-g e" . consult-compile-error)
      ("M-g f" . consult-flymake) ;; Alternative: consult-flycheck
      ("M-g g" . consult-goto-line) ;; orig. goto-line
      ("M-g M-g" . consult-goto-line) ;; orig. goto-line
      ("M-g o" . consult-outline) ;; Alternative: consult-org-heading
      ("M-g m" . consult-mark)
      ("M-g k" . consult-global-mark)
      ("M-g i" . consult-imenu)
      ("M-g I" . consult-imenu-multi)
      ;; M-s bindings (search-map)
      ("M-s f" . consult-find)
      ("M-s F" . consult-locate)
      ("M-s g" . consult-grep)
      ("M-s G" . consult-git-grep)
      ;; ("M-s r" . consult-ripgrep)
      ("M-s r" . consult-ripgrep-project-root)
      ("M-s l" . consult-line)
      ("M-s L" . consult-line-multi)
      ("M-s m" . consult-multi-occur)
      ("M-s k" . consult-keep-lines)
      ("M-s u" . consult-focus-lines)
      ;; Isearch integration
      ("M-s e" . consult-isearch-history)
      :map
      isearch-mode-map
      ("M-e" . consult-isearch-history) ;; orig. isearch-edit-string
      ("M-s e" . consult-isearch-history) ;; orig. isearch-edit-string
      ("M-s l" . consult-line) ;; needed by consult-line to detect isearch
      ("M-s L" . consult-line-multi)) ;; needed by consult-line to detect isearch
    
     ;; Enable automatic preview at point in the *Completions* buffer. This is
     ;; relevant when you use the default completion UI. You may want to also
     ;; enable `consult-preview-at-point-mode` in Embark Collect buffers.
     :hook (completion-list-mode . consult-preview-at-point-mode)
    
     ;; The :init configuration is always executed (Not lazy)
     :init
     (defun consult-ripgrep-project-root (&optional initial)
       (interactive "P")
       (let ((dir (funcall consult-project-function)))
         (consult--grep
          "Ripgrep" #'consult--ripgrep-make-builder dir initial)))
    
     ;; (setq consult-ripgrep-args "rg --null --line-buffered --color=never --max-columns=1000 --path-separator /\ --smart-case --no-heading --line-number .")
     (setq consult-project-function 'projectile-project-root)
    
     ;; Optionally configure the register formatting. This improves the register
     ;; preview for `consult-register', `consult-register-load',
     ;; `consult-register-store' and the Emacs built-ins.
     (setq
      register-preview-delay 0.1
      register-preview-function #'consult-register-format)
    
     ;; Optionally tweak the register preview window.
     ;; This adds thin lines, sorting and hides the mode line of the window.
     (advice-add #'register-preview :override #'consult-register-window)
    
     ;; Optionally tweak the register preview window.
     ;; This adds thin lines, sorting and hides the mode line of the window.
     (advice-add #'register-preview :override #'consult-register-window)
    
     ;; Use Consult to select xref locations with preview
     (setq
      xref-show-xrefs-function #'consult-xref
      xref-show-definitions-function #'consult-xref)
    
     ;; Configure other variables and modes in the :config section,
     ;; after lazily loading the package.
     :config
     ;; Optionally configure preview. The default value
     ;; is 'any, such that any key triggers the preview.
     (setq consult-preview-key nil)
     ;; For some commands and buffer sources it is useful to configure the
     ;; :preview-key on a per-command basis using the `consult-customize' macro.
     (consult-customize
      consult-theme
      :preview-key
      '(:debounce 0.2 any)
      consult-ripgrep
      consult-git-grep
      consult-grep
      consult-bookmark
      consult-recent-file
      consult-xref
      consult--source-bookmark
      consult--source-file-register
      consult--source-recent-file
      consult--source-project-recent-file
      ;; :preview-key "M-."
      :preview-key '(:debounce 0.4 any))
    
     ;; Optionally configure the narrowing key.
     ;; Both < and C-+ work reasonably well.
     (setq consult-narrow-key "<") ;; (kbd "C-+")
    
     ;; Optionally make narrowing help available in the minibuffer.
     ;; You may want to use `embark-prefix-help-command' or which-key instead.
     ;; (define-key consult-narrow-map (vconcat consult-narrow-key "?") #'consult-narrow-help)
    
     ;; Optionally configure a function which returns the project root directory.
     ;; There are multiple reasonable alternatives to chose from.
     ;;;; 1. project.el (project-roots)
     ;; (setq consult-project-root-function
     ;;       (lambda ()
     ;;         (when-let (project (project-current))
     ;;           (car (project-roots project)))))
     ;;;; 2. projectile.el (projectile-project-root)
     (autoload 'projectile-project-root "projectile")
     (setq consult-project-root-function #'projectile-project-root)
     ;;;; 3. vc.el (vc-root-dir)
     ;; (setq consult-project-root-function #'vc-root-dir)
     ;;;; 4. locate-dominating-file
     ;; (setq consult-project-root-function (lambda () (locate-dominating-file "." ".git")))
     )
    
    ;; Optionally add the `consult-flycheck' command.
    (use-package
     consult-flycheck
     :after consult
     :bind (:map flycheck-command-map ("!" . consult-flycheck)))
    ;; Enable Consult-Selectrum integration.
    ;; This package should be installed if Selectrum is used.


<a id="org39af113"></a>

# Latex

    (use-package
     tex
     :straight auctex
     :hook (LaTeX-mode . visual-line-mode)
     :hook (LaTeX-mode . flyspell-mode)
     :hook (LaTeX-mode . LaTeX-math-mode)
     :hook (LaTeX-mode . TeX-source-correlate-mode)
     :config
     (setq TeX-auto-save t)
     (setq TeX-parse-self t)
     (setq-default TeX-master nil)
    
     ;; (add-hook 'LaTeX-mode-hook 'company-auctex-init)
     ;; (add-hook 'LaTeX-mode-hook 'company-mode)
     (add-hook 'LaTeX-mode-hook 'turn-on-reftex)
     (setq reftex-plug-into-AUCTeX t)
     (setq TeX-PDF-mode t))
    (use-package cdlatex)
    
    ;; -------------------------/AucTex-------------------------------;;


<a id="orga811a52"></a>

# Snippets

    (use-package
     yasnippet
     :demand t
     :init
     (load "yasnippet.el") ; get rid of weird invalid function issue
     )
    (use-package
     yasnippet-snippets
     :demand t
     :straight
     '(yasnippet-snippets
       :type git
       :host github
       :repo "jsigman/yasnippet-snippets"))
    
    (yas-global-mode 1)
    (use-package
     consult-yasnippet
     :after consult
     :config (global-set-key (kbd "M-Y") 'consult-yasnippet))


<a id="org756ef24"></a>

# Terminal



<a id="orgb2f4620"></a>

## Vterm

    (use-package
     vterm
     :init
     (setq vterm-always-compile-module t)
     (setq vterm-timer-delay 0.01)
     :config (define-key vterm-mode-map (kbd "M-k") 'kill-this-buffer)
     ;; (define-key vterm-mode-map (kbd "M-i") 'previous-multiframe-window)
     ;; (define-key vterm-mode-map (kbd "M-o") 'next-multiframe-window)
     (define-key vterm-mode-map (kbd "M-0") 'delete-window)
     (define-key vterm-mode-map (kbd "M-1") 'delete-other-windows)
     (define-key vterm-mode-map (kbd "M-2") 'split-window-below)
     (define-key vterm-mode-map (kbd "M-3") 'split-window-right)
     (define-key vterm-mode-map (kbd "M-T") 'vterm-toggle)
     (define-key vterm-mode-map (kbd "M-R") 'vterm-toggle-cd)
     ; Unbind M-s so we can use this for other commands
     (define-key vterm-mode-map (kbd "M-s") 'nil)
     (setq vterm-toggle-scope 'dedicated)
     (setq vterm-toggle-project-root t)
     (setq vterm-toggle-cd-auto-create-buffer nil)
     (setq vterm-toggle-reset-window-configration-after-exit t)
     (setq vterm-toggle-fullscreen-p nil)
     (setq vterm-toggle-hide-method 'bury-all-vterm-buffer)
    
    
     (defun kill-buffer-and-its-windows (buffer)
       "Kill BUFFER and delete its windows.  Default is `current-buffer'.
    BUFFER may be either a buffer or its name (a string)."
       (interactive (list
    		 (read-buffer "Kill buffer: "
    			      (current-buffer)
    			      'existing)))
       (setq buffer (get-buffer buffer))
       (if (buffer-live-p buffer) ; Kill live buffer only.
           (let
    	   ((wins (get-buffer-window-list buffer nil t))) ; On all frames.
    	 (when (and (buffer-modified-p buffer)
    		    (fboundp '1on1-flash-ding-minibuffer-frame))
    	   (1on1-flash-ding-minibuffer-frame t)) ; Defined in `oneonone.el'.
    	 (when
    	     (kill-buffer buffer) ; Only delete windows if buffer killed.
    	   (dolist (win wins) ; (User might keep buffer if modified.)
    	     (when (window-live-p win)
    	       ;; Ignore error, in particular,
    	       ;; "Attempt to delete the sole visible or iconified frame".
    	       (condition-case nil
    		   (delete-window win)
    		 (error nil))))))
         (when (interactive-p)
           (error
    	"Cannot kill buffer.  Not a live buffer: `%s'" buffer))))
    
     (setq vterm-kill-buffer-on-exit t)
     (define-key
      vterm-mode-map (kbd "M-k")
      (lambda ()
        (interactive)
        (kill-buffer-and-its-windows (current-buffer)))))

