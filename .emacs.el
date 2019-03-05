;;;;;;;;;;;;;;;;;;;
;;;;; キーバインド
;;;;;
; M-n M-pをスクロールに割り付けてみる
(global-set-key "\M-n" 'scroll-up)
(global-set-key "\M-p" 'scroll-down)
; ctrl+hは１文字削除
(global-set-key "\^h" 'delete-backward-char) 
; M-hはヘルプ
(global-set-key "\eh" 'help-for-help)
; M-g で 行Junp
(global-set-key "\M-g" 'goto-line)

;;;;;;;;;;;;;;;;;;;;
;; TABコードはスペースで置き換える。
;; TABコード入力にはC-q TABを使う。
(setq-default indent-tabs-mode nil)
;; TABはスペースn個ぶんで
(setq-default tab-width 2)
;; 長い行の折り返し表示を t:しない。 nil:する。
;; defaultはnil
(setq-default truncate-lines nil)
;; buffer list表示後カーソルをそこに移動する。
(define-key ctl-x-map  "\C-b" 'buffer-menu)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 最後の行はかならず改行を入れる．
(setq require-final-newline t)

;;;;;;; バックアップファイル
;;; where to put save file 
(if (file-exists-p "~/.saves/")
    (setq auto-save-list-file-prefix "~/.saves/"))
(setq backup-by-copying t)
(fset 'make-backup-file-name
      '(lambda (file)
	 (concat (expand-file-name "~/.saves/")
		 (file-name-nondirectory file))
	 ))
