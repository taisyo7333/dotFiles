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
;;  0                   Light gray      default         both
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
