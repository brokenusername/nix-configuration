{
  home.file.".xmodmap".text = ''
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
  '';
}
