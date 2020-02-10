;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; refresh' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Callum Ward"
      user-mail-address "wards.callum@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "iosevka" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. These are the defaults.
(setq doom-theme 'doom-dracula)

;; If you intend to use org, it is recommended you change this!
(setq org-directory "~/org/")

;; If you want to change the style of line numbers, change this to `relative' or
;; `nil' to disable it:
(setq display-line-numbers-type 'relative)

(setq-default display-line-numbers-width nil)
(setq-default tramp-default-method "ssh")
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

;; C mode settings
(add-hook 'c-mode-hook
          (lambda ()
            (fci-mode)
            (auto-fill-mode)
            (highlight-indentation-mode)
            ))
(setq-default c-basic-offset 4)

;; Python mode settings
(add-hook 'python-mode-hook
          (lambda ()
            (fci-mode)
            (auto-fill-mode)
            ))
(setq-default python-indent-offset 4)
(setq python-shell-interpreter "python3")
(setq python-shell-interpreter-args "-i")

; Raise the number of errors flycheck will report:
; this is unstable but for large files we need to
(setq flycheck-checker-error-threshold 600)

;; Rust mode settings
(add-hook 'rust-mode-hook
          (lambda ()
            (fci-mode)
            (auto-fill-mode)
            (highlight-indentation-mode)
            ))
(setq-default rust-indent-offset 4)

;; Org mode tweaks and settings
(add-hook 'org-mode-hook 'auto-fill-mode)
(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/org/todo.org" "New")
         "* TODO %?\n %i\n %a")
        ("n" "Note" entry (file+headline "~/org/notes.org" "New")
         "* %?\n %i\n")
        )
      )

(load! ../ensoft_slick/src/enmacros/en-mirror.el)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', where Emacs
;;   looks when you load packages with `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.
