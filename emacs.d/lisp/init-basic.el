(setq user-full-name "Barret Ren")
(setq user-mail-address "barretren@qq.com")

(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(setq locale-coding-system 'utf-8)

(defvar font-list '(("JetBrains Mono" . 11) ("Consolas" . 12))
  "List of fonts and sizes.  The first one available will be used.")

(setq-default tab-width 4)
(setq c-basic-offset 4)
(setq-default indent-tabs-mode nil) ;tab使用空格
(xterm-mouse-mode t)
(mouse-wheel-mode t)
(electric-pair-mode t)                       ; 自动补全括号
(column-number-mode t)                       ; 在 Mode line 上显示列号
(global-auto-revert-mode t)                  ; 当另一程序修改了文件时，让 Emacs 及时刷新 Buffer
(delete-selection-mode t)                    ; 选中文本后输入文本会替换文本
(setq make-backup-files nil)                 ; 关闭文件自动备份
(global-display-line-numbers-mode 1)         ; 在 Window 显示行号
(save-place-mode 1) ; 保存光标位置
;; Automatically kill all active processes when closing Emacs
(setq confirm-kill-processes nil)
;; Turn Off Cursor Alarms
(setq ring-bell-function 'ignore)
;; Don't Lock Files
(setq-default create-lockfiles nil)
;; So Long mitigates slowness due to extremely long lines.
(when (fboundp 'global-so-long-mode)
  (global-so-long-mode))
;; simplify yes/no
(fset 'yes-or-no-p 'y-or-n-p)
(setq use-dialog-box nil)


(add-hook 'prog-mode-hook #'show-paren-mode) ; 编程模式下，光标在括号上时高亮另一个括号
(add-hook 'prog-mode-hook #'hs-minor-mode)   ; 编程模式下，可以折叠代码块

;; file format
(add-to-list 'auto-mode-alist '("\\.bb\\'" . shell-script-mode))

(provide 'init-basic)
