;; -*- mode: emacs-lisp; lexical-binding: t -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.


(defun dotspacemacs/layers ()
  "Layer configuration:
This function should only modify configuration layer settings."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs

   ;; Lazy installation of layers (i.e. layers are installed only when a file
   ;; with a supported type is opened). Possible values are `all', `unused'
   ;; and `nil'. `unused' will lazy install only unused layers (i.e. layers
   ;; not listed in variable `dotspacemacs-configuration-layers'), `all' will
   ;; lazy install any layer that support lazy installation even the layers
   ;; listed in `dotspacemacs-configuration-layers'. `nil' disable the lazy
   ;; installation feature and you have to explicitly list a layer in the
   ;; variable `dotspacemacs-configuration-layers' to install it.
   ;; (default 'unused)
   dotspacemacs-enable-lazy-installation 'unused

   ;; If non-nil then Spacemacs will ask for confirmation before installing
   ;; a layer lazily. (default t)
   dotspacemacs-ask-for-lazy-installation t

   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()

   ;; List of configuration layers to load.
   dotspacemacs-configuration-layers
   '(lua
     systemd
     javascript
     html
     python
     csv
     markdown
     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press `SPC f e R' (Vim style) or
     ;; `M-m f e R' (Emacs style) to install them.
     ;; ----------------------------------------------------------------
     ;; auto-completion
     ;; better-defaults
     emacs-lisp
     git
     ;;helm
     ivy
     lsp
     (python :variables
             python-backend 'lsp)
     (c-c++ :variables
            c-c++-backend 'lsp-clangd)
     ;; markdown
     multiple-cursors
     ;;org
     ;; (shell :variables
     ;;        shell-default-height 30
     ;;        shell-default-position 'bottom)
     ;;spell-checking
     syntax-checking
     ;; version-control
     treemacs)


   ;; List of additional packages that will be installed without being wrapped
   ;; in a layer (generally the packages are installed only and should still be
   ;; loaded using load/require/use-package in the user-config section below in
   ;; this file). If you need some configuration for these packages, then
   ;; consider creating a layer. You can also put the configuration in
   ;; `dotspacemacs/user-config'. To use a local version of a package, use the
   ;; `:location' property: '(your-package :location "~/path/to/your-package/")
   ;; Also include the dependencies as they will not be resolved automatically.
   dotspacemacs-additional-packages '(org-contrib org-pdftools org-bullets visual-fill-column jupyter cuda-mode nov djvu quelpa flycheck-cask flycheck-cstyle dockerfile-mode sqlite3)


   ;; A list of packages that cannot be updated.
   dotspacemacs-frozen-packages '()

   ;; A list of packages that will not be installed and loaded.
   dotspacemacs-excluded-packages '()

   ;; Defines the behaviour of Spacemacs when installing packages.
   ;; Possible values are `used-only', `used-but-keep-unused' and `all'.
   ;; `used-only' installs only explicitly used packages and deletes any unused
   ;; packages as well as their unused dependencies. `used-but-keep-unused'
   ;; installs only the used packages but won't delete unused ones. `all'
   ;; installs *all* packages supported by Spacemacs and never uninstalls them.
   ;; (default is `used-only')
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  "Initialization:
This function is called at the very beginning of Spacemacs startup,
before layer configuration.
It should only modify the values of Spacemacs settings."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non-nil then enable support for the portable dumper. You'll need to
   ;; compile Emacs 27 from source following the instructions in file
   ;; EXPERIMENTAL.org at to root of the git repository.
   ;;
   ;; WARNING: pdumper does not work with Native Compilation, so it's disabled
   ;; regardless of the following setting when native compilation is in effect.
   ;;
   ;; (default nil)
   dotspacemacs-enable-emacs-pdumper nil

   ;; Name of executable file pointing to emacs 27+. This executable must be
   ;; in your PATH.
   ;; (default "emacs")
   dotspacemacs-emacs-pdumper-executable-file "emacs"

   ;; Name of the Spacemacs dump file. This is the file will be created by the
   ;; portable dumper in the cache directory under dumps sub-directory.
   ;; To load it when starting Emacs add the parameter `--dump-file'
   ;; when invoking Emacs 27.1 executable on the command line, for instance:
   ;;   ./emacs --dump-file=$HOME/.emacs.d/.cache/dumps/spacemacs-27.1.pdmp
   ;; (default (format "spacemacs-%s.pdmp" emacs-version))
   dotspacemacs-emacs-dumper-dump-file (format "spacemacs-%s.pdmp" emacs-version)

   ;; If non-nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t

   ;; Maximum allowed time in seconds to contact an ELPA repository.
   ;; (default 5)
   dotspacemacs-elpa-timeout 5

   ;; Set `gc-cons-threshold' and `gc-cons-percentage' when startup finishes.
   ;; This is an advanced option and should not be changed unless you suspect
   ;; performance issues due to garbage collection operations.
   ;; (default '(100000000 0.1))
   dotspacemacs-gc-cons '(100000000 0.1)

   ;; Set `read-process-output-max' when startup finishes.
   ;; This defines how much data is read from a foreign process.
   ;; Setting this >= 1 MB should increase performance for lsp servers
   ;; in emacs 27.
   ;; (default (* 1024 1024))
   dotspacemacs-read-process-output-max (* 1024 1024)

   ;; If non-nil then Spacelpa repository is the primary source to install
   ;; a locked version of packages. If nil then Spacemacs will install the
   ;; latest version of packages from MELPA. Spacelpa is currently in
   ;; experimental state please use only for testing purposes.
   ;; (default nil)
   dotspacemacs-use-spacelpa nil

   ;; If non-nil then verify the signature for downloaded Spacelpa archives.
   ;; (default t)
   dotspacemacs-verify-spacelpa-archives t

   ;; If non-nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. Note that checking for
   ;; new versions works via git commands, thus it calls GitHub services
   ;; whenever you start Emacs. (default nil)
   dotspacemacs-check-for-update nil

   ;; If non-nil, a form that evaluates to a package directory. For example, to
   ;; use different package directories for different Emacs versions, set this
   ;; to `emacs-version'. (default 'emacs-version)
   dotspacemacs-elpa-subdirectory 'emacs-version

   ;; One of `vim', `emacs' or `hybrid'.
   ;; `hybrid' is like `vim' except that `insert state' is replaced by the
   ;; `hybrid state' with `emacs' key bindings. The value can also be a list
   ;; with `:variables' keyword (similar to layers). Check the editing styles
   ;; section of the documentation for details on available variables.
   ;; (default 'vim)
   dotspacemacs-editing-style 'vim

   ;; If non-nil show the version string in the Spacemacs buffer. It will
   ;; appear as (spacemacs version)@(emacs version)
   ;; (default t)
   dotspacemacs-startup-buffer-show-version t

   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner 'official

   ;; Scale factor controls the scaling (size) of the startup banner. Default
   ;; value is `auto' for scaling the logo automatically to fit all buffer
   ;; contents, to a maximum of the full image height and a minimum of 3 line
   ;; heights. If set to a number (int or float) it is used as a constant
   ;; scaling factor for the default logo size.
   dotspacemacs-startup-banner-scale 'auto

   ;; List of items to show in startup buffer or an association list of
   ;; the form `(list-type . list-size)`. If nil then it is disabled.
   ;; Possible values for list-type are:
   ;; `recents' `recents-by-project' `bookmarks' `projects' `agenda' `todos'.
   ;; List sizes may be nil, in which case
   ;; `spacemacs-buffer-startup-lists-length' takes effect.
   ;; The exceptional case is `recents-by-project', where list-type must be a
   ;; pair of numbers, e.g. `(recents-by-project . (7 .  5))', where the first
   ;; number is the project limit and the second the limit on the recent files
   ;; within a project.
   dotspacemacs-startup-lists '((recents . 5)
                                (projects . 7))

   ;; True if the home buffer should respond to resize events. (default t)
   dotspacemacs-startup-buffer-responsive t

   ;; Show numbers before the startup list lines. (default t)
   dotspacemacs-show-startup-list-numbers t

   ;; The minimum delay in seconds between number key presses. (default 0.4)
   dotspacemacs-startup-buffer-multi-digit-delay 0.4

   ;; If non-nil, show file icons for entries and headings on Spacemacs home buffer.
   ;; This has no effect in terminal or if "all-the-icons" package or the font
   ;; is not installed. (default nil)
   dotspacemacs-startup-buffer-show-icons nil

   ;; Default major mode for a new empty buffer. Possible values are mode
   ;; names such as `text-mode'; and `nil' to use Fundamental mode.
   ;; (default `text-mode')
   dotspacemacs-new-empty-buffer-major-mode 'text-mode

   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'text-mode

   ;; If non-nil, *scratch* buffer will be persistent. Things you write down in
   ;; *scratch* buffer will be saved and restored automatically.
   dotspacemacs-scratch-buffer-persistent nil

   ;; If non-nil, `kill-buffer' on *scratch* buffer
   ;; will bury it instead of killing.
   dotspacemacs-scratch-buffer-unkillable nil

   ;; Initial message in the scratch buffer, such as "Welcome to Spacemacs!"
   ;; (default nil)
   dotspacemacs-initial-scratch-message nil

   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press `SPC T n' to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(doom-tomorrow-night
                         spacemacs-dark
                         spacemacs-light)

   ;; Set the theme for the Spaceline. Supported themes are `spacemacs',
   ;; `all-the-icons', `custom', `doom', `vim-powerline' and `vanilla'. The
   ;; first three are spaceline themes. `doom' is the doom-emacs mode-line.
   ;; `vanilla' is default Emacs mode-line. `custom' is a user defined themes,
   ;; refer to the DOCUMENTATION.org for more info on how to create your own
   ;; spaceline theme. Value can be a symbol or list with additional properties.
   ;; (default '(spacemacs :separator wave :separator-scale 1.5))
   dotspacemacs-mode-line-theme '(spacemacs :separator wave :separator-scale 1.5)

   ;; If non-nil the cursor color matches the state color in GUI Emacs.
   ;; (default t)
   dotspacemacs-colorize-cursor-according-to-state nil

   ;; Default font or prioritized list of fonts. The `:size' can be specified as
   ;; a non-negative integer (pixel size), or a floating-point (point size).
   ;; Point size is recommended, because it's device independent. (default 10.0)
   ;; dotspacemacs-default-font '("Source Code Pro"
   ;;                             :size 12.0
   ;;                             :weight normal
   ;;                             :width normal)

   dotspacemacs-default-font '("Fira Code Retina"
                               :size 12.0
                               :weight normal
                               :width normal)
   ;; The leader key (default "SPC")
   dotspacemacs-leader-key "SPC"

   ;; The key used for Emacs commands `M-x' (after pressing on the leader key).
   ;; (default "SPC")
   dotspacemacs-emacs-command-key "SPC"

   ;; The key used for Vim Ex commands (default ":")
   dotspacemacs-ex-command-key ":"

   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"

   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","

   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m" for terminal mode, "<M-return>" for GUI mode).
   ;; Thus M-RET should work as leader key in both GUI and terminal modes.
   ;; C-M-m also should work in terminal mode, but not in GUI mode.
   dotspacemacs-major-mode-emacs-leader-key (if window-system "<M-return>" "C-M-m")

   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs `C-i', `TAB' and `C-m', `RET'.
   ;; Setting it to a non-nil value, allows for separate commands under `C-i'
   ;; and TAB or `C-m' and `RET'.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil

   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"

   ;; If non-nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil

   ;; If non-nil then the last auto saved layouts are resumed automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil

   ;; If non-nil, auto-generate layout name when creating new layouts. Only has
   ;; effect when using the "jump to layout by number" commands. (default nil)
   dotspacemacs-auto-generate-layout-names nil

   ;; Size (in MB) above which spacemacs will prompt to open the large file
   ;; literally to avoid performance issues. Opening a file literally means that
   ;; no major mode or minor modes are active. (default is 1)
   dotspacemacs-large-file-size 1

   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache

   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5

   ;; If non-nil, the paste transient-state is enabled. While enabled, after you
   ;; paste something, pressing `C-j' and `C-k' several times cycles through the
   ;; elements in the `kill-ring'. (default nil)
   dotspacemacs-enable-paste-transient-state nil

   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4

   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom

   ;; Control where `switch-to-buffer' displays the buffer. If nil,
   ;; `switch-to-buffer' displays the buffer in the current window even if
   ;; another same-purpose window is available. If non-nil, `switch-to-buffer'
   ;; displays the buffer in a same-purpose window even if the buffer can be
   ;; displayed in the current window. (default nil)
   dotspacemacs-switch-to-buffer-prefers-purpose nil

   ;; If non-nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t

   ;; If non-nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil

   ;; If non-nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil

   ;; If non-nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default t) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup t

   ;; If non-nil the frame is undecorated when Emacs starts up. Combine this
   ;; variable with `dotspacemacs-maximized-at-startup' to obtain fullscreen
   ;; without external boxes. Also disables the internal border. (default nil)
   dotspacemacs-undecorated-at-startup nil

   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90

   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90

   ;; A value from the range (0..100), in increasing opacity, which describes the
   ;; transparency level of a frame background when it's active or selected. Transparency
   ;; can be toggled through `toggle-background-transparency'. (default 90)
   dotspacemacs-background-transparency 90

   ;; If non-nil show the titles of transient states. (default t)
   dotspacemacs-show-transient-state-title t

   ;; If non-nil show the color guide hint for transient state keys. (default t)
   dotspacemacs-show-transient-state-color-guide t

   ;; If non-nil unicode symbols are displayed in the mode line.
   ;; If you use Emacs as a daemon and wants unicode characters only in GUI set
   ;; the value to quoted `display-graphic-p'. (default t)
   dotspacemacs-mode-line-unicode-symbols t

   ;; If non-nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters point
   ;; when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t

   ;; Show the scroll bar while scrolling. The auto hide time can be configured
   ;; by setting this variable to a number. (default t)
   dotspacemacs-scroll-bar-while-scrolling t

   ;; Control line numbers activation.
   ;; If set to `t', `relative' or `visual' then line numbers are enabled in all
   ;; `prog-mode' and `text-mode' derivatives. If set to `relative', line
   ;; numbers are relative. If set to `visual', line numbers are also relative,
   ;; but only visual lines are counted. For example, folded lines will not be
   ;; counted and wrapped lines are counted as multiple lines.
   ;; This variable can also be set to a property list for finer control:
   ;; '(:relative nil
   ;;   :visual nil
   ;;   :disabled-for-modes dired-mode
   ;;                       doc-view-mode
   ;;                       markdown-mode
   ;;                       org-mode
   ;;                       pdf-view-mode
   ;;                       text-mode
   ;;   :size-limit-kb 1000)
   ;; When used in a plist, `visual' takes precedence over `relative'.
   ;; (default nil)
   dotspacemacs-line-numbers nil

   ;; Code folding method. Possible values are `evil', `origami' and `vimish'.
   ;; (default 'evil)
   dotspacemacs-folding-method 'evil

   ;; If non-nil and `dotspacemacs-activate-smartparens-mode' is also non-nil,
   ;; `smartparens-strict-mode' will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil

   ;; If non-nil smartparens-mode will be enabled in programming modes.
   ;; (default t)
   dotspacemacs-activate-smartparens-mode t

   ;; If non-nil pressing the closing parenthesis `)' key in insert mode passes
   ;; over any automatically added closing parenthesis, bracket, quote, etc...
   ;; This can be temporary disabled by pressing `C-q' before `)'. (default nil)
   dotspacemacs-smart-closing-parenthesis nil

   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all

   ;; If non-nil, start an Emacs server if one is not already running.
   ;; (default nil)
   dotspacemacs-enable-server nil

   ;; Set the emacs server socket location.
   ;; If nil, uses whatever the Emacs default is, otherwise a directory path
   ;; like \"~/.emacs.d/server\". It has no effect if
   ;; `dotspacemacs-enable-server' is nil.
   ;; (default nil)
   dotspacemacs-server-socket-dir nil

   ;; If non-nil, advise quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil

   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `rg', `ag', `pt', `ack' and `grep'.
   ;; (default '("rg" "ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("rg" "ag" "pt" "ack" "grep")

   ;; Format specification for setting the frame title.
   ;; %a - the `abbreviated-file-name', or `buffer-name'
   ;; %t - `projectile-project-name'
   ;; %I - `invocation-name'
   ;; %S - `system-name'
   ;; %U - contents of $USER
   ;; %b - buffer name
   ;; %f - visited file name
   ;; %F - frame name
   ;; %s - process status
   ;; %p - percent of buffer above top of window, or Top, Bot or All
   ;; %P - percent of buffer above bottom of window, perhaps plus Top, or Bot or All
   ;; %m - mode name
   ;; %n - Narrow if appropriate
   ;; %z - mnemonics of buffer, terminal, and keyboard coding systems
   ;; %Z - like %z, but including the end-of-line format
   ;; If nil then Spacemacs uses default `frame-title-format' to avoid
   ;; performance issues, instead of calculating the frame title by
   ;; `spacemacs/title-prepare' all the time.
   ;; (default "%I@%S")
   dotspacemacs-frame-title-format "%I@%S"

   ;; Format specification for setting the icon title format
   ;; (default nil - same as frame-title-format)
   dotspacemacs-icon-title-format nil

   ;; Color highlight trailing whitespace in all prog-mode and text-mode derived
   ;; modes such as c++-mode, python-mode, emacs-lisp, html-mode, rst-mode etc.
   ;; (default t)
   dotspacemacs-show-trailing-whitespace t

   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed' to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup nil

   ;; If non-nil activate `clean-aindent-mode' which tries to correct
   ;; virtual indentation of simple modes. This can interfere with mode specific
   ;; indent handling like has been reported for `go-mode'.
   ;; If it does deactivate it here.
   ;; (default t)
   dotspacemacs-use-clean-aindent-mode t

   ;; Accept SPC as y for prompts if non-nil. (default nil)
   dotspacemacs-use-SPC-as-y nil

   ;; If non-nil shift your number row to match the entered keyboard layout
   ;; (only in insert state). Currently supported keyboard layouts are:
   ;; `qwerty-us', `qwertz-de' and `querty-ca-fr'.
   ;; New layouts can be added in `spacemacs-editing' layer.
   ;; (default nil)
   dotspacemacs-swap-number-row nil

   ;; Either nil or a number of seconds. If non-nil zone out after the specified
   ;; number of seconds. (default nil)
   dotspacemacs-zone-out-when-idle nil

   ;; Run `spacemacs/prettify-org-buffer' when
   ;; visiting README.org files of Spacemacs.
   ;; (default nil)
   dotspacemacs-pretty-docs t
   ;;dotspacemacs-pretty-docs nil

   ;; If nil the home buffer shows the full path of agenda items
   ;; and todos. If non-nil only the file name is shown.
   dotspacemacs-home-shorten-agenda-source nil

   ;; If non-nil then byte-compile some of Spacemacs files.
   dotspacemacs-byte-compile nil))

(defun dotspacemacs/user-env ()
  "Environment variables setup.
This function defines the environment variables for your Emacs session. By
default it calls `spacemacs/load-spacemacs-env' which loads the environment
variables declared in `~/.spacemacs.env' or `~/.spacemacs.d/.spacemacs.env'.
See the header of this file for more information."
  (spacemacs/load-spacemacs-env)
)

(defun dotspacemacs/user-init ()
  "Initialization for user code:
This function is called immediately after `dotspacemacs/init', before layer
configuration.
It is mostly for variables that should be set before packages are loaded.
If you are unsure, try setting them in `dotspacemacs/user-config' first."
  ;; (add-to-list 'configuration-layer--elpa-archives
  ;;              '("melpa" . "https://melpa.org/packages/") t)

  (defvar kito/default-font-size 160)
  (defvar kito/default-variable-font-size 160)
  (defvar kito/default-org-block-font-size 140)
  (defvar kito/default-org-code-font-size 120)
  (defvar kito/default-org-table-font-size 120)
)

(defun dotspacemacs/user-load ()
  "Library to load while dumping.
This function is called only while dumping Spacemacs configuration. You can
`require' or `load' the libraries of your choice that will be included in the
dump."
)

(defun dotspacemacs/user-config ()
  (require 'jupyter)
  (require 'org-contrib)
  (require 'org-pdftools)
  (require 'org-bullets)

  (require 'org-tempo)
  (require 'ox-latex)
  (require 'ox-beamer)
  (require 'visual-fill-column)
  (require 'dockerfile-mode)

  (set-frame-parameter (selected-frame) 'alpha '(85 85))
  (add-to-list 'default-frame-alist '(alpha 85 85))
  
  (use-package rainbow-delimiters
    :hook (prog-mode . rainbow-delimiters-mode))

  (dolist (mode '(org-mode-hook
                  term-mode-hook
                  shell-mode-hook
                  treemacs-mode-hook
                  eshell-mode-hook
                  pdf-view-mode-hook
                  doc-view-mode-hook))

    (add-hook mode (lambda () (display-line-numbers-mode 0))))

  (global-auto-revert-mode t)
  ;(auto-revert-use-notify nil)
  (setq revert-without-query '(".*"))

  ;;(set-face-attribute 'default nil :font "Fira Code Retina" :height kito/default-font-size)

  ;; Set the fixed pitch face
  (set-face-attribute 'fixed-pitch nil :font "Fira Code Retina" :height kito/default-font-size)

  ;; Set the variable pitch face
  (set-face-attribute 'variable-pitch nil :font "Cantarell" :height kito/default-variable-font-size :weight 'regular)

  ;;(setq default-frame-alist '((font . "Fira Code Retina")))

  (defun kito/org-font-setup ()
    ;; Replace list hyphen with dot
    (font-lock-add-keywords 'org-mode
                            '(("^ *\\([-]\\) "
                               (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

    ;; Set faces for heading levels
    (dolist (face '((org-level-1 . 1.5)
                    (org-level-2 . 1.2)
                    (org-level-3 . 1.05)
                    (org-level-4 . 1.0)
                    (org-level-5 . 1.1)
                    (org-level-6 . 1.1)
                    (org-level-7 . 1.1)
                    (org-level-8 . 1.1)))
      (set-face-attribute (car face) nil :font "Cantarell" :weight 'regular :height (cdr face)))

    ;; Ensure that anything that should be fixed-pitch in Org files appears that way
    ;; (set-face-attribute 'org-block nil :foreground nil :inherit 'fixed-pitch)
    ;; (set-face-attribute 'org-code nil   :inherit '(shadow fixed-pitch))
    ;; (set-face-attribute 'org-table nil   :inherit '(shadow fixed-pitch))
    ;; (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
    ;; (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
    ;; (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
    ;; (set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch))

    (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
    (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
    (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
    (set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch)
    (set-face-attribute 'org-block nil :font "Fira Code Retina" :height kito/default-org-block-font-size)
    (set-face-attribute 'org-table nil :font "Fira Code Retina" :height kito/default-org-table-font-size)
    (set-face-attribute 'org-code nil :font "Fira Code Retina" :height kito/default-org-code-font-size))

  (defun kito/org-mode-visual-fill ()
    (setq visual-fill-column-width 125
          visual-fill-column-center-text t)
    (add-hook 'visual-fill-column-mode-hook 'spacemacs/toggle-visual-line-navigation-on)
    (setq split-window-preferred-function 'visual-fill-column-split-window-sensibly)
    (advice-add 'text-scale-adjust :after 'visual-fill-column-adjust)
    (visual-fill-column-mode 1))

  (use-package visual-fill-column
    :hook (org-mode . kito/org-mode-visual-fill))

  (defun kito/org-mode-setup ()
    (org-indent-mode)
    (variable-pitch-mode 1)
    (setq org-list-indent-offset 8)
    (spacemacs/toggle-visual-line-navigation-on))

  (defun my/org-export-filter-todo-keywords (tree backend info)
    "Filter TODO keywords during export, moving them to the end of the line and surrounding them with brackets."
    (let ((keywords-to-keep '("TODO" "ACTIVE" "NEXT" "DONE" "CANC" "BACKLOG" "PLAN" "READY" "REVIEW" "WAIT" "RESEARCH" "REFINE"))
          (case-fold-search nil))
      (org-element-map tree 'headline
                       (lambda (headline)
                         (let ((keyword (org-element-property :todo-keyword headline))
                               (title (org-element-property :title headline)))
                           (when (and keyword (member keyword keywords-to-keep))
                             (org-element-put-property headline :todo-keyword nil)
                             (org-element-put-property headline :title (append title (list (format " [%s]" keyword))))))))
      tree))

  (add-hook 'org-export-filter-parse-tree-functions 'my/org-export-filter-todo-keywords)

  (defun archive-done-tasks-older-than-7-days ()
    (interactive)
    (org-map-entries
     (lambda ()
       (let* ((deadline (org-entry-get (point) "DEADLINE"))
              (deadline-date (when deadline
                               (org-time-string-to-time deadline)))
              (now (current-time))
              (seven-days-ago (- (time-to-days now) 7)))
         (when (and deadline-date
                    (time-less-p deadline-date (days-to-time seven-days-ago))
                    (org-entry-is-done-p))
           (org-archive-subtree)
           (setq org-map-continue-from (outline-previous-heading)))))
     nil 'agenda))

  (run-at-time "7 days" nil #'archive-done-tasks-older-than-7-days)

  (use-package org
    :ensure org-contrib
    :hook (org-mode . kito/org-mode-setup)
    :config
    (setq org-startup-indented t)
    (setq org-pretty-entities t)
    (setq org-hide-emphasis-markers t)
    (setq org-ellipsis " ▾")
    (setq org-startup-with-inline-images t)
    (setq org-image-actual-width '(600))
    (setq org-superstar-headline-bullets-list '("◉" "○" "●" "○" "●" "○" "●"))
    ;;The minimum number of lines for block output. This fixes the colon issue.
    (setq org-babel-min-lines-for-block-output 0)

    (setq org-agenda-files
          '("~/org/Tasks.org"
            "~/org/Birthdays.org"
            "~/org/Archive.org"))
    (setq org-archive-location "~/org/Archive.org::")
    (setq org-agenda-start-with-log-mode t)
    (setq org-log-done 'time)

    ;; allow auto evaluation
    (setq org-confirm-babel-evaluate nil)
    (setq org-latex-pdf-process (list "latexmk -shell-escape -f -pdf %f"))
    (setq org-latex-listings 'minted
          org-latex-packages-alist '(("" "minted"))
          org-export-latex-minted-options
          '(("frame" "lines")
            ("fontsize" "\\scriptsize")
            ("framesep" "2mm")
            ("bgcolor" "LightGray")
            ("linenos" "")
            ("breaklines" "true")
            ("breakanywhere" "true")))

    (setq ieeetran-class
          '("IEEEtran" "\\documentclass[11pt]{IEEEtran}"
            ("\\section{\\textsc{%s}}" . "\\section*{%s}")
            ("\\subsection{%s}" . "\\subsection*{%s}")
            ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
            ("\\paragraph{%s}" . "\\paragraph*{%s}")
            ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
    (setq org-latex-toc-command "\\clearpage \\tableofcontents \\clearpage")
    (setq org-export-allow-bind-keywords t)

    ;; Configure custom agenda views
    (setq org-agenda-custom-commands
          '(("d" "Dashboard"
             ((agenda "" ((org-deadline-warning-days 7)))
              (todo "NEXT"
                    ((org-agenda-overriding-header "Next Tasks")))
              (tags-todo "agenda/ACTIVE" ((org-agenda-overriding-header "Active Projects")))))

            ("n" "Next Tasks"
             ((todo "NEXT"
                    ((org-agenda-overriding-header "Next Tasks")))))

            ("W" "Work Tasks" tags-todo "+work-email")

            ;; Low-effort next actions
            ("e" tags-todo "+TODO=\"NEXT\"+Effort<15&+Effort>0"
             ((org-agenda-overriding-header "Low Effort Tasks")
              (org-agenda-max-todos 20)
              (org-agenda-files org-agenda-files)))

            ("w" "Workflow Status"
             ((todo "WAIT"
                    ((org-agenda-overriding-header "Waiting on External")
                     (org-agenda-files org-agenda-files)))
              (todo "REVIEW"
                    ((org-agenda-overriding-header "In Review")
                     (org-agenda-files org-agenda-files)))
              (todo "PLAN"
                    ((org-agenda-overriding-header "In Planning")
                     (org-agenda-todo-list-sublevels nil)
                     (org-agenda-files org-agenda-files)))
              (todo "BACKLOG"
                    ((org-agenda-overriding-header "Project Backlog")
                     (org-agenda-todo-list-sublevels nil)
                     (org-agenda-files org-agenda-files)))
              (todo "READY"
                    ((org-agenda-overriding-header "Ready for Work")
                     (org-agenda-files org-agenda-files)))
              (todo "ACTIVE"
                    ((org-agenda-overriding-header "Active Projects")
                     (org-agenda-files org-agenda-files)))
              (todo "DONE"
                    ((org-agenda-overriding-header "Completed Projects")
                     (org-agenda-files org-agenda-files)))
              (todo "CANC"
                    ((org-agenda-overriding-header "Cancelled Projects")
                     (org-agenda-files org-agenda-files)))))))

            (setq org-todo-keywords
                  '((sequence "TODO(t)" "ACTIVE(a)" "WAIT(w@/!)" "REVIEW(v)" "|" "DONE(d@)" "CANC(c@)")
                    (sequence "BACKLOG(b)" "RESEARCH(r)" "REFINE(f)" "PLAN(p)" "READY(y)" "WAIT(w@/!)" "REVIEW(v)")))
    ;;(setq org-agenda-prefix-format '((todo . " %i %-12:c [%e] ") (tags . " %i %-12:c ") (search . " %i %-12:c ")))
    ;;(setq org-export-with-todo-keyword-format "[%s]")
    (setq org-export-with-tags t)
    (setq org-export-with-planning t)
    (setq org-export-with-timestamps t)
    (kito/org-font-setup))

  ;; spacemacs uses something other than org-bullets
  ;; (use-package org-bullets
  ;;   :after org
  ;;   :hook (org-mode . org-bullets-mode)
  ;;   :custom)

  (use-package org-pdftools
    :hook (org-mode . org-pdftools-setup-link))

  (add-to-list 'auto-mode-alist '("\\.\\(?:PDF\\|DVI\\|OD[FGPST]\\|DOCX\\|XLSX?\\|PPTX?\\|pdf\\|djvu\\|dvi\\|od[fgpst]\\|docx\\|xlsx?\\|pptx?\\)\\'" . pdf-view-mode))


  ;; language support
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (python . t)
     (C . t)
     (awk . t)
     (shell . t)
     (gnuplot .t )
     (sed . t)
     (jupyter . t)))


  (push '("conf-unix" . conf-unix) org-src-lang-modes)

  ;; auto eval src blocks
  (defun my-org-confirm-babel-evaluate (lang body)
    (not (string= lang "ditaa")))  ;don't ask for ditaa
  (setq org-confirm-babel-evaluate #'my-org-confirm-babel-evaluate)

  ;; don't insert colons into result
  (setq org-babel-min-lines-for-block-output 0)

  ;; remove example block literal in latex due to removing colons
  (defun ndk/clean-up-latex-export-blocks (text backend info)
    ""
    (when (org-export-derived-backend-p backend 'latex)
      (replace-regexp-in-string "#\\+begin_example\n" ""
                                (replace-regexp-in-string "#\\+end_example\n" "" text))))

  ;; This is needed as of Org 9.2
  (add-to-list 'org-structure-template-alist '("sh" . "src shell"))
  (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
  (add-to-list 'org-structure-template-alist '("py" . "src python"))

  (customize-set-value 'org-latex-with-hyperref nil)

  (with-eval-after-load 'ox-latex
    (add-to-list 'org-latex-classes ieeetran-class t))


  (setq-default indent-tabs-mode nil)
  (setq-default tab-width 4)
  (setq c-basic-offset 4)
  (setq c-basic-indent 4)
  (c-set-offset 'case-label '+)

  (add-hook 'makefile-gmake-mode-hook
            (lambda ()
              (setq indent-tabs-mode t)  ; Use tabs for indentation
              (setq tab-width 8)))       ; Set tab width to 8 spaces

  ;; set the indentation to spaces and tab-width to 4 when editing C/C++ files
  (add-hook 'c-mode-common-hook
            (lambda ()
              (setq indent-tabs-mode nil)
              (setq tab-width 4)))

  ;; Convert hard tabs to spaces on save
  (add-hook 'before-save-hook
            (lambda ()
              ;; But not Makefiles
              (if (member major-mode '(makefile-mode makefile-gmake-mode))
                  (tabify (point-min) (point-max))
                (untabify (point-min) (point-max)))))

  (setq c-default-style
        '((java-mode . "java")
          (awk-mode . "awk")
          (cuda-mode . "bsd")
          (other . "bsd")))

  (eval-after-load 'flycheck
    '(add-hook 'flycheck-mode-hook #'flycheck-cask-setup))
)

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(defun dotspacemacs/emacs-custom-settings ()
  "Emacs custom settings.
This is an auto-generated function, do not modify its content directly, use
Emacs customize menu instead.
This function is called at the very end of Spacemacs initialization."
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(evil-want-Y-yank-to-eol nil)
 '(package-selected-packages
   '(company-lua lua-mode company-c-headers company-rtags company-ycmd cpp-auto-include disaster flycheck-rtags flycheck-ycmd gendoxy google-c-style ivy-rtags rtags ycmd request-deferred all-the-icons json-mode json-navigator hierarchy json-reformat json-snatcher spaceline powerline systemd journalctl-mode sqlite3 djvu nov dockerfile-mode import-js grizzl js-doc js2-refactor multiple-cursors livid-mode nodejs-repl npm-mode skewer-mode js2-mode tern add-node-modules-path company-web web-completion-data counsel-css emmet-mode helm-css-scss impatient-mode htmlize prettier-js pug-mode sass-mode haml-mode scss-mode slim-mode tagedit web-beautify web-mode flycheck-cask flycheck-cstyle blacken code-cells company-anaconda anaconda-mode counsel-gtags cython-mode dap-mode lsp-docker bui ggtags helm-cscope helm-gtags helm helm-pydoc helm-core importmagic epc ctable concurrent deferred live-py-mode lsp-pyright lsp-python-ms nose pip-requirements pipenv load-env-vars pippel poetry py-isort pydoc pyenv-mode pythonic pylookup pytest pyvenv sphinx-doc stickyfunc-enhance xcscope yapfify quelpa quelpa-use-package csv-mode cuda-mode jupyter all-the-icons-ivy yasnippet-snippets ws-butler writeroom-mode winum which-key wgrep volatile-highlights vim-powerline vi-tilde-fringe uuidgen use-package undo-tree treemacs-projectile treemacs-persp treemacs-magit treemacs-icons-dired treemacs-evil toc-org term-cursor symon symbol-overlay string-inflection string-edit-at-point spacemacs-whitespace-cleanup spacemacs-purpose-popwin spaceline-all-the-icons space-doc smex smeargle restart-emacs request rainbow-delimiters quickrun popwin pcre2el password-generator paradox overseer org-superstar org-pdftools org-contrib org-bullets open-junk-file nameless multi-line mmm-mode markdown-toc macrostep lsp-ui lsp-treemacs lsp-origami lsp-ivy lorem-ipsum link-hint ivy-yasnippet ivy-xref ivy-purpose ivy-hydra ivy-avy inspector info+ indent-guide hybrid-mode hungry-delete holy-mode hl-todo highlight-parentheses highlight-numbers highlight-indentation hide-comnt help-fns+ helm-make google-translate golden-ratio gitignore-templates git-timemachine git-modes git-messenger git-link gh-md fuzzy forge font-lock+ flycheck-pos-tip flycheck-package flycheck-elsa flx-ido fancy-battery eyebrowse expand-region evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-textobj-line evil-surround evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-lisp-state evil-lion evil-indent-plus evil-iedit-state evil-goggles evil-exchange evil-evilified-state evil-escape evil-easymotion evil-collection evil-cleverparens evil-args evil-anzu eval-sexp-fu emr elisp-slime-nav elisp-def editorconfig dumb-jump drag-stuff dotenv-mode doom-themes dired-quick-sort diminish devdocs define-word counsel-projectile company column-enforce-mode clean-aindent-mode centered-cursor-mode auto-yasnippet auto-highlight-symbol auto-compile async aggressive-indent ace-link ac-ispell)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
)
