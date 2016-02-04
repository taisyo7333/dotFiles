;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(transient-mark-mode t)
(symbol-function 'transient-mark-mode)

;; ----------------------------------------
;; 文字折り返し

;; 折り返し無しを設定
;; (setq truncate-lines t)
;; (setq truncate-partial-width-windows t)

;; 折り返し有りを設定
;; (setq truncate-lines nil)
;; (setq truncate-partial-width-windows nil)

;; truncate-partial-width-windows は C-x 3 などで,
;; ウィンドウを縦に分割した時に折り返すかどうかを制御.
;; truncate-lines は通常時の折り返しを制御.

;;; 長い行でも折り返さない。
(setq-default truncate-lines t)

;; ----------------------------------------

;; 対応括弧をハイライト表示
(show-paren-mode t)
(setq show-paren-style 'mixed)
(set-face-background 'show-paren-match-face "plum2")
(set-face-foreground 'show-paren-match-face "Blue")

;; ----------------------------------------
;; 起動時の画面を非表示にする
(setq inhibit-startup-message t)

;; ----------------------------------------

;; タイトルバーにファイル名を表示
(setq frame-title-format "%b")

;; メニューバーを非表示にする
(menu-bar-mode -1)

;; ツールバーを非表示にする
(tool-bar-mode 0)

;; 時刻を24時間制でモードラインに表示
(setq display-time-24hr-format t)
(display-time)

;; 現在、どこの関数内にいるかを常に画面上部に表示する
(which-func-mode t)
;; 全てのメジャーモードに対して which-func-modeを適用する。
(setq which-func-modes t)

;; 画面上部に表示する場合は、下２桁が必要。
(delete (assoc 'which-func-mode mode-line-format) mode-line-format)
(setq-default header-line-format '(which-func-mode ("" which-func-format))) 

;; (setq explicit-shell-file-name "bash.exe")
;; (setq shell-file-name "sh.exe")
;; (setq shell-command-switch "-c")
;; (modify-coding-system-alist 'process ".*sh\\.exe" '(undecided-dos . euc-japan))
;; argument-editing の設定
;;(require 'mw32script)
;;(mw32script-init)
;;(setq exec-suffix-list '(".exe" ".sh" ".pl"))
;;(setq shell-file-name-chars "~/A-Za-z0-9_^$!#%&{}@`'.:()-")

;;(load "gtags.el")
;(load "cygwin-mount.el")

;; このファイルに間違いがあった場合に全てを無効にします
(put 'eval-expression 'disabled nil)



