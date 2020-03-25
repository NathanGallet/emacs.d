;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; UI ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Minimal UI
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(menu-bar-mode -1)
(global-hl-line-mode 1)

;; Show matching parens
(setq show-paren-delay 0)
(show-paren-mode 1)

;; Disable backup files
(setq make-backup-files nil) ; stop creating backup~ files
(setq auto-save-default nil) ; stop creating #autosave# files

;; Line number
(setq x (line-number-at-pos)
      y (line-number-at-pos (point-max)))

;; Font and Frame Size
(add-to-list 'default-frame-alist '(font . "FiraCode"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Packages ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Package configs
(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives '(("org"   . "http://orgmode.org/elpa/")
			 ("gnu"   . "http://elpa.gnu.org/packages/")
			 ("melpa" . "https://melpa.org/packages/")))
(package-initialize)

;; Bootstrap `use-package`
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

;; Helm
(use-package helm
	     :ensure t
	     :init
	     (setq helm-M-x-fuzzy-match t
		   helm-mode-fuzzy-match t
		   helm-buffers-fuzzy-matching t
		   helm-recentf-fuzzy-match t
		   helm-locate-fuzzy-match t
		   helm-semantic-fuzzy-match t
		   helm-imenu-fuzzy-match t
		   helm-completion-in-region-fuzzy-match t
		   helm-candidate-number-list 150
		   helm-split-window-in-side-p t
		   helm-move-to-line-cycle-in-source t
		   helm-echo-input-in-header-line t
		   helm-autoresize-max-height 0
		   helm-autoresize-min-height 20)
	     :config
	     (helm-mode 1))

;; Vim mode
(use-package evil
	     :ensure t
	     :config
	     (evil-mode 1))

;; Use Evil-Escape in order to use jk for escaping
(use-package evil-escape
	     :ensure t
	     :init
	     (setq-default evil-escape-key-sequence "jk")
	     :config
	     (evil-escape-mode 1))

;; Evil surround
;; TODO: not working
(use-package evil-surround
	    :ensure t
	    :config
	    (global-evil-surround-mode 1))

;; Theme 
(use-package doom-themes
	     :ensure t
	     :config 
	     (load-theme 'doom-one t))

;; Which Key
(use-package which-key
	     :ensure t
	     :init
	     (setq which-key-separator " "
	           which-key-prefix-prefix "+")
	     :config
	     (which-key-mode 1))

;; Projectile
(use-package projectile
	     :ensure t
	     :init
	     (setq projectile-require-project-root nil
	           projectile-project-search-path '("~/Delight/" "~/Project/"))
	     :config
	     (projectile-mode 1))

;; All The Icons
(use-package all-the-icons :ensure t)

;; NeoTree
(use-package neotree
	     :ensure t
	     :init
	     (setq neo-theme (if (display-graphic-p) 'icons 'arrow)))

;; Windows number
(use-package winum
	     :config
	     (winum-mode))

;; Enable Helm UI for Projectile
(use-package helm-projectile
	     :config
	     (helm-projectile-on))


;; Enable smooth scrolling
(use-package smooth-scrolling
	    :config
	    (setq smooth-scroll-margin 5
		scroll-conservatively 101
		scroll-preserve-screen-position t
		auto-window-vscroll nil
		scroll-margin 5)
	    (smooth-scrolling-mode 1))

;; Front page
(use-package dashboard
	    :ensure t
	    :config
	    (dashboard-setup-startup-hook))

(use-package nlinum-relative
	    :init
	    (setq nlinum-relative-redisplay-delay 0) 
	    :config
	    (nlinum-relative-setup-evil)
	    (add-hook 'prog-mode-hook 'nlinum-relative-mode))

(use-package doom-modeline
	    :ensure t
	    :init (doom-modeline-mode 1))

(use-package evil-magit
            :init (evil-magit-init))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; KEYBINDING ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Custom keybinding
(use-package general
	     :ensure t
	     :config (general-define-key
		       :states '(normal visual insert emacs)
		       :prefix "SPC"
		       :non-normal-prefix "M-SPC"
		       ;; "/"   '(counsel-rg :which-key "ripgrep") ; You'll need counsel package for this
		       "SPC" '(helm-M-x :which-key "M-x")
		       "pf"  '(helm-find-files :which-key "find files")
		       "pt"  '(neotree-toggle :which-key "open/close neotree")
		       "pp"  '(helm-projectile-switch-project :which-key "switch project")
		       ;; Files
		       "fs"  '(save-buffer :which-key "save file")
		       "ff"  '(find-file :which-key "find file")
		       ;; Buffers
		       "bb"  '(helm-buffers-list :which-key "buffers list")
		       "TAB" '(switch-to-prev-buffer :which-key "previous buffer")
		       "C-j" '(helm-next-line :which-key "navigation helm")
		       "C-k" '(helm-previous-line :which-key "navigation helm")
		       ;; Window
		       "w/"  '(split-window-right :which-key "split right")
		       "w-"  '(split-window-below :which-key "split bottom")
		       "wd"  '(delete-window :which-key "delete window")
		       "qq"  '(save-buffers-kill-terminal :which-key "close Emacs")
		       "1"  '(winum-select-window-1 :which-key "go to window 1")
		       "2"  '(winum-select-window-2 :which-key "go to window 2")
		       "3"  '(winum-select-window-3 :which-key "go to window 3")
		       "4"  '(winum-select-window-4 :which-key "go to window 4")
		       "5"  '(winum-select-window-5 :which-key "go to window 5")
		       "6"  '(winum-select-window-6 :which-key "go to window 6")
		       ;; Others
		       "'"  '(ansi-term :which-key "open terminal")
		       "feR"  '(reload-init-file :which-key "reload config")
		       "fed"  '(open-init-file :which-key "open config")
		       ;; Magit 
		       "gs" '(magit :which-key "git status")
		       ))

;; Set keymap in helm mini-buffer
(define-key helm-map (kbd "C-j") 'helm-next-line)
(define-key helm-map (kbd "C-k") 'helm-previous-line)
(define-key helm-map (kbd "C-l")  'helm-maybe-exit-minibuffer)
(define-key minibuffer-local-map (kbd "ESC") 'keyboard-escape-quit)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Private functions ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun reload-init-file ()
  (interactive)
  (load-file user-init-file))
(defun open-init-file ()
  (interactive)
  (find-file user-init-file))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Generated ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (evil-magit magit all-the-icons doom-modeline nlinum-relative dashboard helm-projectile smooth-scrolling evil-surround evil-collection evil use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
