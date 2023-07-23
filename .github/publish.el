(require 'org)
(require 'package)
(setq
 use-package-verbose t
 use-package-expand-minimally t)
(add-to-list
 'package-archives '("melpa" . "https://melpa.org/packages/")
 t)
(require 'use-package)
(use-package
 ox-jekyll-md
 :ensure t
 :init (setq org-jekyll-md-include-yaml-front-matter nil))

(defun my/org-export-filter-src-blocks (backend)
  (when (eq backend 'jekyll)
    (goto-char (point-min))
    (while (re-search-forward
            "^#\\+begin_src\\s-+emacs-lisp\\(.*:load\\s-+no.*\\)$"
            nil t)
      (replace-match "#+begin_src plaintext"))))
(add-hook
 'org-export-before-processing-hook 'my/org-export-filter-src-blocks)

;; Set current buffer to the publishable org buffer
(find-file "web_version.org")

;; Manually process #+INCLUDE: directives
(org-export-expand-include-keyword)

(let ((md-buffer (find-file-noselect "published_version.md")))
(org-export-to-buffer 'jekyll md-buffer
    nil nil nil nil nil (lambda () (text-mode)))
; Save the buffer
(set-buffer md-buffer)
;; write the buffer md-buffer to file
(write-file "published_version.md"))
