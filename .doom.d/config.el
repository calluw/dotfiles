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
(setq doom-font (font-spec :family "iosevka" :size 14))

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
(setq-default fci-column 80)
(setq-default fill-column 80)

;; TRAMP specifics
(setq tramp-chunksize 8192)
;; @see https://github.com/syl20bnr/spacemacs/issues/1921
;; If your tramp is hanging, you can uncomment below line.
(setq tramp-ssh-controlmaster-options
 "-o ControlMaster=auto -o ControlPath='tramp.%%C' -o ControlPersist=no")

 ;; Try to display docstrings
 (setq auto-completion-enable-help-tooltip t)

(defun lsp-format-and-save-buffer nil
  "Format the buffer with LSP and then save"
  (lsp-format-buffer)
  (save-buffer)
  )

;; C mode settings
(add-hook 'c-mode-hook
          (lambda ()
            (fci-mode)
            (auto-fill-mode)
            (setq-local fci-column 80)
            (setq-local fill-column 80)
            (add-hook 'before-save-hook 'lsp-format-buffer nil 'make-it-local)
            ))
(setq-default c-basic-offset 4)

;; Python mode settings
(add-hook 'python-mode-hook
          (lambda ()
            (fci-mode)
            (auto-fill-mode)
            (setq flycheck-checker #'python-flake8)
            (setq-local fci-column 80)
            (setq-local fill-column 80)
            (rainbow-delimiters-mode)
            ))
(setq-default python-indent-offset 4)
(setq python-shell-interpreter "python3")
(setq python-shell-interpreter-args "-i")

; Raise the number of errors flycheck will report:
; this is unstable but for large files we need to
(setq flycheck-checker-error-threshold 600)

;; Rust mode settings
(add-hook 'rustic-mode-hook
          (lambda ()
            (fci-mode)
            (auto-fill-mode)
            (lsp-ui-mode)
            (lsp-mode)
            (setq-local fci-column 100)
            (setq-local fill-column 100)
            (add-hook 'before-save-hook 'lsp-format-buffer nil 'make-it-local)
            ))
(setq-default rust-indent-offset 4)

;; Org mode tweaks and settings
(add-hook 'org-mode-hook
          (lambda ()
            (auto-fill-mode)
            (setq-local fill-column 100)
            ))

(setq org-capture-templates
      '(("i" "Inbox" entry (file+headline "~/org/inbox.org" "Inbox")
         "* TODO %?\n%i")
        ))

(setq org-agenda-files '("~/org/"))
(setq org-agenda-custom-commands
      '(("d" "GTD day view"
         ((agenda "" ((org-agenda-span 1) ; show daily view
                      (org-agenda-start-day 'nil))) ; ensure it's for today
          (todo "" ((org-agenda-files '("~/org/inbox.org"))
                    (org-agenda-overriding-header "Refile:")))
          (todo "TODO" ((org-agenda-files '("~/org/todo.org"))
                        (org-agenda-overriding-header "Remaining tasks:")
                        (org-agenda-sorting-strategy
                         '((todo priority-down category-keep effort-up)))))
          (stuck "" ((org-agenda-overriding-header "Stuck tasks:"))))
         ((org-agenda-compact-blocks t) ; don't show section breaks
          (org-agenda-files '("~/org/todo.org" "~/org.inbox.org")) ; don't show other files in agenda
          ))
        ))

;; Elm mode settings
(add-hook 'elm-mode-hook
          (lambda ()
            (fci-mode)
            (auto-fill-mode)
            (setq-local fci-column 100)
            (setq-local fill-column 100)
            (add-hook 'before-save-hook 'lsp-format-buffer nil 'make-it-local)
            ))


;; Jamfile association with conf-mode
(add-to-list 'auto-mode-alist '("\\.jam\\'" . conf-mode))
(add-to-list 'auto-mode-alist '("\\Jamfile\\'" . conf-mode))

;; Temp issue solving the void variable from lsp-ui
;; (setq lsp-ui-doc-winum-ignore t)
;; (setq lsp-ui-doc--buffer-prefix " *lsp-ui-doc-")

;; Attempt to stop Projectile using .project folders and reading as if files
;; This appears to be a Doom specific override to prefer .project, see
;; core/core-projects.el
;; TODO: Currently done directly in the Doom source

;; Stop Projectile finding files from CCLS
;(add-to-list 'projectile-globally-ignored-directories ".ccls-cache")

;;; Keybindings

;; Local leader rebind
(setq doom-localleader-key ",")

;; Window switching straight from Leader-<N> instead of Leader-w-<N>
; NOTE: requires winum installed via :ui windows +number
(map! :leader :desc "Switch to window 0 or 10" "0" #'winum-select-window-0-or-10)
(map! :leader :desc "Switch to window 1" "1" #'winum-select-window-1)
(map! :leader :desc "Switch to window 2" "2" #'winum-select-window-2)
(map! :leader :desc "Switch to window 3" "3" #'winum-select-window-3)
(map! :leader :desc "Switch to window 4" "4" #'winum-select-window-4)
(map! :leader :desc "Switch to window 5" "5" #'winum-select-window-5)
(map! :leader :desc "Switch to window 6" "6" #'winum-select-window-6)
(map! :leader :desc "Switch to window 7" "7" #'winum-select-window-7)
(map! :leader :desc "Switch to window 8" "8" #'winum-select-window-8)
(map! :leader :desc "Switch to window 9" "9" #'winum-select-window-9)

;; Projectile terminal keybinding from Spacemacs
(map! :leader :desc "Run term in project root" "p'" #'projectile-run-term)

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
