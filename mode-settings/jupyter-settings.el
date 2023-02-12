;; (use-package ein :straight t)

; Below for emacs-jupyter;
;; (setq comp-deferred-compilation-deny-list (list "jupyter"))
(use-package
 zmq
 :straight '(zmq :host github :repo "nnicandro/emacs-zmq")
 :init
 ; macro to wrap loading
 (defmacro safe-wrap (fn &rest clean-up)
   `(unwind-protect
        (let (retval)
          (condition-case ex
              (setq retval
                    (progn
                      ,fn))
            ('error
             (message (format "Caught exception: [%s]" ex))
             (setq retval (cons 'exception (list ex)))))
          retval)
      ,@clean-up))

 (defun fix-zmq-file-naming ()
   "copy .so to .dylib so that we can proceed with installing zmq"
   (let* ((tag (concat "tags/" zmq-emacs-version))
          (api-url
           "https://api.github.com/repos/nnicandro/emacs-zmq/")
          (repo-url "https://github.com/nnicandro/emacs-zmq/")
          (release-url (concat api-url "releases/"))
          (info
           (zmq--download-url
            (concat release-url tag) (require 'json)
            (let ((json-object-type 'plist))
              (ignore-errors
                (json-read)))))
          (tag-name
           (or (plist-get info :tag_name) (throw 'failure nil)))
          (ezmq-sys (concat "emacs-zmq-" (zmq--system-configuration)))
          (assets
           (cl-remove-if-not
            (lambda (x) (string-prefix-p ezmq-sys x))
            (mapcar
             (lambda (x) (plist-get x :name))
             (append (plist-get info :assets) nil)))))
     (when assets
       (let ((default-directory
              (file-name-directory (locate-library "zmq"))))
         ;; We have a signature file and a tar.gz file for each binary so the
         ;; minimum number of files is two.
         (if (> (length assets) 2)
             (error "TODO More than one file found")
           (let* ((tgz-file
                   (cl-find-if
                    (lambda (x) (string-suffix-p "tar.gz" x)) assets))
                  (lib
                   (expand-file-name (concat
                                      "emacs-zmq" module-file-suffix)
                                     (expand-file-name
                                      (file-name-sans-extension
                                       (file-name-sans-extension
                                        tgz-file))))))
             (let* ((source-file
                     (concat (file-name-sans-extension lib) ".so")))
               (when (not (f-exists? lib))
                 (print (format "Copy from %s to %s" source-file lib))
                 (copy-file source-file lib)))
             t))))))

 (let (original-noninteractive-value
       noninteractive)
   ;; this is a hack so i don't have to ask about downloading the compatible binary
   (setq noninteractive t)
   (safe-wrap
    (require 'zmq)
    ;; make a copy of the file with the right target
    (fix-zmq-file-naming)
    ;; Then reload zmq, should work!
    (require 'zmq))
   ;; set the variable back to its original value
   (setq noninteractive original-noninteractive-value)))

;; (straight-use-package '(jupyter :no-native-compile t))
;; (require 'jupyter)

(use-package
 jupyter
 :straight t
 :defer t
 :custom (jupyter-repl-echo-eval-p t))

;; (with-eval-after-load 'ob-jupyter
;; (defun org-babel-edit-prep:jupyter-python (babel-info)
;;   (setq-local buffer-file-name
;;               (->> babel-info
;;                    caddr
;;                    (alist-get :tangle)))
;; (setq-local lsp-headerline-breadcrumb-enable
;;             nil)
;(lsp)
;; )
;; )


;; (debug-on-variable-change org-babel-edi

;; Hack!!
;; (defun jupyter-make-ssh-tunnel (lport rport server remoteip)
;;   (or remoteip (setq remoteip "127.0.0.1"))
;;   (start-process
;;    "jupyter-ssh-tunnel-%s-%s" lport rport nil ;; <= added the ports in case this name needs to be unique (I don't know)
;;    "ssh"
;;    ;; Run in background
;;    ;; "-f" <= COMMENTED OUT THIS LINE
;;    ;; Wait until the tunnel is open
;;    "-o ExitOnForwardFailure=yes"
;;    ;; Local forward
;;    "-L" (format "127.0.0.1:%d:%s:%d" lport remoteip rport)
;;    server
;;    ;; Close the tunnel if no other connections are made within 60
;;    ;; seconds
;;    "sleep 60"))


;; (straight-use-package 'simple-httpd)
;; (require 'simple-httpd)
;; (straight-use-package 'websocket)
;; (require 'websocket)

;; (load-file "/Users/johnnysigman/.emacs.d/straight/build/jupyter/jupyter-channel.el")
;; (require 'jupyter)

;; (require 'ob-jupyter)

;; (require 'jupyter)


;; (setq ein:markdown-enable-math t)
;; (setq ein:markdown-use-pandoc-style-yaml-metadata t)
;; (setq ein:worksheet-enable-undo t)

;; (defun ein:log (level string &rest args)
;;   (declare (indent 1))
;;   `(ein:log-wrapper ,level (lambda () (format ,string ,@args))))

;; (add-hook 'ein:ipynb-mode-hook (lambda ()
;;                                  (defun ein:log (level string &rest args)
;;                                    (declare (indent 1))
;;                                    `(ein:log-wrapper ,level
;;                                                      (lambda ()
;;                                                        (format ,string ,@args))))))
;; (add-hook 'ein:ipynb-mode 'poly-ein-mode)


;; (straight-use-package '(ox-ipynb :host github
;;                                  :repo "jkitchin/ox-ipynb")
;;                       :defer t)

;; (add-hook  'ein:ipynb-mode-hook '(tree-sitter-hl-mode nil))
(provide 'jupyter-settings)
