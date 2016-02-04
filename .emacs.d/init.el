(add-to-list 'load-path "~/.emacs.d/init.d")

(require 'init-packages)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;ユーザー用初期化ファイル
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;
;; http://codeout.hatenablog.com/entry/2014/02/04/210237
;; Robeを起動させたいバッファで下記の作業を行う。
;; 必須要件
;; gem install pry  
;; gem install rcodetools   ;  .elファイルはインストール先からget.
;; pryをGemfileに記載しインストールが必要
;; 作業
;; M-x inf-ruby ( 初回のみ )
;; M-x robe-mode
;; M-x robe-start


(autoload 'ruby-mode "ruby-mode" "Mode for editing ruby source files" t)
(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
(add-to-list 'interpreter-mode-alist '("ruby" . ruby-mode))
(add-hook 'ruby-mode-hook '(lambda ()
                             (require 'rcodetools)
                             (require 'anything-rcodetools)
;                             (require 'myrurema)  ;; どうやって追加するか不明
                             (load-auto-complete)  ;; 追加
                             (define-key ruby-mode-map "\M-c" 'rct-complete-symbol)
                             (define-key ruby-mode-map "\M-d" 'xmp)
                             (setq ruby-deep-indent-paren-style nil)))

; auto-complete
(defun load-auto-complete ()
  (require 'auto-complete-config)
  (ac-config-default)

  (add-to-list 'ac-dictionary-directories "~/.emacs.d/etc/auto-complete")

  (setq ac-use-menu-map t)
  (define-key ac-menu-map "\C-n" 'ac-next)
  (define-key ac-menu-map "\C-p" 'ac-previous)

  (setq ac-auto-show-menu 0.5)
  (setq ac-menu-height 20)
  (robe-mode))

; robe
(autoload 'robe-mode "robe" "Code navigation, documentation lookup and completion for Ruby" t nil)
(autoload 'ac-robe-setup "ac-robe" "auto-complete robe" nil nil)
;(add-hook 'robe-mode-hook 'ac-robe-setup)
(add-hook 'robe-mode-hook (lambda ()
			    (ac-robe-setup)
			    (robe-start)
			    ) )

;; このファイルに間違いがあった場合に全てを無効にします
(put 'eval-expression 'disabled nil)





