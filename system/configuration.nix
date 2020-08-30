# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, callPackage, ... }:

let XmodMapLayout = pkgs.writeText "xkb-layout" ''
    ! xmodmap for the Colemak Mod-DH layout (US, ANSI keyboard, Z angle mod).
    ! http://colemakmods.github.io/mod-dh/.
    ! Public domain.
    
    keycode  49  =  grave         asciitilde   
    keycode  10  =  1             exclam       
    keycode  11  =  2             at           
    keycode  12  =  3             numbersign   
    keycode  13  =  4             dollar       
    keycode  14  =  5             percent      
    keycode  15  =  6             asciicircum  
    keycode  16  =  7             ampersand    
    keycode  17  =  8             asterisk     
    keycode  18  =  9             parenleft    
    keycode  19  =  0             parenright   
    keycode  20  =  minus         underscore   
    keycode  21  =  equal         plus         
    
    keycode  24  =  q             Q            
    keycode  25  =  w             W            
    keycode  26  =  f             F            
    keycode  27  =  p             P            
    keycode  28  =  b             B            
    keycode  29  =  j             J            
    keycode  30  =  l             L            
    keycode  31  =  u             U            
    keycode  32  =  y             Y            
    keycode  33  =  semicolon     colon        
    keycode  34  =  bracketleft   braceleft    
    keycode  35  =  bracketright  braceright   
    keycode  51  =  backslash     bar          
    
    keycode  38  =  a             A            
    keycode  39  =  r             R            
    keycode  40  =  s             S            
    keycode  41  =  t             T            
    keycode  42  =  g             G            
    keycode  43  =  k             K            
    keycode  44  =  n             N            
    keycode  45  =  e             E            
    keycode  46  =  i             I            
    keycode  47  =  o             O            
    keycode  48  =  apostrophe    quotedbl     
    
    keycode  94  =  minus         underscore   
    keycode  52  =  x             X            
    keycode  53  =  c             C            
    keycode  54  =  d             D            
    keycode  55  =  v             V            
    keycode  56  =  z             Z            
    keycode  57  =  m             M            
    keycode  58  =  h             H            
    keycode  59  =  comma         less         
    keycode  60  =  period        greater      
    keycode  61  =  slash         question     
    
    keycode  65  =  space         space        
    
    remove Lock = Caps_Lock
    keysym Caps_Lock = Escape
    
    remove Mod1 = Alt_L
    add Mod4 = Alt_L

    remove Mod4 = Super_L
    add control = Super_L

    remove Mod4 = Super_R
    add control = Super_R

    remove control = Control_L
    add Mod4 = Control_L

    remove control = Control_R
    add Mod4 = Control_R
    '';
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.wlp2s0.useDHCP = true;
  networking.wireless.networks = {
    "NETGEAR30-5G" = {
       pskRaw = "2240d3156a7d07421a2cc267511601a87c3a8581e6eca0c3a9e68ce6042f0af9";
    };
  };


  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  # Set your time zone.
  time.timeZone = "America/Boise";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     xmobar
  ];
  #programs.nm-applet.enable = true;
	
  programs.light.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  #   pinentryFlavor = "gnome3";
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  boot.kernelParams = [ "amd_iommu=pt" "ivrs_ioapic[32]=00:14.0" "iommu=soft" ];
  services.xserver.videoDrivers = [ "amdgpu" ];  
  boot.kernelPackages = pkgs.linuxPackages_latest;				    
  hardware.cpu.amd.updateMicrocode = true;      
  hardware.enableRedistributableFirmware = true;
  hardware.opengl.enable = true;
  hardware.opengl.driSupport = true;   

  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";
  services.xserver.displayManager.sessionCommands = "${pkgs.xorg.xmodmap}/bin/xmodmap ${XmodMapLayout}";


  # Enable touchpad support.
  services.xserver.libinput.enable = true;

  # And docker.
  virtualisation.docker.enable = true;

  # Enable the KDE Desktop Environment.
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;
#  services.xserver = {
#    enable = true;
#    desktopManager = {
#      default = "xfce";
#      xterm.enable = false;
#      xfce.enable = true;
#    };
#  };

  services.xserver = {
    enable = true;
    desktopManager.xfce.enable = true;
    desktopManager.xfce.noDesktop = true;
    desktopManager.xfce.enableXfwm = false;
    windowManager.i3.enable = true;
  };

  environment.etc = {
    shells = {
      text = ''
        /run/current-system/sw/bin/bash
        /run/current-system/sw/bin/sh
        /nix/store/4xb9z8vvk3fk2ciwqh53hzp72d0hx1da-bash-interactive-4.4-p23/bin/bash
        /nix/store/4xb9z8vvk3fk2ciwqh53hzp72d0hx1da-bash-interactive-4.4-p23/bin/sh
        /bin/sh
        /home/james/.nix-profile/bin/zsh
      '';
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.james = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "audio" "video" "networkmanager" "docker" ]; # Enable ‘sudo’ for the user.
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.03"; # Did you read the comment?

}

