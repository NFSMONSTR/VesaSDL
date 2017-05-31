{ InputSDL.pas - Input subsystem of VesaSDL

Copyright (c) 2015-2017 NFS_MONSTR(Maxim Belyaev)

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
  {Mouse}
  NoButton=0;
  LeftButton=1;
  MidButton=2;
  RightButton=3;
  BothButtons=5;{For backward compatibility}
  LeftAndMidButton=4;
  LeftAndRightButton=5;
  MidAndRightButton=6;
  LeftAndMidAndRightButton=7;
  {left mouse button=1
   mid mouse button=2
   right mouse button=3
   l+m=4
   l+r=5
   m+r=6 l+m+r=7}
  kUnknown=SDL_SCANCODE_UNKNOWN;
  kA=SDL_SCANCODE_A;
  kB=SDL_SCANCODE_B;
  kC=SDL_SCANCODE_C;
  kD=SDL_SCANCODE_D;
  kE=SDL_SCANCODE_E;
  kF=SDL_SCANCODE_F;
  kG=SDL_SCANCODE_G;
  kH=SDL_SCANCODE_H;
  kI=SDL_SCANCODE_I;
  kJ=SDL_SCANCODE_J;
  kK=SDL_SCANCODE_K;
  kL=SDL_SCANCODE_L;
  kM=SDL_SCANCODE_M;
  kN=SDL_SCANCODE_N;
  kO=SDL_SCANCODE_O;
  kP=SDL_SCANCODE_P;
  kQ=SDL_SCANCODE_Q;
  kR=SDL_SCANCODE_R;
  kS=SDL_SCANCODE_S;
  kT=SDL_SCANCODE_T;
  kU=SDL_SCANCODE_U;
  kV=SDL_SCANCODE_V;
  kW=SDL_SCANCODE_W;
  kX=SDL_SCANCODE_X;
  kY=SDL_SCANCODE_Y;
  kZ=SDL_SCANCODE_Z;
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
  kEnter=SDL_SCANCODE_RETURN;
  kEsc=SDL_SCANCODE_ESCAPE;
  kBackSpace=SDL_SCANCODE_BACKSPACE;
  kTab=SDL_SCANCODE_TAB;
  kSpace=SDL_SCANCODE_SPACE;
  kMinus=SDL_SCANCODE_MINUS;
  kEquals=SDL_SCANCODE_EQUALS;{ = }
  kLeftBracket=SDL_SCANCODE_LEFTBRACKET; (*  '[ '  *)
  kRightBracket=SDL_SCANCODE_RIGHTBRACKET; (* ']'  *)
  kBackSlash=SDL_SCANCODE_BACKSLASH; { \ }
  kSemicolon=SDL_SCANCODE_SEMICOLON;  (*  ';'  *)
  kApostrophe=SDL_SCANCODE_APOSTROPHE; (*  ' ' '  *)
  kGrave=SDL_SCANCODE_GRAVE; { '`' }
  kComma=SDL_SCANCODE_COMMA; { ',' }
  kDot=SDL_SCANCODE_PERIOD; { '.' }
  kSlash=SDL_SCANCODE_SLASH; { / }
  kCaps=SDL_SCANCODE_CAPSLOCK;
  kF1=SDL_SCANCODE_F1;
  kF2=SDL_SCANCODE_F2;
  kF3=SDL_SCANCODE_F3;
  kF4=SDL_SCANCODE_F4;
  kF5=SDL_SCANCODE_F5;
  kF6=SDL_SCANCODE_F6;
  kF7=SDL_SCANCODE_F7;
  kF8=SDL_SCANCODE_F8;
  kF9=SDL_SCANCODE_F9;
  kF10=SDL_SCANCODE_F10;
  kF11=SDL_SCANCODE_F11;
  kF12=SDL_SCANCODE_F12;

  kPrtScr=SDL_SCANCODE_PRINTSCREEN;
  kScrLock=SDL_SCANCODE_SCROLLLOCK;
  kPause=SDL_SCANCODE_PAUSE;
  kInsert=SDL_SCANCODE_INSERT;
  kHome=SDL_SCANCODE_HOME;
  kPgUp=SDL_SCANCODE_PAGEUP;
  kDel=SDL_SCANCODE_DELETE;
  kEnd=SDL_SCANCODE_END;
  kPgDown=SDL_SCANCODE_PAGEDOWN;
  kRight=SDL_SCANCODE_RIGHT;
  kLeft=SDL_SCANCODE_LEFT;
  kDown=SDL_SCANCODE_DOWN;
  kUp=SDL_SCANCODE_UP;

  kNumLock=SDL_SCANCODE_NUMLOCKCLEAR;
  kNumDiv=SDL_SCANCODE_KP_DIVIDE;   { / on numpad }
  kNumMul=SDL_SCANCODE_KP_MULTIPLY; { * on numpad }
  kNumMinus=SDL_SCANCODE_KP_MINUS;  { - on numpad }
  kNumPlus=SDL_SCANCODE_KP_PLUS ;   { + on numpad }
  kNumEnter=SDL_SCANCODE_KP_ENTER;  { enter on numpad }
  kNum1=SDL_SCANCODE_KP_1;          { 1 on numpad }
  kNum2=SDL_SCANCODE_KP_2;          { 2 on numpad }
  kNum3=SDL_SCANCODE_KP_3;          { 3 on numpad }
  kNum4=SDL_SCANCODE_KP_4;          { 4 on numpad }
  kNum5=SDL_SCANCODE_KP_5;          { 5 on numpad }
  kNum6=SDL_SCANCODE_KP_6;          { 6 on numpad }
  kNum7=SDL_SCANCODE_KP_7;          { 7 on numpad }
  kNum8=SDL_SCANCODE_KP_8;          { 8 on numpad }
  kNum9=SDL_SCANCODE_KP_9;          { 9 on numpad }
  kNum0=SDL_SCANCODE_KP_0;          { 0 on numpad }
  kNumDot=SDL_SCANCODE_KP_PERIOD;   { . on numpad }
  kNumEquals=SDL_SCANCODE_KP_EQUALS;{ = on numpad }
  kNumComma=SDL_SCANCODE_KP_COMMA;  { , on numpad }
  kNumEQUALSAS400=SDL_SCANCODE_KP_EQUALSAS400;

  {SDL_SCANCODE_NONUSBACKSLASH = 100;}
  kApp=SDL_SCANCODE_APPLICATION;
  kPower=SDL_SCANCODE_POWER;


  kF13=SDL_SCANCODE_F13;
  kF14=SDL_SCANCODE_F14;
  kF15=SDL_SCANCODE_F15;
  kF16=SDL_SCANCODE_F16;
  kF17=SDL_SCANCODE_F17;
  kF18=SDL_SCANCODE_F18;
  kF19=SDL_SCANCODE_F19;
  kF20=SDL_SCANCODE_F20;
  kF21=SDL_SCANCODE_F21;
  kF22=SDL_SCANCODE_F22;
  kF23=SDL_SCANCODE_F23;
  kF24=SDL_SCANCODE_F24;
  kExecute=SDL_SCANCODE_EXECUTE;
  kHelp=SDL_SCANCODE_HELP;
  kMenu=SDL_SCANCODE_MENU;
  kSelect=SDL_SCANCODE_SELECT;
  kStop=SDL_SCANCODE_STOP;
  kAgain=SDL_SCANCODE_AGAIN;
  kUndo=SDL_SCANCODE_UNDO;
  kCut=SDL_SCANCODE_CUT;
  kCopy=SDL_SCANCODE_COPY;
  kPaste=SDL_SCANCODE_PASTE;
  kFind=SDL_SCANCODE_FIND;
  kMute=SDL_SCANCODE_MUTE;
  kVolumeUp=SDL_SCANCODE_VOLUMEUP;
  kVolumeDown=SDL_SCANCODE_VOLUMEDOWN;

  kInt1=SDL_SCANCODE_INTERNATIONAL1;
  kInt2=SDL_SCANCODE_INTERNATIONAL2;
  kInt3=SDL_SCANCODE_INTERNATIONAL3;
  kInt4=SDL_SCANCODE_INTERNATIONAL4;
  kInt5=SDL_SCANCODE_INTERNATIONAL5;
  kInt6=SDL_SCANCODE_INTERNATIONAL6;
  kInt7=SDL_SCANCODE_INTERNATIONAL7;
  kInt8=SDL_SCANCODE_INTERNATIONAL8;
  kInt9=SDL_SCANCODE_INTERNATIONAL9;
  kLang1=SDL_SCANCODE_LANG1;
  {SDL_SCANCODE_LANG2 = 145
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
  kCtrl = 224;
  kLCtrl = 224;
  kRCtrl = 228;
  kLCtrlMod=kMod_LCtrl;
  kRCtrlMod=kMod_RCtrl;

  kShift = 225;
  kLShift = 225;
  kRShift = 229;
  kLShiftMod=kMod_LShift;
  kRShiftMod=kMod_RShift;

  kAlt = 226;
  kLAlt = 226;
  kRAlt = 230;
  kLAltMod=kMod_LAlt;
  kRAltMod=kMod_RAlt;

  kGui = 227;
  kLGui = 227;
  KRGui = 231;
  kLGuiMod=kMod_LGui;
  kRGuiMod=kMod_RGui;

type tkey=record
           key:tsdl_keysym;
           mod_:word;
          end;
     pBool=^boolean;
 var keys:pBool; mousex,mousey,mouseScrollHor,mouseScrollVert:Longint; mousebutton,countmousebuttonspressed:integer;
     lastkey:tkey;
 Procedure InputInit;
 Procedure InputUpdate;
 Function ReadKey(var x:ansistring; var keymod:word):integer;
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
     if Event^.type_=SDL_MOUSEWHEEL then
      begin
       mouseScrollHor:=Event^.wheel.x;
       mouseScrollVert:=event^.wheel.y;
      end
      else
      begin
       mouseScrollHor:=0;
       mouseScrollVert:=0;
      end;
    end;
   dispose(event);
  end;
 Function readkey(var x:ansistring;var keymod:word):integer;
  begin
   if lastkey.key.sym<>-1 then
    begin
     readkey:=lastkey.key.scancode;
     keymod:=lastkey.mod_;
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
   keys:=pBool(SDL_GetKeyboardState(nil));
   lastkey.key.sym:=-1;
   SDL_PumpEvents;
   mousebutton:=0;
   mouseScrollHor:=0;
   mouseScrollVert:=0;
   countmousebuttonspressed:=0;
   inputupdate;
  end;
begin
end.
