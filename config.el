;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "FiveArms"
      user-mail-address "me@fivearms.page")


;;
;;; UI

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
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!
(setq doom-font                (font-spec :family "IBM Plex Mono")
      doom-variable-pitch-font (font-spec :family "IBM Plex Sans")
      doom-serif-font          (font-spec :family "IBM Plex Serif"))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type nil)


;;
;;; Keybinds

;; (map! (:after evil-org
;;        :map evil-org-mode-map
;;        :n "gk" (cmd! (if (org-at-heading-p)
;;                          (org-backward-element)
;;                        (evil-previous-visual-line)))
;;        :n "gj" (cmd! (if (org-at-heading-p)
;;                          (org-forward-element)
;;                        (evil-next-visual-line))))

;;       :o "o" #'evil-inner-symbol)


;;
;;; Modules

;;; :completion company
;; Disable completion in text and org modes
(setq company-global-modes '(not text-mode org-mode))

;;; :editor evil
;; Focus new window after splitting
(setq evil-split-window-below t
      evil-vsplit-window-right t)
;; Change easy-motion jump targets for Colemak keyboard layout
(setq avy-keys '(?a ?r ?s ?t ?h ?n ?e ?i ?o))

;;; :checkers spell
;; Slow down spellchecking
;; idle defaults to 1s, and window defaults to 3
(after! flyspell
  (setq flyspell-lazy-idle-seconds 2)
  (setq flyspell-lazy-window-idle-seconds 30))

;;; :lang markdown
;; pandoc-mode - auto-start; use defaults
;; NOTE Requires calling '(package! pandoc-mode)' in 'packages.el'
;; (add-hook 'markdown-mode-hook 'pandoc-mode)
;; (add-hook 'pandoc-mode-hook 'pandoc-load-default-settings)



;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
;; (setq org-directory "~/org/")

;;; :lang org
(setq org-directory  "~/org-reinisch-glob/org/"
      org-archive-location (concat org-directory ".archive/%s::")
      org-agenda-files (list org-directory))

(after! org
  (setq org-startup-folded 'show2levels
        org-ellipsis " [...] "
        org-tags-column -77
        org-log-into-drawer t
        org-todo-repeat-to-state t))

;; Custom org agenda commands and helper functions
(after! org
  (setq org-agenda-custom-commands
        '(("n" "Agenda and all TODOs" ((agenda "") (alltodo "")))
          ("h" "At home" tags-todo "@home"
           ((org-agenda-overriding-header "Home")
            (org-agenda-skip-function #'my-org-agenda-skip-all-siblings-but-first)))
          ("w" "At work" tags-todo "@work"
           ((org-agenda-overriding-header "Work")
            (org-agenda-skip-function #'my-org-agenda-skip-all-siblings-but-first)))
          ("t" "On the road" tags-todo "@travelling"
           ((org-agenda-overriding-header "Travelling")
            (org-agenda-skip-function #'my-org-agenda-skip-all-siblings-but-first)))
          ("p" "Phone call" tags-todo "@phone"
           ((org-agenda-overriding-header "Phone")
            (org-agenda-skip-function #'my-org-agenda-skip-all-siblings-but-first)))
          ("m" "In email" tags-todo "@email"
           ((org-agenda-overriding-header "Email")
            (org-agenda-skip-function #'my-org-agenda-skip-all-siblings-but-first)))
          ("e" "Running errands" tags-todo "@errands"
           ((org-agenda-overriding-header "Errands")
            (org-agenda-skip-function #'my-org-agenda-skip-all-siblings-but-first)))
          ("E" "With Elena" tags-todo "Elena"
           ((org-agenda-overriding-header "Elena")
            (org-agenda-skip-function #'my-org-agenda-skip-all-siblings-but-first)))
          ("F" "With Fritz" tags-todo "Fritz"
           ((org-agenda-overriding-header "Fritz")
            (org-agenda-skip-function #'my-org-agenda-skip-all-siblings-but-first))))))

;; (after! org
;;   (defun my-org-agenda-skip-all-siblings-but-first ()
;;     "Skip all but the first non-done entry."
;;     (let (should-skip-entry)
;;       (unless (org-current-is-todo)
;;         (setq should-skip-entry t))
;;       (save-excursion
;;         (while (and (not should-skip-entry) (org-goto-sibling t))
;;           (when (org-current-is-todo)
;;             (setq should-skip-entry t))))
;;       (when should-skip-entry
;;         (or (outline-next-heading)
;;             (goto-char (point-max)))))))

;; (after! org
;;   (defun org-current-is-todo ()
;;     (or (string= "TODO" (org-get-todo-state))
;;         (string= "IDEA" (org-get-todo-state))
;;         (string= "[ ]" (org-get-todo-state)))))


;;
;;; Language customizations


;;
;;; Transient fix?
;; (setq package-install-upgrade-built-in t)


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
