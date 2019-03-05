;;;;;;;;;;;;;;;;;;;
;;;;; キーバインド
;;;;;
; M-n M-pをスクロールに割り付けてみる
(global-set-key "\M-n" 'scroll-up)
(global-set-key "\M-p" 'scroll-down)
; ctrl+hは１文字削除
;; (global-set-key "\^h" 'delete-backward-char) 
(keyboard-translate ?\C-h ?\C-?)
; M-hはヘルプ
; (global-set-key "\eh" 'help-for-help)
; M-g で 行Junp
(global-set-key "\M-g" 'goto-line)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; １行スクロール
; これしないとC-n C-pで半ページくらいスクロールする．
(setq scroll-conservatively 1)

;;; カーソルが行頭にあるときに、C-k を1回打つだけで 
;;; その行全体が削除されるようにするにはどうしたらいいのでしょうか？ 
(setq kill-whole-line t)

;; カーソルを点滅させない
;; (blink-cursor-mode nil)

;;; 最後の行はかならず改行を入れる．
(setq require-final-newline t)

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

;; バックアップファイルの作成場所を固定
(setq make-backup-files t)
(setq backup-directory-alist
      (cons (cons "\\.*$" (expand-file-name "~/.saves"))
            backup-directory-alist))

;; .emacs に、(show-paren-mode t) と書いておくと、モードにかかわらず、
;; カーソル位置の括弧に対応する括弧をハイライト表示できるようになり
;; ます。これは、とっても便利です。
(show-paren-mode t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; http://www.fan.gr.jp/~ring/Meadow/meadow.html
;;; mini buffer や kill-ring 等の履歴を次回起動時に持ち越したい
(when (locate-library "session")
  (require 'session)
  (setq session-initialize '(de-saveplace session keys menus)
        session-globals-include '((kill-ring 50)
                                  (session-file-alist 100 t)
                                  (file-name-history 100)))
  (add-hook 'after-init-hook 'session-initialize))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; C-. C-, でバッファを切り替える 
(defun my-select-visible (blst n)
  (let ((buf (nth n blst)))
    (cond ((= n (- (length blst) 1)) (other-buffer))
          ((not (= (aref (buffer-name buf) 0) ? )) buf)
          (t (my-select-visible blst (+ n 1))))))
(defun my-grub-buffer ()
  (interactive)
  (switch-to-buffer (my-select-visible
                     (reverse (cdr (assq 'buffer-list (frame-parameters)))) 0)))
(global-set-key [?\C-,] 'my-grub-buffer)
(global-set-key [?\C-.] 'bury-buffer)

;; リストを評価したらすべて出て欲しい，他
(setq eval-expression-print-level nil
      eval-expression-print-length nil
      eval-expression-debug-on-error nil)
