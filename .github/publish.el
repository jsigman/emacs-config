(require 'org)
(require 'package)
(setq use-package-verbose t
          use-package-expand-minimally t)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(require 'use-package)
(use-package ox-jekyll-md :ensure t :init (setq org-jekyll-md-include-yaml-front-matter nil))

(org-export-define-derived-backend 'my-jekyll 'jekyll
  :translate-alist '((src-block . my/org-jekyll-src-block)))

(defun my/org-jekyll-src-block (src-block contents info)
  (let ((lang (org-element-property :language src-block))
        (params (org-element-property :parameters src-block)))
    (if (and (string= lang "emacs-lisp") (string-match-p ":load no" params))
        (org-element-put-property src-block :language "plaintext"))
    (org-export-with-backend 'jekyll src-block contents info)))
(add-to-list 'org-export-backends 'my-jekyll)

; Set current buffer to the publishable org buffer
(find-file "web_version.org")
(let ((md-buffer (find-file-noselect "published_version.md")))
(org-export-to-buffer 'my-jekyll md-buffer
    nil nil nil nil nil (lambda () (text-mode)))
; Save the buffer
(set-buffer md-buffer)
;; write the buffer md-buffer to file
(write-file "published_version.md"))
