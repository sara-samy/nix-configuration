;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
(setq doom-font (font-spec :family "IosevkaTerm Nerd Font" :size 18)
      doom-variable-pitch-font (font-spec :family "IosevkaTerm Nerd Font" :size 13)
      doom-symbol-font (font-spec :family "IosevkaTerm Nerd Font")
      doom-big-font (font-spec :family "IosevkaTerm Nerd Font" :size 24))
;; Set the font for Arabic script
(set-fontset-font t 'arabic (font-spec :family "Kawkab Mono"))

;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)
(setq-default fill-column 80)         ; Set default text width to 80
(setq-default auto-fill-function 'do-auto-fill)  ; Enable auto-wrapping
(setq-default word-wrap t)            ; Enable soft wrapping of text

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; Evil mode
(setq evil-want-integration t)    ; Enable evil integration
(setq evil-want-keybinding nil)   ; Don't use the default key bindings
(setq evil-undo-system 'undo-redo)  ; Use undo-redo
(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

;; Syntax checking and linting
(use-package flycheck
  :hook (scheme-mode . flycheck-mode))

;; Tabs
(tab-bar-mode 1)                           ;; enable tab bar
(setq tab-bar-show 1)                      ;; hide bar if <= 1 tabs open
(setq tab-bar-close-button-show nil)       ;; hide tab close / X button
(setq tab-bar-new-tab-choice "*dashboard*");; buffer to show in new tabs
(setq tab-bar-tab-hints t)                 ;; show tab numbers
(setq tab-bar-format '(tab-bar-format-tabs tab-bar-separator))
(global-set-key (kbd "s-t") 'tab-bar-new-tab)
(global-set-key (kbd "s-<left>") 'tab-bar-switch-to-prev-tab)
(global-set-key (kbd "s-<right>") 'tab-bar-switch-to-next-tab)

;; Company mode
(use-package company
  :hook (scheme-mode . company-mode)
  :config
  (setq company-idle-delay 0.1)     ; Speed up the completion menu
  (setq company-minimum-prefix-length 2))  ; Start completion after typing 2 chars

;; Scheme with guile
(use-package scheme
  :hook (scheme-mode . lisp-indent-mode)
  :config
  (setq scheme-program-name "guile"))

;; Fuzzy Finder
(use-package ivy
  :diminish
  :config
  (ivy-mode 1))
(use-package counsel
  :after ivy
  :config
  (counsel-mode))

;; Status bar
(use-package doom-modeline
  :config
  (setq doom-modeline-height 15)
  (doom-modeline-mode 1))
;; Icons and themes
(use-package all-the-icons)
(use-package doom-themes
  :config
  (load-theme 'doom-one t))   ; Or any other theme that you prefer

;; Swiper
(global-set-key "/" 'swiper)

;; Drag stuff
(require 'drag-stuff)
(drag-stuff-global-mode 1)
(define-key drag-stuff-mode-map (kbd "<S-up>") 'drag-stuff-up)
(define-key drag-stuff-mode-map (kbd "<S-down>") 'drag-stuff-down)


;; Latex
(use-package auctex
  :ensure t
  :hook
  (LaTeX-mode . turn-on-prettify-symbols-mode)
  (LaTeX-mode . turn-on-flyspell))

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
