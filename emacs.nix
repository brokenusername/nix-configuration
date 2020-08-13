{
  programs.emacs = {
    enable = true;
    extraPackages = epkgs: (with epkgs.melpaPackages; [
      cider
      clojure-mode
      elixir-mode
      god-mode
      magit
      nix-mode
      paredit
    ]);
  };

  home.file.".emacs".text = ''
    (menu-bar-mode -1)
    (tool-bar-mode -1)
    (scroll-bar-mode -1)
    
    (require 'god-mode)
    (god-mode)
    
    (global-set-key (kbd "<escape>") #'god-local-mode)
    
    (defun my-god-mode-update-cursor ()
      (setq cursor-type (if (or god-local-mode buffer-read-only)
                            'box
                          'bar)))
    
    (add-hook 'god-mode-enabled-hook #'my-god-mode-update-cursor)
    (add-hook 'god-mode-disabled-hook #'my-god-mode-update-cursor)
    
    (define-key god-local-mode-map (kbd ".") #'repeat)
    
    (global-set-key (kbd "C-x C-1") #'delete-other-windows)
    (global-set-key (kbd "C-x C-2") #'split-window-below)
    (global-set-key (kbd "C-x C-3") #'split-window-right)
    (global-set-key (kbd "C-x C-0") #'delete-window)
    (global-set-key (kbd "C-x C-k") #'kill-buffer)
    (global-set-key (kbd "C-x C-o") #'other-window)
  '';
}
