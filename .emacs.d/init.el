(add-to-list 'load-path "~/.emacs.d/init.d")
;(load "~/.emacs.d/init.d/init-config")

(require 'init-packages)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;ユーザー用初期化ファイル
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Ruby - setting
; http://www.flycheck.org/manual/latest/Supported-languages.html#Supported-languages
; http://qiita.com/aKenjiKato/items/9ff1a153691e947113bb
(require 'flycheck)
(setq flycheck-check-syntax-automatically '(mode-enabled save))
(add-hook 'ruby-mode-hook 'flycheck-mode)
;(add-hook 'after-init-hook #'global-flycheck-mode)

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
(add-to-list 'auto-mode-alist '("\\.rb$latex " . ruby-mode))
(add-to-list 'auto-mode-alist '("Capfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))

(add-to-list 'interpreter-mode-alist '("ruby" . ruby-mode))
(add-hook 'ruby-mode-hook '(lambda ()
                             (require 'rcodetools)          ; gem install rcodetools
                             (require 'anything-rcodetools) ; gem install rcodetools
;                             (require 'myrurema)  ;; どうやって追加するか不明
			     (require 'rubocop)
                             (load-auto-complete)  ;; 追加
                             (define-key ruby-mode-map "\M-c" 'rct-complete-symbol)
                             (define-key ruby-mode-map "\M-d" 'xmp)
                             (setq ruby-deep-indent-paren-style nil)
;			     (rubocop-mode t)
;			     (setq flyckeck-checker 'ruby-rubocop)
			     (flycheck-mode 1)
			     ))

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

; flycheck & rubocop 
; http://futurismo.biz/archives/2213
(flycheck-define-checker ruby-rubocop
  "A Ruby syntax and style checker using the RuboCop tool."
  :command ("rubocop" "--format" "emacs" "--silent"
            (config-file "--config" flycheck-rubocoprc)
            source)
  :error-patterns
  ((warning line-start
            (file-name) ":" line ":" column ": " (or "C" "W") ": " (message)
            line-end)
   (error line-start
          (file-name) ":" line ":" column ": " (or "E" "F") ": " (message)
          line-end))
   :modes (enh-ruby-mode motion-mode))

;; error
;; (require 'rinari)			;
(add-hook 'rhtml-mode-hook
	  (lambda () (rinari-launch)))

;; ruby-block を導入すると, end に対応する行をハイライトしてくれる.
(require 'ruby-block)
(ruby-block-mode t)
(setq ruby-block-highlight-toggle t)

;; ruby-electric はかっこや do end などの対応関係を自動で補正してくれる.
(require 'ruby-electric)
;(add-hook 'ruby-mode-hook '(lambda () (ruby-electric-mode t)))
;(setq ruby-electric-expand-delimiters-list nil)

(require 'enh-ruby-mode)
;(autoload 'ruby-mode "ruby-mode"
;  "Mode for editing ruby source files." t )


; auto-completeと重なるため、ひとまず無効化する
; http://qiita.com/senda-akiha/items/cddb02cfdbc0c8c7bc2b
; view by tooltip
;(eval-after-load 'flycheck
;  '(custom-set-variables
;    '(flycheck-display-errors-function #'flycheck-pos-tip-error-messages
;)))


;; 現在の行をハイライトする。
;;(require 'hlinum)
;;(hlinum-activate)
;(global-linum-mode t)

;; http://qiita.com/megane42/items/ee71f1ff8652dbf94cf7
;; rainbow-delimitersを使うための設定
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)


;
;describe-key ;キーに割り当てられている関数を知ることができる
;describe-function;関数を調べたいときに使う
;apropos 検索キーを含む変数、関数名を列挙する

;; このファイルに間違いがあった場合に全てを無効にします
(put 'eval-expression 'disabled nil)





