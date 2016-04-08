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
    color-theme
    dash          ; depends on projectile
    enh-ruby-mode
    exec-path-from-shell
    flycheck
;;    flycheck-pos-tip ; display flycheck by tooltip
    ;;flymake      ; a universal on-the-fly syntax checker
    ;;flymake-ruby ; flymake for ruby
    ;;flymake-yaml ; flymake for yaml
    ;;flymake-json ; flymake for jason
    ;; google-c-style
    ;; haskell-mode
    helm
    helm-projectile
;;    hlinum
    init-loader
    inf-ruby
    js2-mode
    json-mode
    mode-compile   ; Depend on rspec-mode
    markdown-mode
    neotree
    nvm
;;     open-junk-file 
    projectile
    projectile-rails
;;    rthml-Mode
;;    rcodetools  ; gem install
    rainbow-delimiters
;;    rainbow-mode
    rinari
    rspec-mode  ; C-c , t : specmファイルからテスト対象のファイルへ飛べる
    robe
    ruby-compilation
    ruby-block    
    ruby-mode
    ruby-electric
    rubocop
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

(provide 'init-packages)
