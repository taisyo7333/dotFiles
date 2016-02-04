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

(provide 'init-packages)
