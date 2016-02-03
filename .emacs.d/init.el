;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;ユーザー用初期化ファイル
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ~/.emacs.d/site-lisp 以下全部読み込み
(let ((default-directory (expand-file-name "~/.emacs.d/site-lisp")))
  (add-to-list 'load-path default-directory)
  (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
      (normal-top-level-add-subdirs-to-load-path)))

(when (require 'package nil t) 
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
  (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
  (add-to-list 'package-archives '("ELPA" . "http://tromey.com/elpa/"))
  ;; インストールするディレクトリを指定
  (setq package-user-dir(concat user-emacs-directory "elpa" ))
  ;; インスト−ルしたパッケージにロードパスを通して読み込む
  (package-initialize)
)

(require 'cl)

(defvar installing-package-list
  '(
    ;; ここに使っているパッケージを書く。
    ;; Alphabet order asc
    anything
    ;; anything-complete ; is not available
    ;; anything-config
    ;;anything-match-plugin

    auto-complete
    buttercup
    enh-ruby-mode
    flycheck
    ;; google-c-style
    ;; haskell-mode
;;    hlinum
    init-loader
    inf-ruby
    mode-compile
    markdown-mode
    ;; open-junk-file 
;;    rthml-Mode
    rinari
    rspec-mode
    robe
    ruby-compilation
    ruby-block    
    ruby-mode
    ruby-electric
    scss-mode

    web-mode
    yaml-mode
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
;; http://codeout.hatenablog.com/entry/2014/02/04/210237
;; Robeを起動させたいバッファで下記の作業を行う。
;; M-x inf-ruby ( 初回のみ )
;; M-x robe-mode
;; M-x robe-start

(autoload 'ruby-mode "ruby-mode" "Mode for editing ruby source files" t)
(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
(add-to-list 'interpreter-mode-alist '("ruby" . ruby-mode))
(add-hook 'ruby-mode-hook '(lambda ()
                             (require 'rcodetools)
                             (require 'anything-rcodetools)
                             (require 'myrurema)
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
(add-hook 'robe-mode-hook 'ac-robe-setup)



;; このファイルに間違いがあった場合に全てを無効にします
(put 'eval-expression 'disabled nil)





