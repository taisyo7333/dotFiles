;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;ユーザー用初期化ファイル
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ~/.emacs.d/site-lisp 以下全部読み込み
(let ((default-directory (expand-file-name "~/.emacs.d/site-lisp")))
  (add-to-list 'load-path default-directory)
  (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
      (normal-top-level-add-subdirs-to-load-path)))

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

(require 'cl)

(defvar installing-package-list
  '(
    ;; ここに使っているパッケージを書く。
    init-loader
    markdown-mode
    scss-mode
    haskell-mode
    google-c-style
    yaml-mode
    open-junk-file
    auto-complete
    ruby-mode
    enh-ruby-mode
    ))

(let ((not-installed (loop for x in installing-package-list
                            when (not (package-installed-p x))
                            collect x)))
  (when not-installed
    (package-refresh-contents)
    (dolist (pkg not-installed)
        (package-install pkg))))



(require 'init-loader)
(setq init-loader-show-log-after-init nil)
(init-loader-load "~/.emacs.d/inits")


;;;;;;;;;;;;;;;;;;


;~/lib/emacs/.el
;にユーザー用の[*.el , *.elc ]を置くことができる
;.emacs.my.el 
;を入れる。

;;C言語のインデント量を「４」にする
( setq c-mode-hook
          '( lambda ()
	       ( c-set-style "stroustrup" )
	         ( setq c-basic-offset 4 )
		   (cpp-highlight-buffer t)       ;;#if 0- #endif ﾊｲﾗｲﾄ
		     ))
;(setq tab-width 4);タブ幅４
;(setq c-argdecl-indent 4)
;(setq c-indent-level 4 ) ;デフォルトは２
;(setq c-continued-statement-offset 4) ;デフォルトは２
;(setq c-tab-width 4 ) 
(setq c-tab-always-indent t) ;半自動インデント
(setq lisp-indent-line 4 );
;バックアップファイルを作らない
(setq backup-inhibited t)
;;#if 0 - #endif の中身をハイライト
(setq cpp-highlight-buffer t)
;; C++ style
(add-hook 'c++-mode-hook
          '(lambda()
             (c-set-style "stroustrup")
             (c-set-offset 'innamespace 0)   ; namespace {}の中はインデントしない
             )) 

;--------------------------------------------------
;; cpp-highlight-bufferの設定
;--------------------------------------------------
;; knownなやつも表示
(setq cpp-known-face 'default)
;; unknownなやつはハイライトする
(setq cpp-unknown-face 'highlight)
;; 選ぶのはlight background
(setq cpp-face-type 'light)
;; knownもunknownもwritable
(setq cpp-known-writable 't)
(setq cpp-unknown-writable 't)
;;  symbol              true            false           writable
;;  -----------------------------------------------------------------
;;  0                   light gray      default         both
;;  1                   default         light gray      both
(setq cpp-edit-list
      '((#("1" 0 1
	      (fontified t c-in-sws t))
	  nil
	   (background-color . "medium purple")
	    both nil)
	(#("0" 0 1
	      (fontified t c-in-sws t))
	  (background-color . "medium purple")
	   nil both nil)))

;;(if (string-match "XEmacs" emacs-version)
;;    (+ 2 3);dammy
;;    (load (expand-file-name "~/.emacs.d/key_bind.el") nil t nil)
;;)

;; このファイルに間違いがあった場合に全てを無効にします
(put 'eval-expression 'disabled nil)

;
;describe-key ;キーに割り当てられている関数を知ることができる
;describe-function;関数を調べたいときに使う
;apropos 検索キーを含む変数、関数名を列挙する



