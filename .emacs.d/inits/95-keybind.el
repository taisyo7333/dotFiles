;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;emacs only setting
;xemacs is not setting
;
(global-set-key "\C-tab" 'other-window)  ; ohter-window
;;(global-set-key [C-tab] 'other-window)  ; ohter-window
(global-set-key "\M-g" 'goto-line)  ; 
;(global-set-key [M-g] 'goto-line)       ; goto-line

;;;キーバインド
(global-set-key [f1] 'find-file) ; C-x C-f
(global-set-key [f2] 'buffer-menu) ; open buffer windwow

					;(global-set-key [f2] 'save-buffer) ; C-x C-s
					;(global-set-key [f6] 'set-mark-command) ; C-SPC
;(global-set-key [f7] 'kill-primary-selection)   ; Cut
;(global-set-key [f8] 'copy-primary-selection)   ; Copy
;(global-set-key [f9] 'yank-clipboard-selection) ; Paste

;if call this file from xemacs , skip this code; can I ??
;(global-set-key [C-tab] 'other-window)  ; ohter-window
;(global-set-key [C-tab] 'winring-jump-to-configuration)

(global-set-key [M-left] 'shrink-window-horizontally)
(global-set-key [M-right] 'enlarge-window-horizontally)

(global-set-key [M-up] 'shrink-window)
(global-set-key [M-down] 'enlarge-window)

;; このファイルに間違いがあった場合に全てを無効にします
(put 'eval-expression 'disabled nil)



