;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Configuration Layers declaration."
  (setq-default
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (ie. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()
   ;; List of configuration layers to load. If it is the symbol `all' instead
   ;; of a list then all discovered layers will be installed.
   dotspacemacs-configuration-layers
   '(
     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press <SPC f e R> (Vim style) or
     ;; <M-m f e R> (Emacs style) to install them.
     ;; ----------------------------------------------------------------
     ansible
     auto-completion
     ;; better-defaults
     dash
     dockerfile
     emacs-lisp
     git
     go
     html
     ;; (git :variables
     ;;      git-gutter-use-fringe t)
     javascript
     markdown
     ;; org
     osx
     pandoc
     php
     react
     ruby
     ruby-on-rails
     shell
     syntax-checking
     themes-megapack
     typescript
     vagrant
     windows-scripts
     )
   ;; List of additional packages that will be installed wihout being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages then consider to create a layer, you can also put the
   ;; configuration in `dotspacemacs/config'.
   dotspacemacs-additional-packages '()
   ;; A list of packages and/or extensions that will not be install and loaded.
   dotspacemacs-excluded-packages '()
   ;; If non-nil spacemacs will delete any orphan packages, i.e. packages that
   ;; are declared in a layer which is not a member of
   ;; the list `dotspacemacs-configuration-layers'
   dotspacemacs-delete-orphan-packages t))

(defun dotspacemacs/init ()
  "Initialization function.
This function is called at the very startup of Spacemacs initialization
before layers configuration."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; Either `vim' or `emacs'. Evil is always enabled but if the variable
   ;; is `emacs' then the `holy-mode' is enabled at startup.
   dotspacemacs-editing-style 'vim
   ;; If non nil output loading progress in `*Messages*' buffer.
   dotspacemacs-verbose-loading nil
   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed.
   dotspacemacs-startup-banner 'official
   ;; List of items to show in the startup buffer. If nil it is disabled.
   ;; Possible values are: `recents' `bookmarks' `projects'."
   dotspacemacs-startup-lists '(recents projects)
   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press <SPC> T n to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(monokai
                         solarized-light
                         solarized-dark
                         leuven
                         zenburn)
   ;; If non nil the cursor color matches the state color.
   dotspacemacs-colorize-cursor-according-to-state t
   ;; Default font. `powerline-scale' allows to quickly tweak the mode-line
   ;; size to make separators look not too crappy.
   dotspacemacs-default-font '("Source Code Pro"
                               :size 13
                               :weight normal
                               :width normal
                               :powerline-scale 1.1)
   ;; The leader key
   dotspacemacs-leader-key "SPC"
   ;; The leader key accessible in `emacs state' and `insert state'
   dotspacemacs-emacs-leader-key "M-m"
   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it.
   dotspacemacs-major-mode-leader-key ","
   ;; Major mode leader key accessible in `emacs state' and `insert state'
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   ;; The command key used for Evil commands (ex-commands) and
   ;; Emacs commands (M-x).
   ;; By default the command key is `:' so ex-commands are executed like in Vim
   ;; with `:' and Emacs commands are executed with `<leader> :'.
   dotspacemacs-command-key ":"
   ;; If non nil then `ido' replaces `helm' for some commands. For now only
   ;; `find-files' (SPC f f) is replaced.
   dotspacemacs-use-ido nil
   ;; If non nil the paste micro-state is enabled. When enabled pressing `p`
   ;; several times cycle between the kill ring content.
   dotspacemacs-enable-paste-micro-state nil
   ;; Guide-key delay in seconds. The Guide-key is the popup buffer listing
   ;; the commands bound to the current keystrokes.
   dotspacemacs-guide-key-delay 0.4
   ;; If non nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil ;; to boost the loading time.
   dotspacemacs-loading-progress-bar t
   ;; If non nil the frame is fullscreen when Emacs starts up.
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil
   ;; If non nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX."
   dotspacemacs-fullscreen-use-non-native nil
   ;; If non nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup nil
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'.
   dotspacemacs-active-transparency 90
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'.
   dotspacemacs-inactive-transparency 90
   ;; If non nil unicode symbols are displayed in the mode line.
   dotspacemacs-mode-line-unicode-symbols t
   ;; If non nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters the
   ;; point when it reaches the top or bottom of the screen.
   dotspacemacs-smooth-scrolling t
   ;; If non-nil smartparens-strict-mode will be enabled in programming modes.
   dotspacemacs-smartparens-strict-mode nil
   ;; Select a scope to highlight delimiters. Possible value is `all',
   ;; `current' or `nil'. Default is `all'
   dotspacemacs-highlight-delimiters 'all
   ;; If non nil advises quit functions to keep server open when quitting.
   dotspacemacs-persistent-server nil
   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `ag', `pt', `ack' and `grep'.
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   ;; The default package repository used if no explicit repository has been
   ;; specified with an installed package.
   ;; Not used for now.
   dotspacemacs-default-package-repository nil
   )
  ;; User initialization goes here

   ;; Indentation from
   ;; http://blog.binchen.org/posts/easy-indentation-setup-in-emacs-for-web-development.html
   (defun my-setup-indent (n)
    ;; web development
    (setq coffee-tab-width n) ; coffeescript
    (setq javascript-indent-level n) ; javascript-mode
    (setq js-indent-level n) ; js-mode
    (setq js2-basic-offset n) ; js2-mode
    (setq web-mode-markup-indent-offset n) ; web-mode, html tag in html file
    (setq web-mode-css-indent-offset n) ; web-mode, css in html file
    (setq web-mode-code-indent-offset n) ; web-mode, js code in html file
    (setq css-indent-offset n) ; css-mode
    )

   (defun four-step ()
    (interactive)
    (message "Indentation set to four")
    ;; (setq indent-tabs-mode t) ; use tab instead of space
    (setq indent-tabs-mode nil) ; use space instead of tab
    (my-setup-indent 4) ; indent 4 spaces width
   )

   (defun two-step ()
    (interactive)
    (message "Indentation set to two")
    (setq indent-tabs-mode nil) ; use space instead of tab
    (my-setup-indent 2) ; indent 2 spaces width
   )

   ;; call indentation
   (two-step)
  )

(defun dotspacemacs/config ()
  "Configuration function.
 This function is called at the very end of Spacemacs initialization after
layers configuration."

  ;; 2-space indent
  (setq-default indent-tabs-mode nil)
  (setq-default tab-width 2)

  (setq js2-basic-offset 2)
  (setq js2-use-font-lock-faces t)

  (setq paradox-github-token "c37f3aab17e98806cff2d2766d864e2f69273828")
  (global-evil-matchit-mode 1)
  (setq tern-command '("tern" "--no-port-file"))
  (setq-default ruby-enable-ruby-on-rails-support t)

  ;; Enable mouse support
  (unless window-system
    (global-set-key (kbd "<mouse-4>") 'scroll-down-line)
    (global-set-key (kbd "<mouse-5>") 'scroll-up-line))
)

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (org goto-chg undo-tree diminish uuidgen toc-org tide typescript-mode osx-dictionary org-plus-contrib org-bullets livid-mode skewer-mode simple-httpd link-hint jinja2-mode git-link eyebrowse evil-visual-mark-mode evil-unimpaired evil-ediff eshell-z dumb-jump darkokai-theme column-enforce-mode pcre2el spinner multiple-cursors parent-mode request haml-mode gitignore-mode pkg-info epl flx iedit highlight web-completion-data dash-functional pos-tip go-mode inf-ruby s popup bind-key bind-map tern anzu company js2-mode hydra f auto-complete evil tss yaxception log4e reveal-in-osx-finder pbcopy osx-trash launchctl xterm-color window-numbering spacemacs-theme spaceline projectile-rails rake phpunit persp-mode pandoc-mode orgit organic-green-theme omtose-phellack-theme neotree moe-theme magit-gitflow leuven-theme json-mode hl-todo helm-projectile helm-make helm-descbinds helm-dash helm-ag git-messenger feature-mode exec-path-from-shell evil-mc evil-exchange eshell-prompt-extras color-theme-sanityinc-tomorrow coffee-mode bundler auto-yasnippet auto-compile ace-link avy smartparens magit magit-popup flycheck with-editor helm helm-core markdown-mode ht yasnippet php-mode dash quelpa package-build monokai-theme zonokai-theme zenburn-theme zen-and-art-theme yaml-mode ws-butler which-key web-mode web-beautify volatile-highlights vi-tilde-fringe vagrant-tramp vagrant use-package underwater-theme ujelly-theme twilight-theme twilight-bright-theme twilight-anti-bright-theme tronesque-theme toxi-theme tao-theme tangotango-theme tango-plus-theme tango-2-theme tagedit sunny-day-theme sublime-themes subatomic256-theme subatomic-theme stekene-theme spacegray-theme soothe-theme soft-stone-theme soft-morning-theme soft-charcoal-theme smyx-theme smooth-scrolling smeargle slim-mode shell-pop seti-theme scss-mode sass-mode rvm ruby-tools ruby-test-mode rubocop rspec-mode robe reverse-theme restart-emacs rbenv rainbow-delimiters railscasts-theme purple-haze-theme projectile professional-theme powershell powerline popwin planet-theme phpcbf php-extras php-auto-yasnippets phoenix-dark-pink-theme phoenix-dark-mono-theme pastels-on-dark-theme paradox page-break-lines packed ox-pandoc open-junk-file oldlace-theme occidental-theme obsidian-theme noctilux-theme niflheim-theme naquadah-theme mustang-theme multi-term move-text monochrome-theme molokai-theme mmm-mode minimal-theme material-theme markdown-toc majapahit-theme macrostep lush-theme lorem-ipsum linum-relative light-soap-theme less-css-mode json-snatcher json-reformat js2-refactor js-doc jbeans-theme jazz-theme jade-mode ir-black-theme inkpot-theme info+ inflections indent-guide ido-vertical-mode hungry-delete highlight-parentheses highlight-numbers highlight-indentation heroku-theme hemisu-theme help-fns+ helm-themes helm-swoop helm-mode-manager helm-gitignore helm-flx helm-css-scss helm-company helm-c-yasnippet hc-zenburn-theme gruvbox-theme gruber-darker-theme grandshell-theme gotham-theme google-translate golden-ratio go-eldoc gitconfig-mode gitattributes-mode git-timemachine git-commit gh-md gandalf-theme flycheck-pos-tip flx-ido flatui-theme flatland-theme firebelly-theme fill-column-indicator farmhouse-theme fancy-battery expand-region evil-visualstar evil-tutor evil-surround evil-search-highlight-persist evil-numbers evil-nerd-commenter evil-matchit evil-magit evil-lisp-state evil-indent-plus evil-iedit-state evil-escape evil-args evil-anzu eval-sexp-fu espresso-theme esh-help emmet-mode elisp-slime-nav drupal-mode dracula-theme dockerfile-mode django-theme define-word dash-at-point darktooth-theme darkmine-theme darkburn-theme dakrone-theme cyberpunk-theme company-web company-tern company-statistics company-quickhelp company-go colorsarenice-theme color-theme-sanityinc-solarized clues-theme clean-aindent-mode chruby cherry-blossom-theme busybee-theme buffer-move bubbleberry-theme bracketed-paste birds-of-paradise-plus-theme badwolf-theme auto-highlight-symbol async apropospriate-theme anti-zenburn-theme ansible-doc ansible ample-zen-theme ample-theme alect-themes aggressive-indent afternoon-theme adaptive-wrap ace-window ace-jump-helm-line ac-ispell))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
