
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(add-to-list 'load-path "~/.emacs.d/init.d")
;(load "~/.emacs.d/init.d/init-config")

(require 'init-packages)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;ユーザー用初期化ファイル
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Ruby - setting
;; do not insert the folloing comment
;; # -*- coding: utf-8 -*-
(setq ruby-insert-encoding-magic-comment nil)

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
;                            (rubocop-mode t)
;                            (setq flyckeck-checker 'ruby-rubocop)
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
;; (require 'rinari);
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


;; 現在の行をハイライトする。
;;(require 'hlinum)
;;(hlinum-activate)
;(global-linum-mode t)

;; http://qiita.com/megane42/items/ee71f1ff8652dbf94cf7
;; rainbow-delimitersを使うための設定
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

(helm-mode t)

; ++++[http://kotatu.org/blog/2014/02/28/starts-using-projectile-rails/]+++++++++
(require 'projectile)
(projectile-global-mode)

(require 'projectile-rails)
(add-hook 'projectile-mode-hook 'projectile-rails-on)

;; C-c p h
(setq projectile-completion-system 'helm)
(helm-projectile-on)

;; rirariと同様のキーバインドを使う
(define-key projectile-rails-mode-map (kbd "C-c ; f m") 'projectile-rails-find-current-model)
(define-key projectile-rails-mode-map (kbd "C-c ; f c") 'projectile-rails-find-current-controller)
(define-key projectile-rails-mode-map (kbd "C-c ; f v") 'projectile-rails-find-current-view)
;;(define-key projectile-rails-mode-map (kbd "C-c ; f s") 'projectile-rails-find-current-spec)
(define-key projectile-rails-mode-map (kbd "C-c ; f s") 'projectile-rails-find-current-stylesheet)
(define-key projectile-rails-mode-map (kbd "C-c ; f t") 'projectile-rails-find-current-test)
(define-key projectile-rails-mode-map (kbd "C-c ; f h") 'projectile-rails-find-current-helper)
(define-key projectile-rails-mode-map (kbd "C-c ; f r") 'projectile-rails-find-current-resource)
(define-key projectile-rails-mode-map (kbd "C-c ; f f") 'projectile-rails-find-current-fixture)
(define-key projectile-rails-mode-map (kbd "C-c ; f j") 'projectile-rails-find-current-javascript)


(define-key projectile-rails-mode-map (kbd "C-c ; c")   'projectile-rails-console)

;---------[http://kotatu.org/blog/2014/02/28/starts-using-projectile-rails/]-----------

;; Display ido results vertically, rather than horizontally
(setq ido-decorations (quote ("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))
(defun ido-disable-line-truncation () (set (make-local-variable 'truncate-lines) nil))
(add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-truncation)
(defun ido-define-keys () ;; C-n/p is more intuitive in vertical layout
  (define-key ido-completion-map (kbd "C-n") 'ido-next-match)
  (define-key ido-completion-map (kbd "C-p") 'ido-prev-match))
(add-hook 'ido-setup-hook 'ido-define-keys)

(require 'color-theme)
(color-theme-initialize)
;; (color-theme-robin-hood)
;; http://aoe-tk.hatenablog.com/entry/20130210/1360506829
;; (load-theme' misterioso t)
;; http://syohex.hatenablog.com/entry/20121211/1355231365
(load-theme 'deeper-blue t)
(enable-theme 'deeper-blue)

;; (load-theme 'molokai t)
;; (enable-theme 'molokai)

;; JavaScript-mode's tab width is 2
(setq js-indent-level 2)
;(add-to-list 'auto-mode-alist '("\\.jsx\\'" . js2-jsx-mode))
;(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-jsx-mode))
;(flycheck-add-mode 'javascript-eslint 'js2-jsx-mode)
;(add-hook 'js2-jsx-mode-hook 'flycheck-mode)
;(setq tab-width 2)

;; for .es6 as javascript
(add-to-list 'auto-mode-alist '("\\.es6\\'" . js2-mode))
(flycheck-add-mode 'javascript-eslint 'js2-mode)

(require 'nvm)
(nvm-use (caar (last (nvm--installed-versions))))

(with-eval-after-load 'projectile
  (add-hook 'projectile-after-switch-project-hook 'mjs/setup-local-eslint))

; http://web-mode.org/
(require 'web-mode)
;;(add-hook 'web-mode-hook 'flycheck-mode)
; auto-completeと重なるため、ひとまず無効化する
; http://qiita.com/senda-akiha/items/cddb02cfdbc0c8c7bc2b
; view by tooltip
;; (eval-after-load 'flycheck
;;   '(custom-set-variables
;;     '(flycheck-disabled-checkers '(javascript-jshint javascript-jscs))
;;     ))

;; Usage flycheck using eslint
;; C-c ! l  : see full list of errors in a buffer.
;; C-c ! n  : next error
;; C-c ! p  : previous error

;; http://codewinds.com/blog/2015-04-02-emacs-flycheck-eslint-jsx.html
;; use web-mode for .jsx files
(add-to-list 'auto-mode-alist '("\\.jsx?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html\?\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.xml\\'" . web-mode))
;; (add-to-list 'auto-mode-alist '("\\.json\\'" . web-mode))


;; turn on flychecking globally
(add-hook 'after-init-hook #'global-flycheck-mode)

;; disable jshint since we prefer eslint checking
(setq-default flycheck-disable-checkers
              (append flycheck-disabled-checkers
                      '(javascript-jshint)))

;; use eslint with web-mode for jsx files
(flycheck-add-mode 'javascript-eslint 'web-mode)

;; customize flycheck temp file prefix
(setq-default flycheck-temp-prefix ".flycheck")

;; disable json-jsonlint checking for json files
(setq-default flycheck-disabled-checkers
              (append flycheck-disable-checkers
                      '(json-jsonlint)))

;; https://github.com/purcell/exec-path-from-shell
;; only need exec-path-from-shell on OSX
;; this hopefully sets up path and other vars better
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;; for better jsx syntax-highlighting in web-mode
;; - courtesy of Patrick @halbtuerke
(defadvice web-mode-highlight-part (around tweak-jsx activate)
  (if (equal web-mode-content-type "jsx")
    (let ((web-mode-enable-part-face nil))
      ad-do-it)
    ad-do-it))


; JSX /* ~~ */ -- > //
(add-to-list 'web-mode-comment-formats '("jsx" . "// " ))

(defun my-web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-enable-current-column-highlight t)
  (setq web-mode-enable-current-element-highlight t)
  (setq web-mode-html-offset   2)
  (setq web-mode-css-offset    2)
  (setq web-mode-script-offset 2)
  (setq web-mode-php-offset    2)
  (setq web-mode-java-offset   2)
  (setq web-mode-asp-offset    2)
  (setq web-mode-attr-indent-offset 2)
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-sql-indent-offset 2)
  (setq indent-tabs-mode nil)
  (setq tab-width 2)
  (if (equal web-mode-content-type "javascript")
      (web-mode-set-content-type "jsx")
    (message "now set to: %s" web-mode-content-type)))

(add-hook 'web-mode-hook 'my-web-mode-hook)


(defvar flycheck-javascript-eslint-executable)
(defun mjs/setup-local-eslint ()
    "If ESLint found in node_modules directory - use that for flycheck.
Intended for use in PROJECTILE-AFTER-SWITCH-PROJECT-HOOK."
    (interactive)
    (let ((local-eslint (expand-file-name "./node_modules/.bin/eslint")))
      (setq flycheck-javascript-eslint-executable
            (and (file-exists-p local-eslint) local-eslint))))

;
;describe-key ;キーに割り当てられている関数を知ることができる
;describe-function;関数を調べたいときに使う
;apropos 検索キーを含む変数、関数名を列挙する


;;
;; whitespace visible
;;
(require 'whitespace)
(setq whitespace-style '(face       ; faceで可視化
                         trailing   ; 行末
                         tabs       ; タブ
                         empty      ; 行頭/末尾の空行
                         space-mark ; 表示のマッピング
                         tab-mark
                         ))
(setq whitespace-display-mappings
      '((space-mark ?\x3000 [?\□])
        (tab-mark ?\t [?\u00BB ?\t] [?\\ ?\t])
        ))
(global-whitespace-mode t)

; Use whitespace instead of Tab.
(setq-default indent-tabs-mode nil)       ; インデントはタブではなく、スペースを使用
(setq-default show-trailing-whitespace t) ; 行末の空白をハイライト
(add-hook 'font-lock-mode-hook            ; タブをハイライト
          (lambda ()
            (font-lock-add-keywords
             nil
             '(("\t" 0 'trailing-whitespace prepend)))))


;; http://d.hatena.ne.jp/higepon/20080731/1217491155
;; Use auto-insert
(require 'autoinsert)


;; neotree
(add-to-list 'load-path "./neotree")
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)


;; Window
(global-set-key [M-left] 'shrink-window-horizontally)
(global-set-key [M-right] 'enlarge-window-horizontally)

(global-set-key [M-up] 'shrink-window)
(global-set-key [M-down] 'enlarge-window)

;; open buffer windwow
(global-set-key [f5] 'buffer-menu)
; ohter-window
(global-set-key [f6] 'other-window)

;; このファイルに間違いがあった場合に全てを無効にします
(put 'eval-expression 'disabled nil)

;; anzu
(global-anzu-mode +1)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(anzu-deactivate-region t)
 '(anzu-mode-lighter "")
 '(anzu-search-threshold 1000)
 '(package-selected-packages
   (quote
    (pandoc yaml-mode web-mode visual-regexp tern-auto-complete scss-mode ruby-electric ruby-block rubocop rspec-mode robe rinari rainbow-delimiters projectile-rails nvm neotree multi-term mode-compile markdown-mode json-mode js2-mode init-loader helm-projectile flycheck exec-path-from-shell enh-ruby-mode color-theme buttercup anzu anything))))


;; ;;(add-to-list 'load-path "folder-in-which-visual-regexp-files-are-in/") ;; if the files are not already in the load path
;; (require 'visual-regexp)
;; (define-key global-map (kbd "C-c r") 'vr/replace)
;; (define-key global-map (kbd "C-c q") 'vr/query-replace)

;; Aspell
(setq-default ispell-program-name "aspell")
(eval-after-load "ispell"
 '(add-to-list 'ispell-skip-region-alist '("[^\000-\377]+")))
;;
(global-set-key (kbd "C-M-$") 'ispell-complete-word)

;; http://sakito.jp/emacs/emacsshell.html
(require 'multi-term)

;; export LANG=ja_JP.UTF-8
;; export LESSCHARSET=utf-8
(setenv "LANG" "ja_JP.UTF-8")
(setenv "LESSCHARSET" "utf-8")


;; より下に記述した物が PATH の先頭に追加されます
(dolist (dir (list
              "/sbin"
              "/usr/sbin"
              "/bin"
              "/usr/bin"
              "/opt/local/bin"
              "/sw/bin"
              "/usr/local/bin"
              (expand-file-name "~/bin")
              (expand-file-name "~/.emacs.d/bin")
              ))
 ;; PATH と exec-path に同じ物を追加します
 (when (and (file-exists-p dir) (not (member dir exec-path)))
   (setenv "PATH" (concat dir ":" (getenv "PATH")))
   (setq exec-path (append (list dir) exec-path))))

(setenv "MANPATH" (concat "/usr/local/man:/usr/share/man:/Developer/usr/share/man:/sw/share/man" (getenv "MANPATH")))

;; shell の存在を確認
(defun skt:shell ()
  (or (executable-find "zsh")
      (executable-find "bash")
      ;; (executable-find "f_zsh") ;; Emacs + Cygwin を利用する人は Zsh の代りにこれにしてください
      ;; (executable-find "f_bash") ;; Emacs + Cygwin を利用する人は Bash の代りにこれにしてください
      (executable-find "cmdproxy")
      (error "can't find 'shell' command in PATH!!")))

;; Shell 名の設定
(setq shell-file-name (skt:shell))
(setenv "SHELL" shell-file-name)
(setq explicit-shell-file-name shell-file-name)

;; (cond
;;  ((or (eq window-system 'mac) (eq window-system 'ns))
;;   ;; Mac OS X の HFS+ ファイルフォーマットではファイル名は NFD (の様な物)で扱うため以下の設定をする必要がある
;;   (require 'ucs-normalize)
;;   (setq file-name-coding-system 'utf-8-hfs)
;;   (setq locale-coding-system 'utf-8-hfs))
;;  (or (eq system-type 'cygwin) (eq system-type 'windows-nt)
;;   (setq file-name-coding-system 'utf-8)
;;   (setq locale-coding-system 'utf-8)
;;   ;; もしコマンドプロンプトを利用するなら sjis にする
;;   ;; (setq file-name-coding-system 'sjis)
;;   ;; (setq locale-coding-system 'sjis)
;;   ;; 古い Cygwin だと EUC-JP にする
;;   ;; (setq file-name-coding-system 'euc-jp)
;;   ;; (setq locale-coding-system 'euc-jp)
;;   )
;;  (t
;;   (setq file-name-coding-system 'utf-8)
;;   (setq locale-coding-system 'utf-8)))
(setq file-name-coding-system 'utf-8)
(setq locale-coding-system 'utf-8)

;; Emacs が保持する terminfo を利用する
(setq system-uses-terminfo nil)

;; エスケープを綺麗に表示する
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; multi-term setting
;; terminal に直接通したいキーがある場合は、以下をアンコメントする
(delete "<ESC>" term-unbind-key-list)
(delete "M-x" term-unbind-key-list)
(delete "C-x" term-unbind-key-list)
(delete "C-c" term-unbind-key-list)
(delete "C-z" term-unbind-key-list)

;;(setq term-bind-key-alist (remove '"C-c C-c" term-bind-key-alist))
(add-to-list 'term-bind-key-alist '("C-c C-q" . save-buffers-kill-terminal))



(add-hook 'term-mode-hook
         '(lambda ()
            ;; C-h を term 内文字削除にする
            (define-key term-raw-map (kbd "C-h") 'term-send-backspace)
            ;; C-y を term 内ペーストにする
            (define-key term-raw-map (kbd "C-y") 'term-paste)
            ))

;; (global-set-key (kbd "C-c n") 'multi-term-next)
;; (global-set-key (kbd "C-c p") 'multi-term-prev)

(global-set-key [f3] 'multi-term-prev)
(global-set-key [f4] 'multi-term-next)

;; pandoc
(pandoc-turn-on-advice-eww)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;; bash/sh
;; https://keramida.wordpress.com/2008/08/08/tweaking-shell-script-indentation-in-gnu-emacs/
(defun gker-setup-sh-mode ()
  "My own personal preferences for `sh-mode'."
  ;; This is a custom function that sets up the parameters I usually
  ;; prefer for `sh-mode'.  It is automatically added to
  ;; `sh-mode-hook', but is can also be called interactively."
  (interactive)
  (setq sh-basic-offset 2
        sh-indentation 2
        ;; Tweak the indentation level of case-related syntax elements, to avoid
        ;; excessive indentation because of the larger than default value of
        ;; `sh-basic-offset' and other indentation options.
        sh-indent-for-case-label 0
        sh-indent-for-case-alt '+))
(add-hook 'sh-mode-hook 'gker-setup-sh-mode)

;;
;; [required]
;; $ brew install multimarkdown
;;
;; [usage]
;; C-c C-c m :generate html to another buffer
;; C-c C-c p ;generate html to browser
(setq markdown-command "multimarkdown")





