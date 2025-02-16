;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "FiveArms"
      user-mail-address "me@fivearms.page")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;;; UI

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
;; (setq doom-theme 'doom-one)
(setq doom-theme 'tsdh-dark)
;; (setq doom-theme 'doom-badger)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type nil)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;;; Keybinds

;; (map! (:after evil-org
;;        :map evil-org-mode-map
;;        :n "gk" (cmd! (if (org-at-heading-p)
;;                          (org-backward-element)
;;                        (evil-previous-visual-line)))
;;        :n "gj" (cmd! (if (org-at-heading-p)
;;                          (org-forward-element)
;;                        (evil-next-visual-line))))

;;       :o "o" #'evil-inner-symbol)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;;; Modules

;; This section is modeled off the doom config file and helps organize
;; per-module configurations.

;;; :input
;; bidi
;; chinese
;; japanese
;; layout

;;; :completion
;; company
;; Disable completion in text and org modes
;; (setq company-global-modes '(not text-mode org-mode))
;; corfu
;; helm
;; ido
;; ivy
;; vertico

;;; :ui
;; deft
;; doom
;; doom-dashboard
;; doom-quit
;; emoji
;; hl-todo
;; indent guides
;; ligatures
;; minimap
;; modeline
;; nav-flash
;; neotree
;; ophints
;; popup
;; tabs
;; treemacs
;; unicode
;; vc-gutter
;; vi-tilde-fringe
;; window-select
;; workspaces
;; zen

;;; :editor
;; evil
;; Focus new window after splitting
(setq evil-split-window-below t
      evil-vsplit-window-right t)

;; file-templates
;; fold
;; format
;; god
;; lispy
;; multiple-cursors
;; objed
;; parinfer
;; rotate-text
;; snippets
;; word-wrap

;; Change easy-motion jump targets for Colemak keyboard layout
(setq avy-keys '(?a ?r ?s ?t ?h ?n ?e ?i ?o))

;;; :emacs
;; dired
;; electric
;; eww
;; ibuffer
;; undo
;; vc

;;; :term
;; eshell
;; shell
;; term
;; vterm

;;; :checkers
;; syntax
;; spell
;; Slow down spellchecking
;; idle defaults to 1s, and window defaults to 3
(after! flyspell
  (setq flyspell-lazy-idle-seconds 2)
  (setq flyspell-lazy-window-idle-seconds 30))

;; grammar

;;; :tools
;; ansible
;; biblio
(after! citar
  (setq! citar-bibliography '("~/bib/biblio.bib"))
  (setq! citar-library-paths '("~/bib/lib/files"))
  (setq! citar-notes-paths '("~/bib/notes")))

;; collab
;; debugger
;; direnv
;; docker
;; editorconfig
;; ein
;; eval
;; lookup
;; lsp
;; magit
(setq transient-values '((magit-rebase "--autosquash" "--autostash")
                         (magit-pull "--rebase" "--autostash")
                         (magit-revert "--autostash")))
;; make
;; pass
;; pdf
;; prodigy
;; terraform
;; tmux
;; tree-sitter
;; upload

;;; :os
;; macos
;; tty

;;; :lang
;; agda
;; beancount
;; cc
;; clojure
;; common-lisp
;; coq
;; crystal
;; csharp
;; data
;; dart
;; dhall
;; elixir
;; elm
;; emacs-lisp
;; erlang
;; ess
;; factor
;; faust
;; fortran
;; fsharp
;; fstar
;; gdscript
;; go
;; graphql
;; haskell
;; hy
;; idris
;; json
;; java
;; javascript
;; julia
;; kotlin
;; latex
;; lean
;; ledger
;; lua
;; markdown
;; pandoc-mode - auto-start; use defaults
;; NOTE Requires calling '(package! pandoc-mode)' in 'packages.el'
;; (add-hook 'markdown-mode-hook 'pandoc-mode)
;; (add-hook 'pandoc-mode-hook 'pandoc-load-default-settings)

;; nim
;; nix
;; ocaml
;; org
;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
;; (setq org-directory "~/org/")

(setq org-directory  "~/org-reinisch-glob/org/"
      org-archive-location (concat org-directory ".archive/%s::")
      org-agenda-files (list org-directory))

(after! org
  (setq org-startup-folded 'show2levels
        org-ellipsis " [...] "
        org-tags-column -77
        org-log-into-drawer t
        org-todo-repeat-to-state t))

(after! org
  (setq org-cite-global-bibliography '("~/bib/biblio.bib")))

(after! org
  (setq org-id-link-to-org-use-id 'create-if-interactive-and-no-custom-id))
  ;; (setq org-id-method 'ts)

;; automatically set tags on todo state changes
(after! org
  (setq org-todo-state-tags-triggers
      (quote (("KILL" ("KILL" . t))
              ("WAIT" ("WAIT" . t))
              ("HOLD" ("WAIT") ("HOLD" . t))
              ("PROJ" ("WAIT") ("HOLD") ("PROJ" . t))
              (done ("WAIT") ("HOLD"))
              ("TODO" ("WAIT") ("KILL") ("HOLD"))
              ("STRT" ("WAIT") ("KILL") ("HOLD"))
              ("DONE" ("WAIT") ("KILL") ("HOLD") ("PROJ"))))))

;; redefine "stuck" projects
(after! org
  (setq org-stuck-projects '("/!PROJ" ("STRT") nil "\\<IGNORE\\>")))

;; Custom org agenda commands and helper functions
(after! org
  (setq org-agenda-custom-commands
        '(("n" "Agenda and all TODOs" ((agenda "") (alltodo "")))
          ("W" . "Where Tags") ;; creates 'Where Tags' submenu
          ("Wh" "At home" tags-todo "@home"
           ((org-agenda-overriding-header "Home")
            (org-agenda-skip-function #'my-org-agenda-skip-all-siblings-but-first)))
          ("Ww" "At work" tags-todo "@work"
           ((org-agenda-overriding-header "Work")
            (org-agenda-skip-function #'my-org-agenda-skip-all-siblings-but-first)))
          ("Wr" "On the road" tags-todo "@travelling"
           ((org-agenda-overriding-header "Travelling")
            (org-agenda-skip-function #'my-org-agenda-skip-all-siblings-but-first)))
          ("Wp" "Phone call" tags-todo "@phone"
           ((org-agenda-overriding-header "Phone")
            (org-agenda-skip-function #'my-org-agenda-skip-all-siblings-but-first)))
          ("Wc" "Correspondence" tags-todo "@email"
           ((org-agenda-overriding-header "Email")
            (org-agenda-skip-function #'my-org-agenda-skip-all-siblings-but-first)))
          ("Wo" "Out & about" tags-todo "@errands"
           ((org-agenda-overriding-header "Errands")
            (org-agenda-skip-function #'my-org-agenda-skip-all-siblings-but-first)))
          ("WE" "With Elena" tags-todo "Elena"
           ((org-agenda-overriding-header "Elena")
            (org-agenda-skip-function #'my-org-agenda-skip-all-siblings-but-first)))
          ("WF" "With Fritz" tags-todo "Fritz"
           ((org-agenda-overriding-header "Fritz")
            (org-agenda-skip-function #'my-org-agenda-skip-all-siblings-but-first)))

          ("q" "Daily Block Agenda"
           ((agenda ""
                    ((org-agenda-span 'day)
                     (org-agenda-start-on-weekday nil)
                     (org-agenda-start-day nil)))
            (tags-todo "REFILE"
                    ((org-agenda-overriding-header "Tasks to Refile")
                     (org-tags-match-list-sublevels nil)))
            (stuck ""
                   ((org-agenda-overriding-header "Stuck Projects")))
            (tags-todo "/!PROJ"
                       ((org-agenda-overriding-header "Projects")
                        (org-agenda-skip-function
                         '(org-agenda-skip-subtree-if 'nottodo '("STRT")))
                        (org-tags-match-list-sublevels 'indented)
                        (org-agenda-sorting-strategy '(category-keep))))
            (tags-todo "+PROJ-KILL/!STRT"
                ((org-agenda-overriding-header "Project Next Tasks")
                 (org-tags-match-list-sublevels 'indented)
                 (org-agenda-sorting-strategy
                  '(todo-state-down effort-up category-keep))))
            (tags-todo "-PROJ-KILL-WAIT-HOLD/!-IDEA-LOOP-KILL-WAIT-HOLD"
                       ((org-agenda-overriding-header "Standalone Tasks")
                        (org-agenda-skip-function
                         '(org-agenda-skip-entry-if 'timestamp))
                        (org-agenda-sorting-strategy '(category-keep))))
            (tags-todo "-KILL+WAIT|HOLD/!"
                       ((org-agenda-overriding-header "Waiting & Postponed Tasks")
                        (org-tags-match-list-sublevels nil)))
            (tags "-REFILE+TODO=\"DONE\"&CLOSED<=*\"<-5y>\"
                                        |SCHEDULED<=*\"<-5y>\"
                                        |DEADLINE<=*\"<-5y>\""
                  ((org-agenda-overriding-header "Tasks to Archive")))
            ))
          (" " "Block Agenda"
           ((agenda "" nil)
            (tags-todo "-HOLD-KILL/!+PROJ"
                       ((org-agenda-overriding-header "My PROJ")
                        ;; (org-agenda-skip-entry-if 'timestamp)
                        (org-agenda-skip-function
                         '(org-agenda-skip-subtree-if 'nottodo '("STRT")))
                        (org-tags-match-list-sublevels 'indented)
                        (org-agenda-sorting-strategy '(category-keep))))
            (tags "REFILE"
                  ((org-agenda-overriding-header "Tasks to Refile")
                   (org-tags-match-list-sublevels nil)))
            (tags-todo "-KILL/!+PROJ"
                       ((org-agenda-overriding-header "Stuck Projects")
                        ;; (org-agenda-skip-function 'SKIP-NON-PROJECTS)
                        (org-agenda-sorting-strategy '(category-keep))))
            (tags-todo "-HOLD-KILL/!"
                       ((org-agenda-overriding-header "Projects")
                        ;; (org-agenda-skip-function 'SKIP-NON-PROJECTS)
                        (org-tags-match-list-sublevels 'indented)
                        (org-agenda-sorting-strategy '(category-keep))))
            (tags-todo "-KILL/!NEXT"
                       ((org-agenda-overriding-header "Project Next Tasks")
                        ;; SKIP PROJECTS AND HABITS AND SINGLE TASKS
                        (org-tags-match-list-sublevels t)
                        ;; HIDE SCHEDULED AND WAITING NEXT TASKS
                        (org-agenda-sorting-strategy '(todo-state-down effort-up category-keep))))
            (tags-todo "-REFILE/"
                       ((org-agenda-overriding-header "Tasks to Archive")
                        (org-tags-match-list-sublevels nil))))
           nil))))

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

;; php
;; plantuml
;; graphviz
;; purescript
;; python
;; qt
;; racket
;; raku
;; rest
;; rst
;; ruby
;; rust
;; scala
;; (scheme +guile)
;; (sh +tree-sitter)
;; sml
;; solidity
;; swift
;; terra
;; (web +tree-sitter)
;; (yaml +tree-sitter)
;; zig

;;; :email
;; mu4e
;; notmuch
;; wanderlust

;;; :app
;; calendar
;; emms
;; everywhere
;; irc
;; rss

;;; :config
;; literate
;; default


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;;; Language customizations


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Transient fix?
;; (setq package-install-upgrade-built-in t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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
