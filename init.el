;;; init.el --- Personal configuration
;;; Commentary:
;;; Code:

(defvar custom-file-path "~/.emacs.d/custom.el" )
;;; disable init.el modifying by custom system
(if (not (file-exists-p custom-file-path))
    (write-region "" "" custom-file-path))

(setq custom-file custom-file-path)
(load custom-file)

;;; Import a package
(require 'package)

;;; Plugins list
(setq package-list '(xclip
                     rust-mode
                     gruvbox-theme
                     smart-mode-line
                     company
                     company-jedi
                     company-ycmd
                     company-racer
                     company-quickhelp
                     flx
                     flx-ido
                     ido-vertical-mode
                     smex
                     ycmd
                     yafolding
                     yasnippet
                     flycheck
                     fzf
                     rg
                     git-gutter
                     neotree
                     all-the-icons
                     rainbow-delimiters
                     busybee-theme
                    ))

;;; list the repositories containing them
;;(add-to-list 'load-path "~/.emacs.d/custom"
;;(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)

;;; activate all the packages (in particular autoloads)
(package-initialize)
;;; fetch the list of packages available
(unless package-archive-contents
    (package-refresh-contents))

;;; install the missing packages
(dolist (package package-list)
    (unless (package-installed-p package)
	  (package-install package)))

;;; enables copy and paste in terminal
(xclip-mode 1)
(setq company-idle-delay 0)

(setq-default c-basic-offset 4)
(setq-default company-dabbrev-downcase nil)

;;; yafolding activation
(require 'yafolding)
(yafolding-mode t)

(require 'rg)
(global-set-key (kbd "<f3>") 'rg)
;;; Splits


;; git highlightings
(require 'git-gutter)
(global-git-gutter-mode t)


;;;;; Apperiance settings
(load-theme 'busybee t)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(set-frame-font "Source Code Pro-12")
(setq inhibit-startup-message t)
(setq sml/no-confirm-load-theme t)
(sml/setup)
(setq sml/theme 'respectful)
(global-hl-line-mode 1)
(setq-default truncate-lines t)
(defalias 'yes-or-no-p 'y-or-n-p)

;;; Backups placing
(setq
   backup-by-copying t      ; don't clobber symlinks
   backup-directory-alist
    '(("." . "~/.saves"))    ; don't litter my fs tree
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2
   version-control t)       ; use versioned backups


;;; additional editing configuration
(electric-pair-mode 1)
(show-paren-mode 1)
(global-linum-mode 1)
(setq linum-format "%4d \u2502 ") ;;; for terminal
(delete-selection-mode 1)
(setq-default indent-tabs-mode -1)

;;; pretty lisp
(require 'rainbow-delimiters)

(add-hook 'prog-mode-hook #'hs-minor-mode)

(eval-after-load 'hideshow
 '(progn
   (global-set-key (kbd "C-+") 'hs-toggle-hiding)))

;;; interactive do

(require 'ido)
(require 'ido-vertical-mode)
(require 'smex)
(require 'flx-ido)
(smex-initialize)
(ido-mode 't)
(ido-everywhere 't)
(ido-vertical-mode t)
(setq ido-vertical-define-keys 'C-n-and-C-p-only)
(flx-ido-mode 1)
;; disable ido faces to see flx highlights.
(setq ido-enable-flex-matching t)
(setq ido-use-faces nil)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)


;;; syntax checking
(eval-after-load 'flycheck
  '(progn
	 (global-flycheck-mode)))

;;; autocomplete
(setq company-idle-delay 0)
(setq-default c-basic-offset 4)
(setq-default company-dabbrev-downcase nil)


(set-variable 'ycmd-server-command '("python" "/data/yshalenyk/tools/ycmd/ycmd"))
(eval-after-load 'company
  '(progn
     (define-key company-active-map [tab] 'company-select-next)
     (define-key company-active-map (kbd "TAB") 'company-select-next)
     (add-to-list 'company-backends 'company-racer)
     (add-to-list 'company-backends 'company-jedi)
     (company-quickhelp-mode 1)
     ))
(require 'ycmd)
(add-hook 'after-init-hook 'global-ycmd-mode)
(add-hook 'after-init-hook 'global-company-mode)
(require 'company-ycmd)
(company-ycmd-setup)




;;; Code: templates
(require 'yasnippet)
(yas-reload-all)
(add-hook 'prog-mode-hook #'yas-minor-mode)
(define-key yas-minor-mode-map (kbd "<tab>") nil)
(define-key yas-minor-mode-map (kbd "TAB") nil)
(define-key yas-minor-mode-map (kbd "C-'") 'yas-expand)

(setq neo-theme (if (display-graphic-p) 'icons 'arrow))
(require 'all-the-icons)
(setq js-indent-level 4)

(global-set-key (kbd "C-'") 'fzf)

(global-set-key (kbd "C-0") 'other-frame)

;;; init.el ends here
