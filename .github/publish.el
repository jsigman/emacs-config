(require 'org)
(require 'package)
(setq use-package-verbose t
          use-package-expand-minimally t)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(require 'use-package)
(use-package ox-jekyll-md :ensure t)

; Set current buffer to the publishable org buffer
(find-file "web_version.org")
(let ((md-buffer (find-file-noselect "published_version.md")))
(org-export-to-buffer 'jekyll md-buffer
    nil nil nil nil nil (lambda () (text-mode)))
; Save the buffer
(set-buffer md-buffer)
;; write the buffer md-buffer to file
(write-file "published_version.md"))
