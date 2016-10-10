{ InputSDL.pas - Input subsystem of VesaSDL

Copyright (c) 2015-2016 NFS_MONSTR(Maxim Belyaev)

This software is provided 'as-is', without any express or implied
warranty. In no event will the authors be held liable for any damages
arising from the use of this software.

Permission is granted to anyone to use this software for any purpose,
including commercial applications, and to alter it and redistribute it
freely, subject to the following restrictions:

    1. The origin of this software must not be misrepresented; you must not
       claim that you wrote the original software. If you use this software
       in a product, an acknowledgement in the product documentation would be
       appreciated but is not required.
    2. Altered source versions must be plainly marked as such, and must not be
       misrepresented as being the original software.
    3. This notice may not be removed or altered from any source distribution.
}
Unit InputSDL;
Interface
Uses SDL2;
Const
  {left mouse button=1
   mid mouse button=2
   right mouse button=3
   l+m=4
   l+r=5
   m+r=6 l+m+r=7}
  {here is long column of constants. If you want to see something else then go to line 226}
  kwtf=SDL_SCANCODE_UNKNOWN;
  ka=SDL_SCANCODE_A;
  kb=SDL_SCANCODE_B;
  kc=SDL_SCANCODE_C;
  kd=SDL_SCANCODE_D;
  ke=SDL_SCANCODE_E;
  kf=SDL_SCANCODE_F;
  kg=SDL_SCANCODE_G;
  kh=SDL_SCANCODE_H;
  ki=SDL_SCANCODE_I;
  kj=SDL_SCANCODE_J;
  kk=SDL_SCANCODE_K;
  kl=SDL_SCANCODE_L;
  km=SDL_SCANCODE_M;
  kn=SDL_SCANCODE_N;
  ko=SDL_SCANCODE_O;
  kp=SDL_SCANCODE_P;
  kq=SDL_SCANCODE_Q;
  kr=SDL_SCANCODE_R;
  ks=SDL_SCANCODE_S;
  kt=SDL_SCANCODE_T;
  ku=SDL_SCANCODE_U;
  kv=SDL_SCANCODE_V;
  kw=SDL_SCANCODE_W;
  kx=SDL_SCANCODE_X;
  ky=SDL_SCANCODE_Y;
  kz=SDL_SCANCODE_Z;
  k1=SDL_SCANCODE_1;
  k2=SDL_SCANCODE_2;
  k3=SDL_SCANCODE_3;
  k4=SDL_SCANCODE_4;
  k5=SDL_SCANCODE_5;
  k6=SDL_SCANCODE_6;
  k7=SDL_SCANCODE_7;
  k8=SDL_SCANCODE_8;
  k9=SDL_SCANCODE_9;
  k0=SDL_SCANCODE_0;
  kenter=SDL_SCANCODE_RETURN;
  kesc=SDL_SCANCODE_ESCAPE;
  kbackspace=SDL_SCANCODE_BACKSPACE;
  ktab=SDL_SCANCODE_TAB;
  kspace=SDL_SCANCODE_SPACE;
  kminus=SDL_SCANCODE_MINUS;
  kequals=SDL_SCANCODE_EQUALS;
  kleftbracket=SDL_SCANCODE_LEFTBRACKET; (*  '[ '  *)
  krightbracket=SDL_SCANCODE_RIGHTBRACKET; (* ']'  *)
  kbackslash=SDL_SCANCODE_BACKSLASH;
  ktz=SDL_SCANCODE_SEMICOLON;  (*  ';'  *)
  kapostrophe=SDL_SCANCODE_APOSTROPHE; (*  ' ' '  *)
  {SDL_SCANCODE_GRAVE = 53;}
  kzpt=SDL_SCANCODE_COMMA; { ',' }
  kdot=SDL_SCANCODE_PERIOD; { '.' }
  kslash=SDL_SCANCODE_SLASH;
  kcaps=SDL_SCANCODE_CAPSLOCK;
  kf1=SDL_SCANCODE_F1;
  kf2=SDL_SCANCODE_F2;
  kf3=SDL_SCANCODE_F3;
  kf4=SDL_SCANCODE_F4;
  kf5=SDL_SCANCODE_F5;
  kf6=SDL_SCANCODE_F6;
  kf7=SDL_SCANCODE_F7;
  kf8=SDL_SCANCODE_F8;
  kf9=SDL_SCANCODE_F9;
  kf10=SDL_SCANCODE_F10;
  kf11=SDL_SCANCODE_F11;
  kf12=SDL_SCANCODE_F12;

  kprtscr=SDL_SCANCODE_PRINTSCREEN;
  kscrlock=SDL_SCANCODE_SCROLLLOCK;
  kpause=SDL_SCANCODE_PAUSE;
  kinsert=SDL_SCANCODE_INSERT;
  kHome=SDL_SCANCODE_HOME;
  kpgup=SDL_SCANCODE_PAGEUP;
  kdel=SDL_SCANCODE_DELETE;
  kend=SDL_SCANCODE_END;
  kpgdown=SDL_SCANCODE_PAGEDOWN;
  kright=SDL_SCANCODE_RIGHT;
  kleft=SDL_SCANCODE_LEFT;
  kdown=SDL_SCANCODE_DOWN;
  kup=SDL_SCANCODE_UP;

  knumlock=SDL_SCANCODE_NUMLOCKCLEAR;
  knumdiv=SDL_SCANCODE_KP_DIVIDE; { / on numpad }
  kmult=SDL_SCANCODE_KP_MULTIPLY; { * on numpad }
  kkpminus=SDL_SCANCODE_KP_MINUS; { - on numpad }
  kkpplus=SDL_SCANCODE_KP_PLUS ;  { + on numpad }
  kkpenter=SDL_SCANCODE_KP_ENTER; { enter on numpad }
  kkp1=SDL_SCANCODE_KP_1;         { 1 on numpad }
  kkp2=SDL_SCANCODE_KP_2;         { 2 on numpad }
  kkp3=SDL_SCANCODE_KP_3;         { 3 on numpad }
  kkp4=SDL_SCANCODE_KP_4;         { 4 on numpad }
  kkp5=SDL_SCANCODE_KP_5;         { 5 on numpad }
  kkp6=SDL_SCANCODE_KP_6;         { 6 on numpad }
  kkp7=SDL_SCANCODE_KP_7;         { 7 on numpad }
  kkp8=SDL_SCANCODE_KP_8;         { 8 on numpad }
  kkp9=SDL_SCANCODE_KP_9;         { 9 on numpad }
  kkp0=SDL_SCANCODE_KP_0;         { 0 on numpad }
  kkpdot=SDL_SCANCODE_KP_PERIOD;  { . on numpad }

  {SDL_SCANCODE_NONUSBACKSLASH = 100;}
  kapp=SDL_SCANCODE_APPLICATION;
  kpower=SDL_SCANCODE_POWER;
  kkpequals=SDL_SCANCODE_KP_EQUALS; { = on numpad }

  kf13=SDL_SCANCODE_F13; { I dont know what means "f13", but i dont care}
  kf14=SDL_SCANCODE_F14;
  kf15=SDL_SCANCODE_F15;
  kf16=SDL_SCANCODE_F16;
  kf17=SDL_SCANCODE_F17;
  kf18=SDL_SCANCODE_F18;
  kf19=SDL_SCANCODE_F19;
  kf20=SDL_SCANCODE_F20;
  kf21=SDL_SCANCODE_F21;
  kf22=SDL_SCANCODE_F22;
  kf23=SDL_SCANCODE_F23;
  kf24=SDL_SCANCODE_F24;
  kexecute=SDL_SCANCODE_EXECUTE;
  khelp=SDL_SCANCODE_HELP;
  kmenu=SDL_SCANCODE_MENU;
  kselect=SDL_SCANCODE_SELECT;
  kstop=SDL_SCANCODE_STOP;
  kagain=SDL_SCANCODE_AGAIN;
  kundo=SDL_SCANCODE_UNDO;
  kcut=SDL_SCANCODE_CUT;
  kcopy=SDL_SCANCODE_COPY;
  kpaste=SDL_SCANCODE_PASTE;
  kfind=SDL_SCANCODE_FIND;
  kmute=SDL_SCANCODE_MUTE;
  kvolumeup=SDL_SCANCODE_VOLUMEUP;
  kvolumedown=SDL_SCANCODE_VOLUMEDOWN;
  kkpzpt=SDL_SCANCODE_KP_COMMA; { , on numpad }
  kkpEQUALSAS400=SDL_SCANCODE_KP_EQUALSAS400;

  kint1=SDL_SCANCODE_INTERNATIONAL1;
  kint2=SDL_SCANCODE_INTERNATIONAL2;
  kint3=SDL_SCANCODE_INTERNATIONAL3;
  kint4=SDL_SCANCODE_INTERNATIONAL4;
  kint5=SDL_SCANCODE_INTERNATIONAL5;
  kint6=SDL_SCANCODE_INTERNATIONAL6;
  kint7=SDL_SCANCODE_INTERNATIONAL7;
  kint8=SDL_SCANCODE_INTERNATIONAL8;
  kint9=SDL_SCANCODE_INTERNATIONAL9;
  klang1=SDL_SCANCODE_LANG1;
  {SDL_SCANCODE_LANG2 = 145  (* oh, just fuck it *)
  SDL_SCANCODE_LANG3 = 146;
  SDL_SCANCODE_LANG4 = 147;
  SDL_SCANCODE_LANG5 = 148;
  SDL_SCANCODE_LANG6 = 149;
  SDL_SCANCODE_LANG7 = 150;
  SDL_SCANCODE_LANG8 = 151;
  SDL_SCANCODE_LANG9 = 152;

  SDL_SCANCODE_ALTERASE = 153;
  SDL_SCANCODE_SYSREQ = 154;
  SDL_SCANCODE_CANCEL = 155;
  SDL_SCANCODE_CLEAR = 156;
  SDL_SCANCODE_PRIOR = 157;
  SDL_SCANCODE_RETURN2 = 158;
  SDL_SCANCODE_SEPARATOR = 159;
  SDL_SCANCODE_OUT = 160;
  SDL_SCANCODE_OPER = 161;
  SDL_SCANCODE_CLEARAGAIN = 162;
  SDL_SCANCODE_CRSEL = 163;
  SDL_SCANCODE_EXSEL = 164;

  SDL_SCANCODE_KP_00 = 176;
  SDL_SCANCODE_KP_000 = 177;
  SDL_SCANCODE_THOUSANDSSEPARATOR = 178;
  SDL_SCANCODE_DECIMALSEPARATOR = 179;
  SDL_SCANCODE_CURRENCYUNIT = 180;
  SDL_SCANCODE_CURRENCYSUBUNIT = 181;
  SDL_SCANCODE_KP_LEFTPAREN = 182;
  SDL_SCANCODE_KP_RIGHTPAREN = 183;
  SDL_SCANCODE_KP_LEFTBRACE = 184;
  SDL_SCANCODE_KP_RIGHTBRACE = 185;
  SDL_SCANCODE_KP_TAB = 186;
  SDL_SCANCODE_KP_BACKSPACE = 187;
  SDL_SCANCODE_KP_A = 188;
  SDL_SCANCODE_KP_B = 189;
  SDL_SCANCODE_KP_C = 190;
  SDL_SCANCODE_KP_D = 191;
  SDL_SCANCODE_KP_E = 192;
  SDL_SCANCODE_KP_F = 193;
  SDL_SCANCODE_KP_XOR = 194;
  SDL_SCANCODE_KP_POWER = 195;
  SDL_SCANCODE_KP_PERCENT = 196;
  SDL_SCANCODE_KP_LESS = 197;
  SDL_SCANCODE_KP_GREATER = 198;
  SDL_SCANCODE_KP_AMPERSAND = 199;
  SDL_SCANCODE_KP_DBLAMPERSAND = 200;
  SDL_SCANCODE_KP_VERTICALBAR = 201;
  SDL_SCANCODE_KP_DBLVERTICALBAR = 202;
  SDL_SCANCODE_KP_COLON = 203;
  SDL_SCANCODE_KP_HASH = 204;
  SDL_SCANCODE_KP_SPACE = 205;
  SDL_SCANCODE_KP_AT = 206;
  SDL_SCANCODE_KP_EXCLAM = 207;
  SDL_SCANCODE_KP_MEMSTORE = 208;
  SDL_SCANCODE_KP_MEMRECALL = 209;
  SDL_SCANCODE_KP_MEMCLEAR = 210;
  SDL_SCANCODE_KP_MEMADD = 211;
  SDL_SCANCODE_KP_MEMSUBTRACT = 212;
  SDL_SCANCODE_KP_MEMMULTIPLY = 213;
  SDL_SCANCODE_KP_MEMDIVIDE = 214;
  SDL_SCANCODE_KP_PLUSMINUS = 215;
  SDL_SCANCODE_KP_CLEAR = 216;
  SDL_SCANCODE_KP_CLEARENTRY = 217;
  SDL_SCANCODE_KP_BINARY = 218;
  SDL_SCANCODE_KP_OCTAL = 219;
  SDL_SCANCODE_KP_DECIMAL = 220;
  SDL_SCANCODE_KP_HEXADECIMAL = 221;
                           }
  kctrl = 224;
  klctrlmod=kmod_lctrl;{ (*if you need it just uncomment and set it*)
  SDL_SCANCODE_LSHIFT = 225;
  SDL_SCANCODE_LALT = 226;
  SDL_SCANCODE_LGUI = 227;
  SDL_SCANCODE_RCTRL = 228;
  SDL_SCANCODE_RSHIFT = 229;
  SDL_SCANCODE_RALT = 230;
  SDL_SCANCODE_RGUI = 231;}
type tkey=record
           key:tsdl_keysym;
           mod_:word;
          end;
 var keys:PUint8; mousex,mousey:Longint; mousebutton,countmousebuttonspressed:integer;
     lastkey:tkey;
 Procedure InputInit;
 Procedure InputUpdate;
 Function ReadKey(var x:ansistring):integer;
Implementation
 Procedure InputUpdate;
  var p,p1:plongint; event:pSDL_Event;
  begin
   new(event);
   if SDL_PollEvent(event)=1 then
    begin
     if event^.type_=SDL_QUITEV then 
	  begin
	   sdl_quit;	  
	   halt(0);
	  end; 
	 if event^.type_=sdl_mousemotion then
      begin
       new(p);new(p1);                {left mouse button=1}
       sdl_getmousestate(p,p1);       {mid mouse button=2}
       mousex:=p^;                    {right mouse button=3}
       mousey:=p1^;                   {l+m=4}
       dispose(p); dispose(p1);       {l+r=5  m+r=6 m+r+l=7}
      end;
     if event^.type_=SDL_MouseButtonDown then
      begin
       if countmousebuttonspressed=0 then
        mousebutton:=event^.button.button;
       if countmousebuttonspressed>0 then
        mousebutton:=mousebutton+event^.button.button+1;
       inc(countmousebuttonspressed);
      end;
     if event^.type_=SDL_MouseButtonUp then
      begin
       if (countmousebuttonspressed=1) or (countmousebuttonspressed=3) then
        mousebutton:=mousebutton-event^.button.button;
       if countmousebuttonspressed=2 then
        mousebutton:=mousebutton-event^.button.button-1;
       dec(countmousebuttonspressed);
      end;
     if event^.type_=sdl_keydown then
      begin
       lastkey.key:=event^.key.keysym;
       lastkey.mod_:=sdl_getmodstate;
      end;
    end;
   dispose(event);
  end;
 Function readkey(var x:ansistring):integer;
  begin
   if lastkey.key.sym<>-1 then
    begin	 
     readkey:=lastkey.key.scancode+lastkey.mod_;
     x:=sdl_getkeyname(lastkey.key.sym);
     lastkey.key.sym:=-1;
    end
    else
    begin
     readkey:=-1;
     x:='';
    end;
  end;
 Procedure InputInit;
  begin
   keys:=SDL_GetKeyboardState(nil);
   lastkey.key.sym:=-1;
   SDL_PumpEvents;
   mousebutton:=0;
   countmousebuttonspressed:=0;
   inputupdate;
  end;
begin  
end.
