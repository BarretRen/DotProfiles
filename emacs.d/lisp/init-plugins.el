(use-package which-key
  :diminish
  :custom
  (which-key-separator " ")
  (which-key-prefix-prefix "+")
  :config
  (which-key-mode))

(use-package highlight-symbol
  :init (highlight-symbol-mode)
  :bind
  ("C-c m" . highlight-symbol)
  ("C-c 1 p" . highlight-symbol-prev)
  ("C-c 1 n" . highlight-symbol-next)
  ("C-c n" . highlight-symbol-remove-all))

;; auto update plugins
(use-package auto-package-update
  :if (not (daemonp))
  :custom
  (auto-package-update-interval 30) ;; in days
  (auto-package-update-prompt-before-update t)
  (auto-package-update-delete-old-versions t)
  (auto-package-update-hide-results t)
  :config
  (auto-package-update-maybe))

;;a plugin that removes certain minor modes from mode-line.
(use-package diminish)

;;generic completion mechanism for Emacs
(use-package ivy
  :diminish
  :init
  (use-package amx :defer t)
  (use-package counsel :diminish :config (counsel-mode 1))
  (use-package swiper :defer t)
  (ivy-mode 1)
  :bind
  (("C-s" . swiper-isearch)
   ("C-c s" . counsel-rg)
   ("C-c b" . counsel-buffer-or-recentf)
   ;("C-c C-b" . counsel-ibuffer)
   (:map ivy-minibuffer-map
         ("M-RET" . ivy-immediate-done))
   (:map counsel-find-file-map
         ("C-~" . counsel-goto-local-home)))
  :custom
  (ivy-use-virtual-buffers t)
  (ivy-height 10)
  (ivy-on-del-error-function nil)
  (ivy-magic-slash-non-match-action 'ivy-magic-slash-non-match-create)
  (ivy-count-format "【%d/%d】")
  (ivy-wrap t)
  :config
  (defun counsel-goto-local-home ()
      "Go to the $HOME of the local machine."
      (interactive)
    (ivy--cd "~/")))

;; recent files
(use-package recentf
  :ensure nil
  :hook (after-init . recentf-mode)
  :custom
  (recentf-auto-cleanup "05:00am")
  (recentf-max-saved-items 30)
  (recentf-exclude '((expand-file-name package-user-dir)
                     ".cache"
                     ".cask"
                     ".elfeed"
                     "bookmarks"
                     "cache"
                     "ido.*"
                     "persp-confs"
                     "recentf"
                     "undo-tree-hist"
                     "url"
                     "COMMIT_EDITMSG\\'")))

;;directory editor
(use-package dired
  :ensure nil
  :bind
  (("C-c d" . dired-jump))
  :custom
  ;; Always delete and copy recursively
  (dired-listing-switches "-lah")
  (dired-recursive-deletes 'always)
  (dired-recursive-copies 'always)
  ;; Auto refresh Dired, but be quiet about it
  (global-auto-revert-non-file-buffers t)
  (auto-revert-verbose nil)
  ;; Quickly copy/move file in Dired
  (dired-dwim-target t)
  ;; Move files to trash when deleting
  (delete-by-moving-to-trash t)
  ;; Load the newest version of a file
  (load-prefer-newer t)
  ;; Detect external file changes and auto refresh file
  (auto-revert-use-notify nil)
  (auto-revert-interval 3) ; Auto revert every 3 sec
  :config
  ;; Enable global auto-revert
  (global-auto-revert-mode t)
  ;; Reuse same dired buffer, to prevent numerous buffers while navigating in dired
  (put 'dired-find-alternate-file 'disabled nil)
  :hook
  (dired-mode . (lambda ()
                  (local-set-key (kbd "<mouse-2>") #'dired-find-alternate-file)
                  (local-set-key (kbd "RET") #'dired-find-alternate-file)
                  (local-set-key (kbd "^")
                                 (lambda () (interactive) (find-alternate-file ".."))))))

;; visualization of undos
(use-package undo-tree
  :defer t
  :diminish undo-tree-mode
  :init (global-undo-tree-mode)
  :custom
  (undo-tree-visualizer-diff t)
  (undo-tree-history-directory-alist `(("." . ,(expand-file-name ".backup" user-emacs-directory))))
  (undo-tree-visualizer-timestamps t))

;; better buffer list
(use-package ibuffer
  :ensure nil
  :bind ("C-x C-b" . ibuffer)
  :custom
  (ibuffer-formats
   '((mark modified read-only locked " "
           (name 35 35 :left :elide)
           " "
           (size 9 -1 :right)
           " "
           (mode 16 16 :left :elide)
           " " filename-and-process)
     (mark " "
           (name 16 -1)
           " " filename))))

;; =============programing plugins=====================
;(use-package lsp-mode
  ;:defer t
  ;:commands lsp
  ;:custom
  ;(lsp-keymap-prefix "C-c l")
  ;(lsp-auto-guess-root nil)
  ;(lsp-prefer-flymake nil) ; Use flycheck instead of flymake
  ;(lsp-enable-file-watchers nil)
  ;(lsp-enable-folding nil)
  ;(read-process-output-max (* 1024 1024))
  ;(lsp-keep-workspace-alive nil)
  ;(lsp-eldoc-hook nil)
  ;:bind (:map lsp-mode-map ("C-c C-f" . lsp-format-buffer))
  ;:hook ((c-mode c++-mode) . lsp-deferred))

(use-package counsel-gtags
  :hook
  ((c-mode c++-mode java-mode text-mode) . counsel-gtags-mode)
  :init
  (progn
    (setq counsel-gtags-ignore-case t))
  :bind
  (:map counsel-gtags-mode-map
        ("C-c C-s" . counsel-gtags-find-symbol)
        ("C-c C-d" . counsel-gtags-find-definition)
        ("C-c C-r" . counsel-gtags-find-reference)
        ("C-c C-f" . counsel-gtags-find-file)
        ("C-c C-p" . counsel-gtags-go-backward)
        ("C-c C-n" . counsel-gtags-go-forward)))

(use-package magit
  :init
  (progn
    (bind-key "C-c g" 'magit-status)))

(use-package tree-sitter
  :config (global-tree-sitter-mode)
  :hook ((c-mode c++-mode java-mode python-mode) . tree-sitter-hl-mode))

(use-package tree-sitter-langs
  :after tree-sitter)

(provide 'init-plugins)
