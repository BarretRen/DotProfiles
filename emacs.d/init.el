(cond ((version< emacs-version "26.1")
    (warn "M-EMACS requires Emacs 26.1 and above!"))
    ((let* ((early-init-f (expand-file-name "early-init.el" user-emacs-directory))
        (early-init-do-not-edit-d (expand-file-name "early-init-do-not-edit/" user-emacs-directory))
        (early-init-do-not-edit-f (expand-file-name "early-init.el" early-init-do-not-edit-d)))
    (and (version< emacs-version "27")
        (or (not (file-exists-p early-init-do-not-edit-f))
            (file-newer-than-file-p early-init-f early-init-do-not-edit-f)))
        (make-directory early-init-do-not-edit-d t)
        (copy-file early-init-f early-init-do-not-edit-f t t t t)
        (add-to-list 'load-path early-init-do-not-edit-d)
        (require 'early-init))))

;;添加lisp子目录
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
;; custom.el位置
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
;; load sub configs
(require 'init-mirror)
(require 'init-basic)
(require 'init-theme)
(require 'init-keybind)
(require 'init-plugins)
