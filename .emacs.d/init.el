;;              __________________          
;;          /\  \   __           /  /\    /\          Author      : Aniket Meshram
;;         /  \  \  \         __/  /  \  /  \
;;        /    \  \       _____   /    \/    \        Description : Contains emacs startup configurations
;;       /  /\  \  \     /    /  /            \                     which is customized on top of init.el
;;      /        \  \        /  /      \/      \                    by David Wilson. Thanks David !!
;;     /          \  \      /  /                \                   (https://github.com/daviwil/)
;;    /            \  \    /  /                  \
;;   /              \  \  /  /                    \   Github Repo : https://github.com/aniketgm/dotfiles
;;  /__            __\  \/  /__                  __\

(setq inhibit-startup-message t)

(scroll-bar-mode -1)	; Disable visible scrollbar
(tool-bar-mode -1)	; Disable toolbar
(tooltip-mode -1)	; Disable tooltips
(set-fringe-mode 10)	; Give some breathing room
(menu-bar-mode -1)	; Disable menubar

(setq visible-bell t)	; Set visible bell

;; Set ESC as quit prompt
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Set y-or-n option for yes-or-no questions
(defalias 'yes-or-no-p 'y-or-n-p)

;; Emacs startup dashboard
(use-package dashboard
  :ensure t
  :diminish dashboard-mode
  :config
  (setq dashboard-banner-logo-title "Santoryu!")
  (setq dashboard-startup-banner "~/.emacs.d/startup_logo_01.png")
  (dashboard-setup-startup-hook))

(set-frame-parameter (selected-frame) 'alpha '(92 . 80))
(add-to-list 'default-frame-alist '(alpha . (92 . 80)))

;; Package sources --------------------------------------------------------
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; Line and Column number settings ----------------------------------------
(column-number-mode)
(global-display-line-numbers-mode t)
(menu-bar-display-line-numbers-mode 'relative)

;; Display line numbers for some modes
(dolist (mode '(org-mode-hook
		term-mode-hook
		eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; Custom Themes, Face, Fonts, Modeline -----------------------------------
(set-face-attribute 'default nil :font "Cascadia Code PL SemiLight" :height 115)

;; Set the fixed pitch face
(set-face-attribute 'fixed-pitch nil :font "Source Code Pro Light" :height 120 :width 'semi-condensed)

;; Set the variable pitch face
(set-face-attribute 'variable-pitch nil :font "Source Code Pro Medium" :height 120 :width 'semi-condensed)

;; Set Doom modeline
(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :custom (doom-modeline-height 38))

;; Install Doom Themes and set theme as 'doom-horizon'
(use-package doom-themes
  :ensure t
  :init (load-theme 'doom-Iosvkem t))

;; Fancy Search, Switch buffer, and other stuff --------------------------
(use-package ivy
  :diminish
  :bind (:map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)
         ("C-f" . ivy-alt-done)
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

(use-package swiper
  :bind ("C-s" . swiper))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config (setq which-key-idle-delay 0.3))

(use-package ivy-rich
  :config
  (ivy-rich-mode 1))

(use-package counsel
  :bind (("M-x" . counsel-M-x)
	 ("C-x b" . counsel-ibuffer)
	 ("C-x f" . counsel-recentf)
	 ("C-x C-f" . counsel-find-file)
	 :map minibuffer-local-map
	 ("C-r" . counsel-minibuffer-history))
  :config
  (setq ivy-initial-inputs-alist nil)) ;; Don't start searches with ^

(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

;; Evil mode stuff --------------------------------------------------------
(defun rune/evil-hook ()
  (dolist (mode '(custom-mode
		  eshell-mode
		  git-rebase-mode
		  erc-mode
		  circle-server-mode
		  circle-chat-mode
		  circle-query-mode
		  sauron-mode
		  term-mode))
    (add-to-list 'evil-emacs-state-modes mode)))

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)

  ;; Use visual line motions outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  ;; Set initial state of messages and dashboard as normal
  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

;; This allows to set key-bindings outside of the defined package
(use-package general
  :config
  (general-create-definer rune/leader-keys
			  :keymaps '(normal insert visual emacs)
			  :prefix "SPC"
			  :global-prefix "C-SPC")

  (rune/leader-keys
   "t"  '(:ignore t :which-key "toggles")
   "tt" '(counsel-load-theme :which-key "choose theme")))

;; Code Project Management [Projectile and Magit] -------------------------
(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom
  (setq projectile-completion-system 'ivy)
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (when (file-directory-p "/cygdrive/d/Learning/GithubRepos")
    (setq projectile-project-search-path '("/cygdrive/d/Learning/GithubRepos")))
  (setq projectile-switch-project-action #'projectile-dired))

(use-package counsel-projectile
  :after projectile
  :config (counsel-projectile-mode))

(use-package magit
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

;; Org Mode ---------------------------------------------------------------
(defun agm/org-mode-setup ()
  (org-indent-mode)
  (variable-pitch-mode 1)
  (auto-fill-mode 0)
  (visual-line-mode 1))

(defun agm/org-font-setup ()
  ;; Replace hyphens in list with dot
  (font-lock-add-keywords 'org-mode
  			'(("^ *\\([-]\\) "
  			   (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "∙"))))))
  
  ;(require 'org-faces)
  (dolist (face '((org-level-1 . 1.4)
  	          (org-level-2 . 1.25)
  	          (org-level-3 . 1.2)
  	          (org-level-4 . 1.15)
  	          (org-level-5 . 1.1)
  	          (org-level-6 . 1.05)
  	          (org-level-7 . 1.0)
  	          (org-level-8 . 1.0)))
    (set-face-attribute (car face) nil :font "Comfortaa Light" :weight 'regular :height (cdr face)))
  
  ;; Ensure that anything that should be fixed-pitch in Org files appears that way
  (set-face-attribute 'org-block nil    :foreground nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-code nil     :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-table nil    :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-checkbox nil  :inherit 'fixed-pitch))

(use-package org
  :hook (org-mode . agm/org-mode-setup)
  :config
  (setq org-ellipsis " ▾"
	org-hide-emphasis-markers t)

  (setq org-agenda-start-with-log-mode t)
  (setq org-agenda-start-on-weekday 0)
  (setq org-log-done 'time)
  (setq org-log-into-drawer t)

  (setq org-agenda-files
	'("~/orgdata/Tasks.org"))

  (setq org-todo-keywords
	'((sequence "TODO(t)" "NEXT(n)" "DOING(g)" "PAUSED(u@)" "|" "DONE(d!)")
	  (sequence "BACKLOG(b)" "PLANNING(p)" "READY(r)" "IN-PROGRESS(i)" "REVIEW(v)" "WAITING(w@/!)" "|" "COMPLETED(c)" "CANCELLED(k@)")))

  (setq org-todo-keyword-faces
	'(("TODO" . "magenta")
	  ("NEXT" . "yellow")
	  ("DOING" . "palegreen")
	  ("PAUSED" . "orange")
	  ("DONE" . "green")
	  ("CANCELLED" . "red")
	  ("BACKLOG" . "magenta")))

  (setq org-tag-alist
	'((:startgroup)
	  ; Put mutually exclusive tags here
	  (:endgroup)
	  ("home" . ?H)
	  ("work" . ?W)
	  ("agenda" . ?a)
	  ("planning" . ?p)
	  ("publish" . ?P)
	  ("batch" . ?b)
	  ("note" . ?n)
	  ("idea" . ?i)))
   
  ;; Configure custom agenda views
  (setq org-agenda-custom-commands
   '(("d" "Dashboard"
     ((agenda "" ((org-deadline-warning-days 7)))
      (todo "DOING"
        ((org-agenda-overriding-header "Active Tasks")))
      (tags-todo "agenda/IN-PROGRESS" ((org-agenda-overriding-header "Active Projects")))))

    ("n" "Tasks in-progress"
     ((todo "DOING"
        ((org-agenda-overriding-header "Next Tasks")))))

    ("W" "Work Tasks" tags-todo "+work")

    ;; Low-effort next actions
    ("e" tags-todo "+TODO=\"NEXT\"+Effort<15&+Effort>0"
     ((org-agenda-overriding-header "Low Effort Tasks")
      (org-agenda-max-todos 20)
      (org-agenda-files org-agenda-files)))

    ("w" "Workflow Status"
     ((todo "BACKLOG"
            ((org-agenda-overriding-header "Project Backlog")
             (org-agenda-todo-list-sublevels nil)
             (org-agenda-files org-agenda-files)))
      (todo "PLANNING"
            ((org-agenda-overriding-header "In Planning")
             (org-agenda-todo-list-sublevels nil)
             (org-agenda-files org-agenda-files)))
      (todo "READY"
            ((org-agenda-overriding-header "Ready for Work")
             (org-agenda-files org-agenda-files)))
      (todo "IN-PROGRESS"
            ((org-agenda-overriding-header "Active Projects")
             (org-agenda-files org-agenda-files)))
      (todo "REVIEW"
            ((org-agenda-overriding-header "In Review")
             (org-agenda-files org-agenda-files)))
      (todo "WAITING"
            ((org-agenda-overriding-header "Waiting on something")
             (org-agenda-files org-agenda-files)))
      (todo "COMPLETED"
            ((org-agenda-overriding-header "Completed Projects")
             (org-agenda-files org-agenda-files)))
      (todo "CANCELLED"
            ((org-agenda-overriding-header "Cancelled Projects")
             (org-agenda-files org-agenda-files)))))))
   
  (agm/org-font-setup))

(use-package org-bullets
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("❂" "⊛" "☉" "◎" "●" "◉" "○" "◌")))
  ;;(org-bullets-bullet-list '("❂" "⊛" "☉" "◎" "◉" "●")))

(defun agm/org-mode-visual-fill ()
  (setq visual-fill-column-width 100
        visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(use-package visual-fill-column
  :hook (org-mode . agm/org-mode-visual-fill))

;; Programming and Scripting language packages ----------------------------
(use-package powershell)
(use-package fish-mode)
(use-package vimrc-mode)

;; Automatically added by Custom ------------------------------------------
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(vimrc-mode fish-mode powershell dashboard visual-fill-column centered-window org-bullets evil-magit magit counsel-projectile projectile general evil-collection evil doom-themes helpful counsel ivy-rich which-key rainbow-delimiters ivy use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
