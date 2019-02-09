{ VesaSDL.pas - main part of VesaSDL module
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
Unit VesaSDL;
Interface
 Uses SDL2,SDL2_image,SDL2_ttf,SDL2_gfx;
 Const
  {windowed modes}
  M640x400=$100;
  M640x480=$101;
  M800x600=$103;
  M1024x768=$105;
  M1280x1024=$107;
  M1920x1080=$108;
  {fullscreen modes;}
  M640x400f=$500;
  M640x480f=$501;
  M800x600f=$503;
  M1024x768f=$505;
  M1280x1024f=$507;
  M1920x1080f=$508;

  NormalPut=0;
  ShadowPut=8;

  LightShadow=192;
  MediumShadow=128;
  DarkShadow=100;

  Flip_None = SDL_FLIP_NONE;
  Flip_Hor  = SDL_FLIP_HORIZONTAL;
  Flip_Vert = SDL_FLIP_VERTICAL;

  {Text styles, to combine is you can just OR they
   Like Bold and Underline will be - 'TextBold OR TextUnderline'}
   TextNormal=0; TextBold=1; TextItalic=2; TextUnderline=4; TextStrikeThrough=8;

 Type
  tColor=tSDL_Color;
  {tSDL_Color=record
               r,g,b,a:byte;
              end;
  }
  img=record
       image:pSDL_texture;
       rect:tSDL_Rect;
      end;
  pimg=^img;
 {System}
  Procedure ChangeDebug(b:boolean);{Default = false; Show debug messages}
  Procedure InitSDL;{Init SDL2 only}
  Procedure InitWindow(full:boolean;name_:ansistring);{Create only window,to set size change apw and aph}
  Procedure InitAll(mode:word);{Init sdl and window with selected mode}
  Procedure InitAll(mode:word; Name_:ansistring);{Init sdl and window with selected mode}
  Procedure InitAllX(x,y:word;full:boolean;Name_:ansistring);{Same but with custom settings}
  Procedure ChangeWindowResolution(w,h:word);{Change window resolution; Better to ClearScreen or just redraw it}
  Procedure SetWindowFullscreen(FullscreenType:integer);{0 - windowed, 1 - fake fullscreen(window to borderless with desktop size
                                                        2 - real fullscreen(with videomode change)}
  Procedure DoneAll;{Destroy window and done SDL2}
  Procedure Delay(n:longword);{Sleep for n ms}


 {Mouse}
  Procedure HideMouse;
  Procedure ShowMouse;
  Procedure ShowCursor(toggle:integer);{0 - hide, 1 - show}
  Procedure SetUserCursor(pathToCursor:ansistring; hotX,hotY:integer);
  Procedure SetStandartCursor;

 {Drawing on screen}
  Procedure UpdateScreen;
  Procedure ClearScreen;
  Procedure SetWSize(x1,y1,x2,y2:integer);{Set output size(ViewPort)}
  Procedure GetWSize(var x1,y1,x2,y2:integer);


 {Gui primitives}

  Procedure SetButtonColorRGBA(r,g,b,a:integer);
  Procedure SetButtonColor(q:integer);
  Procedure SetEditColorRGBA(r,g,b,a:integer);
  Procedure SetEditColor(q:integer);
  Procedure SetWindowColorRGBA(r,g,b,a:integer);
  Procedure SetWindowColor(q:integer);
  Procedure SetLabelColorRGBA(r,g,b,a:integer);
  Procedure SetLabelColor(q:integer);

  Procedure SetWindowTexture(Path:ansistring);
  Procedure SetButtonTexture(Path:ansistring);
  Procedure SetLabelTexture(Path:ansistring);
  Procedure SetEditTexture(Path:ansistring);

  Function GetButtonTexture:ansistring;
  Function GetWindowTexture:ansistring;
  Function GetLabelTexture:ansistring;
  Function GetEditTexture:ansistring;

  Procedure DrawTexture(x1,y1,x2,y2:integer; tex:pImg);
  Procedure DrawEdit(x1,y1,x2,y2:integer; text:ansistring);
  Procedure DrawButton(x1,y1,x2,y2:integer; label_:ansistring;pressed,focused:boolean);
  Procedure DrawPicButton(x1,y1,x2,y2:integer; label_:ansistring;pressed,focused:boolean; p:pointer; sx,sy:integer);
  Procedure DrawWindow(x1,y1,x2,y2:integer);
  Procedure DrawLabel(x1,y1,x2,y2:integer; text:ansistring);
  Procedure DrawScreen(x1,y1,x2,y2:integer; name:ansistring);
  Procedure Ramka(x1,y1,x2,y2:integer);


 {Graphics primitives}
  Procedure SetColorRGBA(r,g,b,a:integer);{Set color for graphics primitives}
  Procedure SetColor(q:integer);{Same, but color sets in old module vesa palette}
  Procedure PutPixelRGBA(x,y,r,g,b,a:integer);
  Procedure PutPixel(x,y,c:integer);
  Procedure Line(x1,y1,x2,y2:integer);
  Procedure Rectangle(x1,y1,x2,y2:integer);
  Procedure Rectangle(x1,y1,x2,y2:integer;Color1,Color2:byte);
  Procedure Bar(x1,y1,x2,y2:integer);
  Procedure Ellipse(x,y,rx,ry:integer);
  Procedure FillEllipse(x,y,rx,ry:integer);
  Procedure Circle(x,y,r:integer);
  Procedure CircleF(x,y,r:integer);
  Function GetPixel(x,y:integer):tColor;

 {Drawing text}

  Procedure LoadFont(name_:ansistring; ptsize:longint; Style:word);{You must load font before draw text by OutTextXY!!}
  Procedure OutTextXY(x,y:integer; text:ansistring);
  Procedure OutTextXYColored(x,y:integer; text:ansistring; r,g,b,a:integer);
  Function TextWidth(s:ansistring):word;{Get Width of current text}
  Function TextHeight(s:ansistring):word;{Get Height of current text}

  Function LoadFontToPtr(name_:ansistring; ptsize:longint; style:word):pointer;{Uses for load more than 1 font}
  Procedure DestroyFont(font:pointer);{Every font, loaded by LoadFontToPtr, MUST be destroyed when programm ends}
  Procedure OutTextXYWF(x,y:integer; text:ansistring; font:pointer);
  Procedure OutTextXYWFColored(x,y:integer; text:ansistring; r,g,b,a:integer; font:pointer);
  Function TextWidthWF(s:ansistring; font:pointer):word;{Get Width of current text with custom font}
  Function TextHeightWF(s:ansistring; font:pointer):word;{Get Height of current text with custom font}


  Procedure SetTextColor(q:integer);{Only for outTextXYWF}
  Procedure SetTextColorRGBA(r,g,b,a:integer);


 {Images}
  Procedure DestroyImage(var img:pointer);
  Function LoadImage(s:ansistring):pointer;{Load new formats of images (JPG,PNG,TIF)}
  Function LoadImage1(s:ansistring):pointer;{For backward compatibility}

  {PutImage}
  Procedure PutImage1(x,y:integer; a:pointer);{Draw it}
  Procedure PutImage(x,y:integer;p:pimg;type_:byte);
  {      Type_=NormalPut - just draw image
         Type_=ShadowPut - draw shadow of image}
  Procedure PutImage(x,y:integer; p:pimg);
  Procedure PutImage(x,y:integer; p:pimg; type_:byte; angle:double; centerX, centerY:integer);
  Procedure PutImage(x,y:integer; p:pimg; type_:byte; angle:double; centerX, centerY, flip:integer);
  Procedure SetShadowMode(SM:byte);

  Procedure PictureFromFile(x,y:integer; Filename:ansistring);

  Procedure PutSprite(x,y:integer; p:pointer);{For backward compatibility}

  Function LoadSpr(s:string):pointer;{Loading old sprites from vesa module}
  Function LoadSpr1(var f:file):pointer;{Same but load from file variable}

  {Backward compatibility}
  Procedure SetVisualPage(Page:word);
  Procedure SetActivePage(Page:word);

const{This is palette for compatibility with old Vesa Module}
     {It may be change in future versions}
 pal:array[0..255] of tsdl_color=(
 (r:123; g:123; b:123; a:0),(r:0; g:0; b:168; a:255),(r:0; g:168; b:0; a:255),
 (r:0; g:168; b:168; a:255),(r:168; g:0; b:0; a:255),(r:168; g:0; b:168; a:255),(r:168; g:84; b:0; a:255),
 (r:168; g:168; b:168; a:255),(r:84; g:84; b:84; a:255),(r:84; g:84; b:255; a:255),(r:84; g:255; b:84; a:255),
 (r:84; g:255; b:255; a:255),(r:255; g:84; b:84; a:255),(r:255; g:84; b:255; a:255),(r:255; g:255; b:84; a:255),
 (r:255; g:255; b:255; a:255),(r:255; g:255; b:255; a:255),(r:240; g:240; b:240; a:255),(r:232; g:232; b:232; a:255),
 (r:220; g:220; b:220; a:255),(r:212; g:212; b:212; a:255),(r:200; g:200; b:200; a:255),(r:192; g:192; b:192; a:255),
 (r:180; g:180; b:180; a:255),(r:172; g:172; b:172; a:255),(r:164; g:164; b:164; a:255),(r:152; g:152; b:152; a:255),
 (r:144; g:144; b:144; a:255),(r:132; g:132; b:132; a:255),(r:124; g:124; b:124; a:255),(r:112; g:112; b:112; a:255),
 (r:104; g:104; b:104; a:255),(r:92; g:92; b:92; a:255),(r:84; g:84; b:84; a:255),(r:72; g:72; b:72; a:255),
 (r:64; g:64; b:64; a:255),(r:56; g:56; b:56; a:255),(r:44; g:44; b:44; a:255),(r:36; g:36; b:36; a:255),
 (r:24; g:24; b:24; a:255),(r:16; g:16; b:16; a:255),(r:4; g:4; b:4; a:255),(r:2; g:2; b:2; a:255),
 (r:255; g:236; b:220; a:255),(r:240; g:220; b:200; a:255),(r:232; g:208; b:184; a:255),(r:224; g:196; b:168; a:255),
 (r:216; g:184; b:152; a:255),(r:208; g:168; b:136; a:255),(r:200; g:160; b:120; a:255),(r:192; g:148; b:108; a:255),
 (r:184; g:136; b:96; a:255),(r:172; g:124; b:84; a:255),(r:164; g:112; b:72; a:255),(r:156; g:104; b:60; a:255),
 (r:148; g:96; b:52; a:255),(r:140; g:84; b:44; a:255),(r:132; g:76; b:32; a:255),(r:124; g:68; b:28; a:255),
 (r:116; g:60; b:20; a:255),(r:104; g:52; b:16; a:255),(r:96; g:48; b:12; a:255),(r:88; g:40; b:8; a:255),
 (r:80; g:36; b:4; a:255),(r:72; g:28; b:4; a:255),(r:60; g:24; b:0; a:255),(r:52; g:20; b:0; a:255),
 (r:44; g:16; b:0; a:255),(r:36; g:12; b:0; a:255),(r:192; g:204; b:255; a:255),(r:172; g:184; b:240; a:255),
 (r:152; g:168; b:232; a:255),(r:136; g:152; b:224; a:255),(r:120; g:136; b:216; a:255),(r:104; g:120; b:208; a:255),
 (r:88; g:104; b:196; a:255),(r:76; g:88; b:188; a:255),(r:64; g:76; b:180; a:255),(r:52; g:64; b:172; a:255),
 (r:40; g:52; b:164; a:255),(r:32; g:48; b:152; a:255),(r:28; g:40; b:144; a:255),(r:20; g:36; b:136; a:255),
 (r:16; g:32; b:128; a:255),(r:12; g:28; b:120; a:255),(r:8; g:24; b:112; a:255),(r:4; g:20; b:100; a:255),
 (r:4; g:20; b:92; a:255),(r:0; g:16; b:84; a:255),(r:0; g:12; b:76; a:255),(r:0; g:12; b:68; a:255),
 (r:172; g:224; b:156; a:255),(r:156; g:212; b:140; a:255),(r:144; g:204; b:128; a:255),(r:128; g:192; b:112; a:255),
 (r:116; g:184; b:100; a:255),(r:104; g:176; b:92; a:255),(r:92; g:164; b:80; a:255),(r:80; g:156; b:68; a:255),
 (r:72; g:144; b:60; a:255),(r:60; g:136; b:48; a:255),(r:52; g:124; b:40; a:255),(r:44; g:116; b:36; a:255),
 (r:36; g:108; b:28; a:255),(r:32; g:100; b:24; a:255),(r:24; g:92; b:20; a:255),(r:20; g:84; b:12; a:255),
 (r:12; g:76; b:8; a:255),(r:8; g:64; b:4; a:255),(r:4; g:56; b:4; a:255),(r:4; g:48; b:0; a:255),
 (r:0; g:40; b:0; a:255),(r:0; g:32; b:0; a:255),(r:0; g:24; b:0; a:255),(r:255; g:244; b:208; a:255),
 (r:248; g:232; b:172; a:255),(r:244; g:224; b:140; a:255),(r:240; g:220; b:108; a:255),(r:236; g:212; b:80; a:255),
 (r:232; g:204; b:52; a:255),(r:228; g:200; b:20; a:255),(r:224; g:196; b:0; a:255),(r:216; g:188; b:32; a:255),
 (r:208; g:176; b:28; a:255),(r:200; g:160; b:24; a:255),(r:188; g:152; b:24; a:255),(r:182; g:142; b:24; a:255),
 (r:168; g:124; b:20; a:255),(r:156; g:112; b:16; a:255),(r:148; g:100; b:12; a:255),(r:136; g:88; b:12; a:255),
 (r:124; g:76; b:8; a:255),(r:116; g:68; b:8; a:255),(r:104; g:60; b:0; a:255),(r:96; g:48; b:0; a:255),
 (r:84; g:40; b:0; a:255),(r:76; g:32; b:0; a:255),(r:228; g:204; b:248; a:255),(r:216; g:188; b:236; a:255),
 (r:200; g:168; b:228; a:255),(r:192; g:156; b:216; a:255),(r:180; g:140; b:208; a:255),(r:168; g:124; b:196; a:255),
 (r:156; g:112; b:188; a:255),(r:144; g:100; b:180; a:255),(r:132; g:88; b:168; a:255),(r:120; g:76; b:160; a:255),
 (r:112; g:68; b:148; a:255),(r:100; g:56; b:140; a:255),(r:92; g:48; b:128; a:255),(r:80; g:40; b:120; a:255),
 (r:72; g:32; b:108; a:255),(r:64; g:24; b:100; a:255),(r:56; g:20; b:92; a:255),(r:44; g:8; b:80; a:255),
 (r:32; g:4; b:68; a:255),(r:24; g:0; b:56; a:255),(r:16; g:0; b:44; a:255),(r:180; g:244; b:255; a:255),
 (r:168; g:232; b:240; a:255),(r:160; g:224; b:232; a:255),(r:148; g:216; b:224; a:255),(r:136; g:204; b:212; a:255),
 (r:128; g:196; b:204; a:255),(r:120; g:184; b:196; a:255),(r:112; g:176; b:188; a:255),(r:100; g:168; b:176; a:255),
 (r:92; g:156; b:168; a:255),(r:88; g:148; b:160; a:255),(r:81; g:142; b:150; a:255),(r:72; g:128; b:140; a:255),
 (r:64; g:116; b:128; a:255),(r:56; g:104; b:116; a:255),(r:48; g:96; b:108; a:255),(r:40; g:84; b:96; a:255),
 (r:32; g:76; b:88; a:255),(r:28; g:64; b:76; a:255),(r:20; g:56; b:64; a:255),(r:16; g:44; b:56; a:255),
 (r:12; g:36; b:44; a:255),(r:8; g:28; b:36; a:255),(r:255; g:228; b:228; a:255),(r:244; g:208; b:208; a:255),
 (r:240; g:188; b:188; a:255),(r:232; g:172; b:172; a:255),(r:228; g:156; b:156; a:255),(r:220; g:140; b:140; a:255),
 (r:216; g:124; b:124; a:255),(r:208; g:108; b:108; a:255),(r:204; g:92; b:92; a:255),(r:196; g:80; b:80; a:255),
 (r:192; g:68; b:68; a:255),(r:188; g:56; b:56; a:255),(r:184; g:44; b:44; a:255),(r:180; g:0; b:0; a:255),
 (r:168; g:32; b:32; a:255),(r:156; g:24; b:24; a:255),(r:144; g:16; b:16; a:255),(r:132; g:12; b:12; a:255),
 (r:120; g:8; b:8; a:255),(r:108; g:4; b:4; a:255),(r:96; g:0; b:0; a:255),(r:84; g:0; b:0; a:255),
 (r:72; g:0; b:0; a:255),(r:255; g:228; b:156; a:255),(r:248; g:216; b:140; a:255),(r:244; g:208; b:124; a:255),
 (r:240; g:196; b:112; a:255),(r:236; g:184; b:96; a:255),(r:232; g:172; b:80; a:255),(r:228; g:160; b:68; a:255),
 (r:224; g:144; b:56; a:255),(r:224; g:132; b:44; a:255),(r:204; g:116; b:32; a:255),(r:184; g:100; b:24; a:255),
 (r:164; g:88; b:16; a:255),(r:148; g:72; b:8; a:255),(r:128; g:60; b:4; a:255),(r:108; g:48; b:0; a:255),
 (r:92; g:40; b:0; a:255),(r:0; g:0; b:0; a:255),(r:0; g:0; b:0; a:255),(r:0; g:0; b:0; a:255),
 (r:0; g:0; b:0; a:255),(r:0; g:0; b:0; a:255),(r:0; g:0; b:0; a:255),(r:0; g:0; b:0; a:255),
 (r:0; g:0; b:0; a:255),(r:0; g:0; b:0; a:255),(r:0; g:0; b:0; a:255),(r:0; g:0; b:0; a:255),
 (r:0; g:0; b:0; a:255),(r:0; g:0; b:0; a:255),(r:0; g:0; b:0; a:255),(r:0; g:0; b:0; a:255),
 (r:0; g:0; b:0; a:255),(r:0; g:0; b:0; a:255),(r:0; g:0; b:0; a:255),(r:0; g:0; b:0; a:255),
 (r:0; g:0; b:0; a:255),(r:0; g:0; b:0; a:255),(r:0; g:0; b:0; a:255),(r:0; g:0; b:0; a:255),
 (r:0; g:0; b:0; a:255),(r:0; g:0; b:0; a:255),(r:0; g:0; b:0; a:255),(r:0; g:0; b:0; a:255),
 (r:0; g:0; b:0; a:255),(r:0; g:0; b:0; a:255),(r:0; g:0; b:0; a:255),(r:0; g:0; b:0; a:255),
 (r:0; g:0; b:0; a:255),(r:0; g:0; b:0; a:255),(r:0; g:0; b:0; a:255),(r:0; g:0; b:0; a:255),
 (r:0; g:0; b:0; a:255));
 var apw,aph:integer;{Width and height of application windown}
     currentCursor:pSDL_CURSOR;
     
     window : pointer;
     render : pointer;
     font : pointer;
     
Implementation
 const
       {$ifdef ENDIAN_BIG}
         rmask:longword=$ff000000;
         gmask:longword=$00ff0000;
         bmask:longword=$0000ff00;
         amask:longword=$000000ff;
       {$else}
         rmask:longword=$000000ff;
         gmask:longword=$0000ff00;
         bmask:longword=$00ff0000;
         amask:longword=$ff000000;
       {$endif}
 var color,TextColor,buttoncolor,windowcolor,labelcolor,editcolor:tcolor;
     buttonTexture,windowTexture,labelTexture,editTexture:pointer;
     buttonTextureName,windowTextureName,labelTextureName,editTextureName:ansistring;
     debug:boolean;
     shadowMode:byte;
procedure setcolorRGBA(r,g,b,a:integer);
 begin
  color.r:=r;
  color.g:=g;
  color.b:=b;
  color.a:=a;
  SDL_SetRenderDrawColor( render, r, g, b, a );
 end;

Procedure SetColor(q:integer);
 begin
  setcolorRGBA(pal[q].r,pal[q].g,pal[q].b,pal[q].a);
 end;

Procedure SetTextColorRGBA(r,g,b,a:integer);
 begin
  TextColor.R:=r;
  TextColor.G:=g;
  TextColor.B:=b;
  TextColor.A:=a;
 end;

Procedure SetTextColor(q:integer);
 begin
  SetTextColorRGBA(pal[q].r,pal[q].g,pal[q].b,pal[q].a);
 end;

Procedure ClearScreen;
 begin
  SDL_SetRenderDrawColor( render, 0, 0, 0, 255 );
  SDL_RenderClear(render);
  SDL_SetRenderDrawColor( render, color.r, color.g, color.b, color.a );
 end;


Procedure PutpixelRGBA(x,y,r,g,b,a:integer);
 begin
  SDL_SetRenderDrawColor(render,r,g,b,a);
  SDL_RenderDrawPoint(render,x,y);
  SDL_SetRenderDrawColor(render,color.r,color.g,color.b,color.a);
 end;
procedure PutPixel(x,y,c:integer);
 begin
  PutPixelRGBA(x,y,pal[c].r,pal[c].g,pal[c].b,pal[c].a);
 end;
 
Procedure ShowCursor(toggle:integer);
 begin
  SDL_ShowCursor(toggle);
 end;
Procedure HideMouse;
 begin
  ShowCursor(0);
 end;
Procedure ShowMouse;
 begin
  ShowCursor(1);
 end;
Procedure SetUserCursor(pathToCursor:ansistring; hotX,hotY:integer);
 var surf:pSDL_Surface;
 begin
  if currentCursor<>nil then
   begin
    SDL_FreeCursor(currentCursor);
  currentCursor:=nil;
   end;
  surf:=IMG_Load(pchar(ansistring(pathToCursor)));
  currentCursor:=SDL_CreateColorCursor(surf,hotx,hoty);
  SDL_SetCursor(currentCursor);
  SDL_FreeSurface(surf);
 end;
Procedure SetStandartCursor;
 var curs:pSDL_CURSOR;
 begin
  if currentCursor<>nil then 
   begin
    SDL_FreeCursor(currentCursor);
  currentCursor:=nil;
   end;
  curs:=SDL_GetDefaultCursor;
  SDL_SetCursor(curs);
 end;

procedure Line(x1,y1,x2,y2:integer);
 begin
  SDL_RenderDrawLine(render,x1,y1,x2,y2);
 end;

Procedure Rectangle(x1,y1,x2,y2:integer);
 begin
  rectangleRGBA(render,x1,y1,x2,y2,color.r,color.g,color.b,color.a);
 end;

Procedure Rectangle(x1,y1,x2,y2:integer; Color1, Color2:byte);
 var oldColor:tSDL_Color;
 begin
  oldColor:=color;
  setcolor(color2);
  Line(x1,y2,x2,y2);
  Line(x2,y1,x2,y2);
  setcolor(color1);
  Line(x1,y1,x2,y2);
  Line(x1,y1,x1,y2);
  setcolorRGBA(oldColor.r,oldColor.g,oldcolor.b,oldColor.a);
 end;

Procedure Bar(x1,y1,x2,y2:integer);
 begin
  boxRGBA(render,x1,y1,x2,y2,color.r,color.g,color.b,color.a);
 end;

Procedure Ellipse(x,y,rx,ry:integer);
 begin
  ellipseRGBA(render,x,y,rx,ry,color.r,color.g,color.b,color.a);
 end;
procedure FillEllipse(x,y,rx,ry:integer);
 begin
   filledEllipseRGBA(render,x,y,rx,ry,color.r,color.g,color.b,color.a);
 end;
Procedure Circle(x,y,r:integer);
 begin
   circleRGBA(render,x,y,r,color.r,color.g,color.b,color.a);
 end;

Procedure Circlef(x,y,r:integer);
 begin
  filledCircleRGBA(render,x,y,r,color.r,color.g,color.b,color.a);
 end;

Procedure OutError;
 begin
  writeln('Some error happened');
  halt(1);
 end;


Function LoadFontToPtr(name_:ansistring; ptsize:longint; Style:word):pointer;
 var font:pointer;
 begin
  font:=TTF_OpenFont(pchar(name_),ptsize);
  if (font<>nil) and (debug) then writeln('Font ',name_,' successfully loaded')
   else
    if font=nil then OutError;
  TTF_SetFontStyle(font,Style);
  LoadFontToPtr:=font;
 end;

Procedure DestroyFont(font:pointer);
 begin
  if font<>nil then
   TTF_CloseFont(font);
 end;

Procedure LoadFont(name_:ansistring; ptsize:longint; Style:word);
 begin
  if font<>nil then TTF_CloseFont(font);
  font:=LoadFontToPtr(pchar(name_),ptsize,Style);
 end;

Procedure SetWSize(x1,y1,x2,y2:integer);
 var tmp:pSDL_Rect;
 begin
  new(tmp);
  tmp^.x:=x1;
  tmp^.y:=y1;
  tmp^.w:=x2-x1;
  tmp^.h:=y2-y1;
  SDL_RenderSetViewPort(render,tmp);
  dispose(tmp);
 end;
 
 Procedure GetWSize(var x1,y1,x2,y2:integer);
 var tmp:pSDL_Rect;
 begin
  new(tmp);
  SDL_RenderGetViewPort(render,tmp);
  x1:=tmp^.x;
  y1:=tmp^.y;
  x2:=x1+tmp^.w;
  y2:=y1+tmp^.h;
  dispose(tmp);
 end;

Procedure InitMode(mode:word);
 begin
  case mode of
    $100,$500:begin
               apw:=640;
               aph:=400;
              end;
    $101,$501:begin
               apw:=640;
               aph:=480;
              end;
    $103,$503:begin
               apw:=800;
               aph:=600;
              end;
    $105,$505:begin
               apw:=1024;
               aph:=768;
              end;
    $107,$507:begin
               apw:=1280;
               aph:=1024;
              end;
    $108,$508:begin
               apw:=1920;
               aph:=1080;
              end;
   end;
 end;
Procedure InitSDL;
 begin
 if SDL_Init(SDL_INIT_VIDEO)<>0 then
    OutError
    else
    if debug then writeln('Successfully loaded SDL2');
 end;
procedure InitWindow(full:boolean;name_:ansistring); 
 begin
   InitSDL;
   window:=SDL_CreateWindow(pchar(name_),SDL_WINDOWPOS_CENTERED,SDL_WINDOWPOS_CENTERED,apw,aph,(SDL_WINDOW_SHOWN) or (SDL_WINDOW_OPENGL));
   if full then
    SDL_SetWindowFullscreen(window,SDL_WINDOW_FULLSCREEN);
   if window=nil then
    OutError
    else
    if debug then writeln('Successfully created window');
    render:=SDL_CreateRenderer(window, -1, (SDL_RENDERER_ACCELERATED or SDL_RENDERER_PRESENTVSYNC));
    if render=nil then
         OutError
     else
      if debug then writeln('Successfully created sdl_render');
   SDL_SetRenderDrawBlendMode( Render, SDL_BLENDMODE_blend );
   TTF_INIT;
   font:=nil;
   buttonTexture:=nil;
   windowTexture:=nil;
   labelTexture:=nil;
   editTexture:=nil;
   buttonTextureName:='';
   windowTextureName:='';
   labelTextureName:='';
   editTextureName:='';
   SetColorRGBA(0,0,0,255);
   SetWSize(0,0,apw,aph);
   SetTextColor(15);
   SetColor(15);
   ClearScreen;
   UpdateScreen;
   IMG_Init(IMG_INIT_JPG or IMG_INIT_PNG or IMG_INIT_TIF);
   if debug then writeln(IMG_GetError);
   if debug then Writeln('Everything Done. Ready to work.')
end;

Procedure InitAll(mode:word; Name_:ansistring);
 var full:boolean;
 begin
  InitMode(mode);
  if mode>=$500 then
   full:=true else full:=false;
  InitWindow(full,Name_);
 end;

Procedure InitAll(mode:word);
 begin
  InitAll(mode,'VesaSDL app');
 end;

Procedure InitAllX(x,y:word;full:boolean;name_:ansistring);
 begin
  apw:=x;
  aph:=y;
  InitWindow(full,Name_);
 end;

Procedure ChangeWindowResolution(w,h:word);
 begin
  apw:=w;
  aph:=h;
  SDL_SetWindowSize(window,w,h);
 end;

Procedure SetWindowFullscreen(FullscreenType:integer); 
 begin
  case fullscreenType of
   0:SDL_SetWindowFullscreen(window,0);
   1:SDL_SetWindowFullscreen(window,SDL_WINDOW_FULLSCREEN_DESKTOP);
   2:SDL_SetWindowFullscreen(window,SDL_WINDOW_FULLSCREEN);
  end;
 end;

function TextWidthWF(s:ansistring; font:pointer):word;
var t , t1 : longint;
begin
  TTF_SizeUTF8(font, pansichar(s), addr(t), addr(t1));
  TextWidthWF := t;
end;

function TextHeightWF(s:ansistring; font:pointer):word;
var t, t1 : longint;
begin
  TTF_SizeUTF8(font, pansichar(s), addr(t), addr(t1));
  TextHeightWF:=t1;
end;

Function TextWidth(S:ansistring):word;
 begin
  textWidth:=textWidthWF(s,font);
 end;

Function TextHeight(s:ansistring):word;
 begin
  textHeight:=textHeightWF(s,font);
 end;

procedure Render_Text(x,y:integer;text:ansistring; color:tSDL_Color; font:pointer);
 var surf:pSDL_Surface; tex:pSDL_Texture; rect:tSDL_Rect;
 begin
  if (text<>'') and (font<>nil) then
   begin
{    color.r:=r;
    color.g:=g;
    color.b:=b;}
    surf:=TTF_RenderUTF8_Solid(font,pchar(text),color);
    tex:=SDL_CreateTextureFromSurface(render,surf);
    rect.x:=x;
    rect.y:=y;
    rect.w:=surf^.w;
    rect.h:=surf^.h;
    SDL_RenderCopy(render,tex,nil,@rect);
    SDL_FreeSurface(surf);
    SDL_DestroyTexture(tex);
   end;
  if (font=nil) and (debug) then
   writeln('Font dont loaded');
 end;

Procedure OutTextXYColored(x,y:integer; text:ansistring; r,g,b,a:integer);
 var color:tSDL_color;
 begin
  color.r:=r;color.b:=b;color.g:=g;color.a:=a;
  Render_Text(x,y,text,color,font);
 end;

Procedure OutTextXY(x,y:integer; text:ansistring);
 begin
  Render_Text(x,y,text,Color,font);
 end;

Procedure OutTextXYWFColored(x,y:integer; text:ansistring; r,g,b,a:integer; font:pointer);
 var color:tSDL_color;
 begin
  color.r:=r;color.b:=b;color.g:=g;color.a:=a;
  Render_Text(x,y,text,color,font);
 end;

Procedure OutTextXYWF(x,y:integer; text:ansistring; font:pointer);
 begin
  Render_Text(x,y,text,TextColor,font);
 end;

Procedure DoneAll;
 begin
  if currentCursor<>nil then 
   SDL_FreeCursor(currentCursor);
  if  buttonTexture<>nil then
   begin
    SDL_DestroyTexture(pImg(buttonTexture)^.image);
    dispose(pImg(buttonTexture));
   end;
  if  windowTexture<>nil then
   begin
    SDL_DestroyTexture(pImg(windowTexture)^.image);
    dispose(pImg(windowTexture));
   end;
  if  labelTexture<>nil then
   begin
    SDL_DestroyTexture(pImg(labelTexture)^.image);
    dispose(pImg(labelTexture));
   end;
  if  editTexture<>nil then
   begin
    SDL_DestroyTexture(pImg(editTexture)^.image);
    dispose(pImg(editTexture));
   end;
  if font<>nil then
   TTF_CloseFont(font);
  TTF_Quit;
  IMG_Quit;
  SDL_DestroyWindow(window);
  SDL_Quit();
 end;

Procedure Delay(n:longword);
 begin
  SDL_Delay(n);
 end;

Procedure DestroyImage(var img:pointer);
 begin
  if img<>nil then
   begin
    SDL_DestroyTexture(pImg(img)^.image);
    dispose(pImg(img));
    img:=nil;
   end;
 end;

Function LoadImage(s:ansistring):pointer;
 var q:psdl_surface; w:psdl_texture; a:^img;
 begin
  q:=Img_Load(pchar(s));
  if (q=nil) then
   begin
    writeln(Img_GetError);
    halt(1);
   end;
  w:=SDL_CreateTextureFromSurface(render,q);
  if (w=nil) then
   begin
    writeln(SDL_getError);
    halt(1);
   end;
  new(a);
  a^.rect.w:=q^.w;
  a^.rect.h:=q^.h;
  a^.image:=w;
  SDL_freesurface(q);
  LoadImage:=a;
 end;
 
Function LoadImage1(s:ansistring):pointer; 
 begin
  LoadImage1:=LoadImage(s);
 end;

Procedure PutImage1(x,y:integer; a:pointer);
 var p:^img; curCol:tColor;
 begin
  curCol:=color;
  SetColorRGBA(255,255,255,255);
  p:=a;
  p^.rect.x:=x;
  p^.rect.y:=y;
  SDL_RenderCopy(render,p^.image,nil,@p^.rect);
  SetColorRGBA(curCol.r,curCol.g,curCol.b,curCol.a);
 end;

function _get_pixel32(surf:psdl_surface;x,y:integer):uint32;
 var pixels:puint32;
 begin
  pixels:=puint32(surf^.pixels);
  _get_pixel32:=pixels[(y*surf^.w)+x];
 end;

procedure _put_pixel32(surf:tsdl_surface;x,y:integer;pxl:uint32);
 var pixels:puint32;
 begin
  pixels:=puint32(surf.pixels);
  pixels[(y*surf.w)+x]:=pxl;
 end;

Function Loadspr1(var f:file):pointer;
 type par=array of longword;
      par1=array of word;
 var i,j:word; realsize:longint; q:byte; spritex,spritey:word;
 w:psdl_surface; s:psdl_texture; aa:^img; asd:longword; qq:boolean;
 c,b,n:longword;
 begin
  BlockRead(f,spritex,2);
  BlockRead(f,spritey,2);
  BlockRead(f,realsize,2);
  BlockRead(f,q,2);
  blockread(f,q,2);
  w:=SDL_CreateRGBSurface(0,spritex,spritey,32,rmask,gmask,bmask,amask);
  if SDL_MustLock(w) then
   begin
    SDL_LockSurface(w);
    qq:=true;
   end;
  if w=nil then
   begin
    writeln('Error gen surface');
    halt(1);
   end;
  for j:=0 to spritey-1 do
   for i:=0 to spritex-1 do
    begin
     blockread(f,q,1);
     c:=pal[q].r;
     b:=pal[q].g;
     n:=pal[q].b;
     if pal[q].a<>0 then
      asd:=255
      else
      asd:=0;
     {$ifdef ENDIAN_BIG}
     _put_pixel32(w^,i,j,(c shl 24)or (b shl 16) or (n shl 8) or asd);
     {$else}
     _put_pixel32(w^,i,j,c or (b shl 8) or (n shl 16) or (asd shl 24));
     {$endif}
    end;
  if qq then
   SDL_UnlockSurface(w);
  s:=SDL_CreateTextureFromSurface(render,w);
  new(aa);
  aa^.rect.w:=w^.w;
  aa^.rect.h:=w^.h;
  aa^.image:=s;
   SDL_FreeSurface(w);
  LoadSpr1:=aa;
 end;

Function LoadSpr(s:string):pointer;
 var f:file;
 begin
  assign(f,s);
  reset(f,1);
  LoadSpr:=LoadSpr1(f);
  close(f);
 end;

Procedure PutImage(x,y:integer;p:pimg;type_:byte);
 begin
  if type_=shadowput then
   begin
    SDL_SetTextureAlphaMod(p^.image,192);
    SDL_SetTextureColorMod(p^.image,shadowMode,shadowMode,shadowMode);
   end;
  PutImage1(x,y,p);
  if type_=shadowput then
   begin
    SDL_SetTextureAlphaMod(p^.image,255);
    SDL_SetTextureColorMod(p^.image,255,255,255);
   end;
 end;


Procedure PutImage(x,y:integer; p:pimg);
 begin
  PutImage(x,y,p,NormalPut);
 end;

Procedure PutImage(x,y:integer; p:pimg; type_:byte; angle:double; centerX, centerY, flip:integer);
 var curCol:tColor; point:tSDL_Point;
 begin
  if type_=shadowput then
   begin
    SDL_SetTextureAlphaMod(p^.image,192);
    SDL_SetTextureColorMod(p^.image,shadowMode,shadowMode,shadowMode);
   end;

  curCol:=color;
  SetColorRGBA(255,255,255,255);
  p^.rect.x:=x;
  p^.rect.y:=y;
  point.x:=centerx;
  point.y:=centery;
  SDL_RenderCopyEx(render,p^.image,nil,@p^.rect,angle,@point,flip);
  SetColorRGBA(curCol.r,curCol.g,curCol.b,curCol.a);

  if type_=shadowput then
   begin
    SDL_SetTextureAlphaMod(p^.image,255);
    SDL_SetTextureColorMod(p^.image,255,255,255);
   end;
 end;

Procedure PutImage(x,y:integer; p:pimg; type_:byte; angle:double; centerX, centerY:integer);
 begin
  if type_=shadowput then
   begin
    SDL_SetTextureAlphaMod(p^.image,192);
    SDL_SetTextureColorMod(p^.image,shadowMode,shadowMode,shadowMode);
   end;
  PutImage(x,y,p,type_,angle,centerx,centery,FLIP_NONE);
  if type_=shadowput then
   begin
    SDL_SetTextureAlphaMod(p^.image,255);
    SDL_SetTextureColorMod(p^.image,255,255,255);
   end;
 end;

Procedure PictureFromFile(x,y:integer; FileName:ansistring);
 var Img:pointer;
 begin
  if (lowercase(copy(filename,length(filename)-2,3))='spr') or (lowercase(copy(filename,length(filename)-2,3))='tex')then
    img:=LoadSpr(filename)
   else
    img:=loadImage(filename);
  PutSprite(x,y,img);
  DestroyImage(img);
 end;

Procedure PutSprite(x,y:integer; p:pointer);
 begin
  PutImage(x,y,p,NormalPut);
 end;

Procedure UpdateScreen;
 begin
  SDL_RenderPresent(render);
 end;

Function GetPixel(x,y:integer):tColor;
 var curPix:Uint32;
     surf:pSDL_Surface;
 begin
  surf:=SDL_CreateRGBSurface(0,apw,aph,32,rmask,gmask,bmask,amask);
  SDL_RenderReadPixels(render,nil,SDL_PIXELFORMAT_ABGR8888,surf^.pixels,surf^.pitch);
  curPix:=_get_pixel32(surf,x,y);
  {$ifdef ENDIAN_BIG}
   GetPixel.r:=byte(curPix shr 24);
   GetPixel.g:=byte(curPix shr 16);
   GetPixel.b:=byte(curPix shr 8);
   GetPixel.a:=byte(curPix);
  {$else}
   GetPixel.a:=byte(curPix shr 24);
   GetPixel.b:=byte(curPix shr 16);
   GetPixel.g:=byte(curPix shr 8);
   GetPixel.r:=byte(curPix);
  {$endif}
  SDL_FreeSurface(surf);
 end;

Procedure SetShadowMode(SM:byte);
 begin
  shadowMode:=sm;
 end;

procedure setButtonColorRGBA(r,g,b,a:integer);
 begin
  buttoncolor.r:=r;
  buttoncolor.g:=g;
  buttoncolor.b:=b;
  buttoncolor.a:=a;
 end;

procedure seteditcolorRGBA(r,g,b,a:integer);
 begin
  editcolor.r:=r;
  editcolor.g:=g;
  editcolor.b:=b;
  editcolor.a:=a;
 end;

Procedure DrawTexture(x1,y1,x2,y2:integer; tex:pImg);
 var srcrect,dstrect:tSDL_rect;
 begin
  dstrect.x:=x1;
  dstrect.y:=y1;
  dstrect.w:=x2-x1;
  dstrect.h:=y2-y1;
  srcrect:=dstrect;
  srcrect.x:=0;
  srcrect.y:=0;
  if SDL_RenderCopy(render,tex^.image,@srcrect,@dstrect)<>0 then
   begin
    writeln(SDL_GetError);
    halt(1);
   end;
 end;

Procedure DrawButton(x1,y1,x2,y2:integer; label_:ansistring;pressed,focused:boolean);
  var tx,ty:integer; t,t1:longint; oldColor:tSDL_Color;
  begin
   oldColor:=color;
   setcolorRGBA(buttoncolor.r,buttoncolor.g,buttoncolor.b,buttoncolor.a);
   if buttonTexture=nil then
    bar(x1,y1,x2,y2)
    else
    DrawTexture(x1,y1,x2,y2,buttonTexture);
   setcolorRGBA(20,20,20,64);
   if pressed then
    bar(x1,y1,x2,y2)
    else
    begin
     bar(x1+2,y1+2,x2,y2);
     line(x1+1,y2-1,x2-1,y2-1);
     line(x1+1,y2-2,x2-1,y2-2);
     line(x2-1,y1+1,x2-1,y2);
     line(x2-2,y1+1,x2-2,y2-1);
     setcolorRGBA(255,255,255,80);
     line(x1+1,y1+1,x1+1,y2-1);
     line(x1+1,y1+1,x2-1,y1+1);
    end;
   setcolorRGBA(100,100,100,255);
   rectangle(x1,y1,x2,y2);
   ttf_sizeutf8(font,pchar(label_),@t,@t1);
   tx:=(x1+x2-t) div 2;
   ty:=(y1+y2-t1) div 2;
   outtextxycolored(tx+1,ty+1,label_,120,120,120,255);
   if (focused) or (pressed) then
    outtextxycolored(tx,ty,label_,229,196,14,255)
    else
    outtextxycolored(tx,ty,label_,255,255,255,255);
   setColorRgba(oldcolor.r,oldcolor.g,oldcolor.b,oldcolor.a);
  end;

Procedure DrawPicButton(x1,y1,x2,y2:integer; label_:ansistring;pressed,focused:boolean; p:pointer; sx,sy:integer);
 begin
  Drawbutton(x1,y1,x2,y2,label_,pressed,focused);
  Putsprite(x1+sx,y1+sy,p);
 end;

Procedure setwindowcolorRGBA(r,g,b,a:integer);
 begin
  windowcolor.r:=r;
  windowcolor.g:=g;
  windowcolor.b:=b;
  windowcolor.a:=a;
 end;

Procedure Ramka(x1,y1,x2,y2:integer);
 var oldColor:tSDL_color; 
 begin
  oldColor:=color;
  setcolorRGBA(windowcolor.r,windowcolor.g,windowcolor.b,windowcolor.a);
  if windowTexture=nil then
    bar(x1,y1,x2,y2)
   else
    DrawTexture(x1,y1,x2,y2,windowTexture);
  setcolorRGBA(255,255,255,100);
  line(x1,y1,x1,y2);
  line(x1,y1,x2,y1);
  setcolorRGBA(0,0,0,80);
  line(x1,y2,x2,y2);
  line(x2,y1,x2,y2);
  setColorRgba(oldcolor.r,oldcolor.g,oldcolor.b,oldcolor.a);
 end;

Procedure drawwindow(x1,y1,x2,y2:integer);
 var oldColor:tSDL_color;
 begin
  oldColor:=color;
  ramka(x1,y1,x2,y2);
  x1:=x1+10;
  x2:=x2-10;
  y1:=y1+10;
  y2:=y2-10;
  setcolorRGBA(0,0,0,120);
  line(x1,y1,x2,y1);
  line(x1,y1,x1,y2+1);
  setcolorRGBA(255,255,255,80);
  line(x1+1,y2,x2,y2);
  line(x2,y1+1,x2,y2);
  line(x1+1,y1+1,x2-1,y1+1);
  line(x1+1,y1+2,x2-1,y1+2);{?}
  line(x1+1,y1+1,x1+1,y2);
  line(x1+2,y1+1,x1+2,y2);{?}
  setcolorRGBA(0,0,0,120);
  line(x2-1,y1,x2-1,y2);
  line(x2-2,y1,x2-2,y2);
  line(x1,y2-1,x2-1,y2-1);
  line(x1,y2-2,x2-1,y2-2);
  setColorRgba(oldcolor.r,oldcolor.g,oldcolor.b,oldcolor.a);
 end;

Procedure setlabelcolorRGBA(r,g,b,a:integer);
 begin
  labelcolor.r:=r;
  labelcolor.g:=g;
  labelcolor.b:=b;
  labelcolor.a:=a;
 end;

Procedure setTex(var dstTexture:pointer; var dstPath:ansistring; path:ansistring);
 var img:pointer;
 begin
  if dstTexture<>nil then
   begin
    SDL_DestroyTexture(pImg(dstTexture)^.image);
    dispose(pImg(dstTexture));
    dstTexture:=nil;
   end;
  if (lowercase(copy(path,length(path)-2,3))='spr') or (lowercase(copy(path,length(path)-2,3))='tex')then
    img:=LoadSpr(path)
   else
    img:=loadImage(path);
  dstTexture:=img;
  dstPath:=path;
 end;

Procedure SetWindowTexture(Path:ansistring);
 begin
  setTex(windowTexture,windowTextureName,path);
 end;
Procedure SetButtonTexture(Path:ansistring);
 begin
  setTex(buttonTexture,buttonTextureName,path);
 end;
Procedure SetLabelTexture(Path:ansistring);
 begin
  setTex(labelTexture,labelTextureName,path);
 end;
Procedure SetEditTexture(Path:ansistring);
 begin
  setTex(editTexture,editTextureName,path);
 end;

Function GetButtonTexture:ansistring;
 begin
  GetButtonTexture:=buttonTextureName;
 end;

Function GetWindowTexture:ansistring;
 begin
  GetWindowTexture:=windowTextureName;
 end;

Function GetLabelTexture:ansistring;
 begin
  GetLabelTexture:=labelTextureName;
 end;

Function GetEditTexture:ansistring;
 begin
  GetEditTexture:=editTextureName;
 end;

Procedure DrawLabel(x1,y1,x2,y2:integer; text:ansistring);
 var t,t1:longint;  tx,ty:integer; oldColor:tSDL_COLOR;
 begin
  oldColor:=color;
  setcolorRGBA(labelcolor.r,labelcolor.g,labelcolor.b,labelcolor.a);
  if labelTexture=nil then
    bar(x1,y1,x2,y2)
   else
    DrawTexture(x1,y1,x2,y2,labelTexture);
  setcolorRGBA(255,255,255,70);
  line(x1,y1,x2-1,y1);
  line(x1,y1+1,x2-1,y1+1);
  line(x1,y1,x1,y2-1);
  line(x1+1,y1,x1+1,y2-1);
  setcolorRGBA(0,0,0,150);
  line(x1,y2-1,x2,y2-1);
  line(x2-1,y1,x2-1,y2);
  setcolorRGBA(0,0,0,120);
  line(x1,y2-2,x2,y2-2);
  line(x2-2,y1,x2-2,y2);
  ttf_sizeutf8(font,pansichar(text),addr(t),addr(t1));
  tx:=(x1+x2-t) div 2;
  ty:=(y1+y2-t1) div 2;
  outtextxycolored(tx+1,ty+1,text,120,120,120,255);
  outtextxy(tx,ty,text);
  setColorRgba(oldcolor.r,oldcolor.g,oldcolor.b,oldcolor.a);
 end;

Procedure DrawScreen(x1,y1,x2,y2:integer; name:ansistring);
 var img:pImg;
 begin
  if (lowercase(copy(name,length(name)-2,3))='spr') or (lowercase(copy(name,length(name)-2,3))='tex')then
    img:=LoadSpr(name)
   else
    img:=loadImage(name);
  DrawTexture(x1,y1,x2,y2,img);
  SDL_DestroyTexture(img^.image);
  dispose(img);
 end;

Procedure SetEditColor(q:integer);
 begin
  seteditcolorRGBA(pal[q].r,pal[q].g,pal[q].b,pal[q].a);
 end;

Procedure SetlabelColor(q:integer);
 begin
  setlabelcolorRGBA(pal[q].r,pal[q].g,pal[q].b,pal[q].a);
 end;

Procedure SetwindowColor(q:integer);
 begin
  setwindowcolorRGBA(pal[q].r,pal[q].g,pal[q].b,pal[q].a);
 end;

Procedure SetbuttonColor(q:integer);
 begin
  setbuttoncolorRGBA(pal[q].r,pal[q].g,pal[q].b,pal[q].a);
 end;

Procedure ChangeDebug(b:boolean);
 begin
  debug:=b;
 end;

Procedure DrawEdit(x1,y1,x2,y2:integer;text:ansistring);
 var x,y:integer; oldcolor:tSDL_Color;
 begin
  oldColor:=color;
  setcolorRGBA(editcolor.r,editcolor.g,editcolor.b,editcolor.a);
  if editTexture=nil then
    bar(x1,y1,x2,y2)
   else
    DrawTexture(x1,y1,x2,y2,editTexture);
  setcolorRGBA(0,0,0,120);
  line(x1,y1,x2,y1);
  line(x1,y1,x1,y2);
  line(x1,y1+1,x2,y1+1);
  line(x1+1,y1,x1+1,y2);
  setcolorRGBA(255,255,255,60);
  line(x1,y2,x2,y2);
  line(x2,y1,x2,y2);
  line(x1,y2-1,x2,y2-1);
  line(x2-1,y1,x2-1,y2);
  x:=x1+4;
  y:=y1;
  if textwidth(text)>abs(x2-x1) then
   begin
    while text<>'' do
     begin
      if x+textwidth(text[1])>x2 then
       begin
        x:=x1+4;
        y:=y+textheight(text);
       end
       else
       begin
        outtextxy(x,y,text[1]);
        x:=x+textwidth(text[1]);
        delete(text,1,1);
       end;
     end;
   end
   else
    if text<>'' then outtextxy(x,y,text);
  setcolorRGBA(oldcolor.r,oldcolor.g,oldcolor.b,oldcolor.a);
 end;

Procedure SetVisualPage(Page:word);
 begin
  UpdateScreen;
 end;
Procedure SetActivePage(Page:word);
 begin
 end;
begin
 Debug:=false;
 currentCursor:=nil;
 shadowMode:=mediumShadow;
end.
