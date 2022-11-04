;; DeferGC
(setq gc-cons-threshold 100000000)
;; -DeferGC

;; UnsetPES
(setq package-enable-at-startup nil)
;; -UnsetPES

;; UnsetFNHA
(defvar file-name-handler-alist-original file-name-handler-alist)
(setq file-name-handler-alist nil)
;; -UnsetFNHA

;; UnsetSRF
(setq site-run-file nil)
;; -UnsetSRF

(setq inhibit-startup-message t)             ; 关闭启动 Emacs 时的欢迎界面
(setq initial-major-mode 'text-mode)

;; DisableUnnecessaryInterface
(menu-bar-mode -1)
(tool-bar-mode -1)
(toggle-scroll-bar -1)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)
;; -DisableUnnecessaryInterface

(provide 'early-init)
