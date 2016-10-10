{ VesaSDL.pas - main part of VesaSDL module

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
Unit VesaSDL;
Interface
 Uses SDL2,SDL2_image,SDL2_ttf;
 Const
  {windowed modes}
  M640x480=$100;
  M800x600=$101;
  M1024x768=$102;
  M1280x1024=$103;
  M1920x1080=$108;
  {fullscreen modes;}
  M640x480f=$500;
  M800x600f=$501;
  M1024x768f=$502;
  M1280x1024f=$503;
  M1920x1080f=$508;
  NormalPut=0;
  ShadowPut=1;
 Type
  tcolor=tsdl_color;
  tdot=record
           r,g,b,a:integer;
       end;
  ptdot=^tdot;
  ptdot1=^byte;
  sprite=record
          link:array of array of byte;
          spritex,spritey:word;
         end;
  psprite=^sprite;
  img=record
       image:pSDL_texture;
       rect:tSDL_Rect;
      end;
  pimg=^img;
 Procedure changedebug(b:boolean);
 Procedure SetColorRGBA(r,g,b,a:integer);
 Procedure setcolor(q:integer);
 Procedure SetButtonColorRGBA(r,g,b,a:integer);
 Procedure setbuttoncolor(q:integer);
 Procedure SeteditColorRGBA(r,g,b,a:integer);
 Procedure seteditcolor(q:integer);
 Procedure SetWindowColorRGBA(r,g,b,a:integer);
 Procedure setwindowcolor(q:integer);
 Procedure SetLabelColorRGBA(r,g,b,a:integer);
 Procedure setlabelcolor(q:integer);
 Procedure PutPixelRGBA(x,y,r,g,b,a:integer);
 Procedure PutPixel(x,y,c:integer);
 Procedure Line(x1,y1,x2,y2:integer);
 Procedure HideMouse;
 Procedure ShowMouse;
 Procedure ShowCursor(toggle:integer);{0 - hide, 1 - show==hidemouse or showmouse}
{ Procedure Linew(x1,y1,x2,y2,w:integer);}
 Procedure DrawButton(x1,y1,x2,y2:integer; label_:ansistring;pressed,focused:boolean);
 Procedure DrawPicButton(x1,y1,x2,y2:integer; label_:ansistring;pressed,focused:boolean; p:pointer; sx,sy:integer);
 Procedure DrawWindow(x1,y1,x2,y2:integer);
 Procedure DrawLabel(x1,y1,x2,y2:integer; text:ansistring);
 Procedure Ramka(x1,y1,x2,y2:integer);
 Procedure Rectangle(x1,y1,x2,y2:integer);
 Procedure Bar(x1,y1,x2,y2:integer);
 Procedure Ellipse(x,y:integer; rx,ry:real);
 Procedure fillEllipse(x,y:integer; rx,ry:real);
 Procedure circle(x,y:integer; r:real);
 Procedure Circlef(x,y:integer; r:real);
 Procedure InitAll(mode:word;Name_:Pchar);
 Procedure InitAllX(x,y:word;full:boolean;Name_:pchar);
 Procedure InitWindow(full:boolean;name_:pchar);
 Procedure InitSdl;
 Procedure DoneAll;
 Procedure Delay(n:word);
 Procedure setwsize(x1,y1,x2,y2:integer);
 Function TextWidth(s:ansistring):word;
 Function TextHeight(s:ansistring):word;
 Procedure outtextxy(x,y:integer; text:ansistring);
 Procedure OutTextXYColored(x,y:integer; text:ansistring; r,g,b:integer);
 Procedure loadfont(name_:pansichar; ptsize:longint);
 Procedure drawedit(x1,y1,x2,y2:integer; text:ansistring);
 Function LoadImage1(s:PAnsiChar):pointer;
 Procedure PutImage1(x,y:integer; a:pointer);
 Function LoadSpr1(var f:file):pointer;
 Function LoadSpr(s:string):pointer;
 Procedure PutImage(x,y:integer;p:pimg;type_:byte);
 Procedure PutSprite(x,y:integer; p:pointer);
 Procedure UpdateScreen;
 Procedure ClearScreen;
 Function GetPixel(x,y:integer):byte;
const
 pal:array[0..255] of tsdl_color=(
 (r:123; g:123; b:123; a:0),(r:0; g:0; b:168; a:255),(r:0; g:168; b:0; a:255), {Vesa Palette. Its look's terrible}
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
 var apw,aph:integer; window:pointer;
Implementation
 const cirseg=500;
       MagicNumber=0.375; {0.375}
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

 Type ref=^node;
      node=record
            s:^sprite;
            next:ref;
           end;
      pxls=array of array of byte;
 var inz:ref; wx1,wx2,wy1,wy2:integer;
     font:pointer;
     screenwidth,screenheight:integer;color,buttoncolor,windowcolor,labelcolor,editcolor:tcolor; render:pointer;
     debug:boolean;
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

Procedure ClearScreen;
 begin
{  glClear(GL_COLOR_BUFFER_BIT);}
  SDL_SetRenderDrawColor( render, 0, 0, 0, 255 );
  sdl_renderclear(render);
  SDL_SetRenderDrawColor( render, color.r, color.g, color.b, color.a );
 end;

{Function inw(x,y:integer):boolean;
 begin
  inw:=(x>=wx1) and (x<=wx2) and (y<=wy2) and (y>=wy1);
 end;}

procedure PutpixelRGBA(x,y,r,g,b,a:integer);
{ var u,v:real; q:psdl_point;}
 begin
(*  if inw(x,y) then
   begin
    glBegin(GL_POINTS);
    glColor4ub(color.r,color.g,color.b,color.a);
    u:=real(x)+magicnumber{ / apw};
    v:=real(y)+magicnumber{ / aph};
    glVertex2f(u,v);
    glEnd;
   end;*)
  SDL_SetRenderDrawColor(render,r,g,b,a);
  sdl_renderdrawpoint(render,x,y);
  SDL_SetRenderDrawColor(render,color.r,color.g,color.b,color.a);
 end;
procedure PutPixel(x,y,c:integer);
 begin
  putpixelRGBA(x,y,pal[c].r,pal[c].g,pal[c].b,pal[c].a);
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
{procedure Linew(x1,y1,x2,y2,w:integer);
 var u1,u2,v1,v2:real;
 begin
  glLineWidth(w);
  glBegin(GL_LINES);
   glColor4ub(color.r,color.g,color.b,color.a);
   u1:=magicnumber+x1;
   u2:=magicnumber+x2;
   v1:=magicnumber+y1;
   v2:=magicnumber+y2;
   glVertex2f(u1,v1);
   glVertex2f(u2,v2);
  glEnd;
 end;}

procedure Line(x1,y1,x2,y2:integer);
 begin
{  Linew(x1,y1,x2,y2,1);}
  sdl_renderdrawline(render,x1,y1,x2,y2);
 end;

Procedure Rectangle(x1,y1,x2,y2:integer);
 var q:psdl_rect;
 begin
  {line(x1,y1,x2,y1);
  line(x1,y1,x1,y2);
  line(x1,y2,x2,y2);
  line(x2,y1,x2,y2);
  putpixel(x2,y2);}
  new(q);
  q^.x:=x1;
  q^.y:=y1;
  q^.w:=x2-x1;
  q^.h:=y2-y1;
  sdl_renderdrawrect(render,q);
  dispose(q);
 end;

Procedure Bar(x1,y1,x2,y2:integer);
var{ var u1,u2,v1,v2:real;} q:psdl_rect;
 begin
{  glBegin(GL_QUADS);
   glColor4ub(color.r,color.g,color.b,color.a);
   u1:=-magicnumber/ abs(x2-x1)+x1 ;
   u2:=magicnumber / abs(x2-x1)+x2;
   v1:=-magicnumber / abs(y2-y1)+y1;
   v2:=magicnumber / abs(y2-y1)+y2;
   glVertex2f(u1,v1);
   glVertex2f(u1,v2);
   glVertex2f(u2,v2);
   glVertex2f(u2,v1);
  glEnd;}
  new(q);
  q^.x:=x1;
  q^.y:=y1;
  q^.w:=abs(x2-x1);
  q^.h:=abs(y2-y1);
  sdl_renderfillrect(render,q);
  dispose(q);
 end;

Procedure Ellipse(x,y:integer; rx,ry:real);
 var i:integer; a,dx,dy:real;
 begin
{  glBegin(GL_LINE_LOOP);
  glcolor4ub(color.r,color.g,color.b,color.a);}
   for i:=0 to cirseg do
    begin
     a:=2*pi*real(i)/real(cirseg);
     dx:=rx*cos(a);
     dy:=ry*sin(a);
     sdl_renderdrawpoint(render,round(dx+x),round(dy+y));
{     glVertex2f(dx+x,dy+y);}
    end;
{  glEnd;}
 end;
procedure fillellipse(x,y:integer; rx,ry:real);
 var i:integer; a,dx,dy:real;
 begin
{  glBegin(GL_LINE_LOOP);
  glcolor4ub(color.r,color.g,color.b,color.a);}
   for i:=0 to cirseg do
    begin
     a:=2*pi*real(i)/real(cirseg);
     dx:=rx*cos(a);
     dy:=ry*sin(a);

{     glVertex2f(dx+x,dy+y);}sdl_renderdrawline(render,round(dx+x),round(dy+y),x,y);
    end;
{  glEnd;}
 end;
Procedure circle(x,y:integer; r:real);
 var i:integer; a,d:real;
 begin
{  glBegin(GL_LINE_LOOP);
   glcolor4ub(color.r,color.g,color.b,color.a);
   for i:=0 to cirseg do
    begin
     a:=2*pi*real(i)/real(cirseg);
     if inw(integer(round(-cos(a)*r+x)),integer(round(-sin(a)*r+y))) then
      glcolor4ub(color.r,color.g,color.b,color.a)
      else
      glcolor4ub(0,0,0,0);
     glVertex2f(-cos(a)*r+x,-sin(a)*r+y);
    end;
  glEnd;}
   for i:=0 to cirseg do
    begin
     a:=2*pi*real(i)/real(cirseg);
   {  if inw(integer(round(-cos(a)*r+x)),integer(round(-sin(a)*r+y))) then}
      sdl_renderdrawpoint(render,round(-cos(a)*r+x),round(-sin(a)*r+y));
 {     glcolor4ub(color.r,color.g,color.b,color.a)
      else
      glcolor4ub(0,0,0,0);
     glVertex2f(-cos(a)*r+x,-sin(a)*r+y);}
    end;
 end;

Procedure Circlef(x,y:integer; r:real);
 var i:integer; a:real;
 begin
 { glBegin(GL_TRIANGLE_FAN);
   glColor4ub(color.r,color.g,color.b,color.a);
   glVertex2i(x,y);}
   for i:=0 to cirseg do
    begin
     a:=real(i/cirseg*pi*2);
     sdl_renderdrawline(render,round(-cos(a)*r+x),round(-sin(a)*r+y),x,y);
     {glVertex2f(real(x-cos(a)*r),real(y-sin(a)*r));}
    end;
{  glEnd;}
 end;

Procedure outerrorinit;
 begin
  writeln('Error While Initialization SDL');
  halt(1);
 end;

Procedure loadfont(name_:pansichar; ptsize:longint);
 begin
  if font<>nil then
   ttf_closefont(font);
  font:=ttf_openfont(name_,ptsize);
  if (font<>nil) and (debug) then writeln('Font ',name_,' successfully loaded')
   else
    if font=nil then outerrorinit;
  ttf_setfontstyle(font,TTF_style_bold);
 end;

Procedure setwsize(x1,y1,x2,y2:integer);
 var tmp:psdl_rect; e:integer;
 begin
  new(tmp);
  tmp^.x:=x1;
  tmp^.y:=y1;
  tmp^.w:=x2-x1;
  tmp^.h:=y2-y1;
  sdl_RenderSetViewPort(render,tmp);
  dispose(tmp);
 end;

Procedure InitMode(mode:word);
 begin
  case mode of
    $100,$500:begin
               apw:=640;
               aph:=480;
              end;
    $101,$501:begin
               apw:=800;
               aph:=600;
              end;
    $102,$502:begin
               apw:=1024;
               aph:=768;
              end;
    $103,$503:begin
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
 if sdl_init(SDL_INIT_VIDEO)<>0 then
    outerrorinit
    else
    if debug then writeln('Successfully loaded sdl');
 end;
procedure InitWindow(full:boolean;name_:pchar);
 var q:pointer;
 begin
   InitSdl;
   window:=sdl_CreateWindow(name_,SDL_WINDOWPOS_CENTERED,SDL_WINDOWPOS_CENTERED,apw,aph,(SDL_WINDOW_SHOWN) or (SDL_WINDOW_OPENGL));
   if full then
    SDL_SetWINDOWFULLSCREEN(window,SDL_WINDOW_FULLSCREEN);
   if window=nil then
    outerrorinit
    else
    if debug then writeln('Successfully created window');
    render:=SDL_CreateRenderer(window, -1, (SDL_RENDERER_ACCELERATED or SDL_RENDERER_PRESENTVSYNC));
    if render=nil then
	 outerrorinit
     else
      if debug then writeln('Successfully created sdl_render');
(*   if SDL_GL_SetSwapInterval( 1 )<0 then
    outerrorinit
    else
    writeln('Successfully initializated VSync');*)
   {glViewport(0,0,apw,aph);
   glMatrixMode( GL_PROJECTION );
   glLoadIdentity;
   glDisable(Gl_POINT_SMOOTH);}
{   if apw<=aph then
    gluOrtho2D(0,real(aph)*aph/real(apw),aph,0)
    else                                     }
   (*glOrtho(0,{real(apw)*apw/real(aph)}apw,aph,0,0,1.0);
   glClearColor(0,0,0,0);
   glMatrixMode(GL_MODELVIEW);
   glEnable(GL_TEXTURE_2D);
   glLoadIdentity;
   glPixelZoom(1,1);
   glPointSize(1);*)
   SDL_SetRenderDrawBlendMode( Render, SDL_BLENDMODE_blend );
{   glclear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);}
   {SDL_RenderClear(render);}
   TTF_INIT;
   font:=nil;
   (*glEnable(GL_BLEND);
   glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
   glDepthMask(GL_FALSE);*)
{   glTranslatef(0.375,0.375,0);}
   setcolorRGBA(0,0,0,255);
   setwsize(0,0,apw,aph);
   clearscreen;
   updatescreen;
   img_init(IMG_INIT_JPG or IMG_INIT_PNG or IMG_INIT_TIF);
   if debug then writeln(img_GetError);
   if debug then Writeln('Everything Done. Ready to work.')
end;

Procedure InitAll(mode:word; name_:pchar);
 var full:boolean;
 begin
  InitMode(mode);
  if mode>=$500 then
   full:=true else full:=false;
  InitWindow(full,name_);
 end;
Procedure InitAllX(x,y:word;full:boolean;name_:pchar);
 begin
  apw:=x;
  aph:=y;
  InitWindow(full,Name_);
 end;

function textwidth(s:ansistring):word;
 var t,t1:plongint;
 begin
  new(t); new(t1);
  ttf_sizeutf8(font,pansichar(s),t,t1);
  textwidth:=t^;
  dispose(t);
  dispose(t1);
 end;

function textheight(s:ansistring):word;
 var t,t1:plongint;
 begin
  new(t); new(t1);
  ttf_sizeutf8(font,pansichar(s),t,t1);
  textheight:=t1^;
  dispose(t);
  dispose(t1);
 end;

(*Procedure render_text(x,y:integer; text:ansistring; r,g,b:integer);
 var textsurf:psdl_surface; textureformat:glenum;  texture:pgluint; tex:psdl_texture;  q:pUint16; w,h:longint; textcolor,bg:tsdl_color;
  tx,ty,tx2,ty2:real;
 begin
 { glTranslatef(0,0,0);}
  if text<>'' then
   begin
    textcolor.a:=255;
    textcolor.r:=b; {Why r:=b and b:=r? Because thats how it's working}
    textcolor.g:=g;
    textcolor.b:=r;
    bg.a:=255;
    bg.r:=255;
    bg.g:=0;
    bg.b:=0;
    {textsurf:=nil;
    new(textsurf);   }
    if font=nil then
     begin
      writeln('Font is loaded?');
      halt(1);
     end;
    TTF_SetFontStyle(font,TTF_STYLE_ITALIC);
{    TTF_SetFontOutline(font,TTF_HINTING_LIGHT);
    TTF_SeTFontHinting(font,TTF_HINTING_NORMAL);}
    glBlendFunc(GL_SRC_COLOR,GL_ONE_MINUS_SRC_ALPHA);
    textsurf:=(ttf_renderutf8_shaded(font,pchar(text+#0),textcolor,bg));
    case textsurf^.format^.bytesperpixel of
     1:textureformat:=gl_alpha;
     3:if textsurf^.format^.rmask=$000000ff then
         textureformat:=gl_rgb
         else
         textureformat:=$80E0;
     4:if textsurf^.format^.rmask=$000000ff then
         textureformat:=gl_rgba
         else
         textureformat:=$80E1;
    end;
    if textsurf=nil then
    begin
    writeln('error rendering font');
    halt(0);
    end;
{    tex:=sdl_createtexturefromsurface(nil,textsurf);}
    new(texture);
    glEnable(GL_TEXTURE_2D);
    glGenTextures(1,texture);
{    sdl_gl_BindTexture(tex,nil,nil);}
    w:=textsurf^.w;
    h:=textsurf^.h;
    glBindTexture(GL_TEXTURE_2D,texture^);
    glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MAG_FILTER,GL_LINEAR);
    glTexImage2D(GL_TEXTURE_2D,0,textsurf^.format^.bytesperpixel,textsurf^.w,textsurf^.h,0,textureformat,GL_UNSIGNED_BYTE,textsurf^.pixels);
    {glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);}
{    gltexfromsurface(textsurf,texture,gl_rgba);                       }
    SDL_FreeSurface(textsurf);
    {if textsurf<>nil then
     dispose(textsurf);}
   tx:=(real(x)/w);
   ty:=(real(y)/h);
   tx2:=(real(x+w)/w);
   ty2:=(real(y+h)/h);
   glBegin(Gl_QUADS);
    glColor4ub(255,255,255,255);
    glTexCoord2f(tx,ty); glVertex2i(x,y);
    glTexCoord2f(tx2,ty); glVertex2i(x+w,y);
    glTexCoord2f(tx2,ty2); glVertex2i(x+w,y+h);
    glTexCoord2f(tx,ty2); glVertex2i(x,y+h);
   glEnd;
   glDeletetextures(1,texture);
   glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
   glDisable(GL_TEXTURE_2D);
{   if texture<>nil then
    Dispose(texture);}
{   sdl_destroytexture(tex);}
  end;
{  glTranslatef(0.375,0.375,0);}
 end;*)
procedure render_text(x,y:integer;text:ansistring; r,g,b:integer);
 var surf:psdl_surface; color:tsdl_color; tex:psdl_texture; rect:tsdl_rect;
 begin
  if text<>'' then
   begin
    color.r:=r;
    color.g:=g;
    color.b:=b;
    surf:=ttf_renderutf8_solid(font,pchar(text),color);
    tex:=sdl_createtexturefromsurface(render,surf);
    rect.x:=x;
    rect.y:=y;
    rect.w:=surf^.w;
    rect.h:=surf^.h;
    sdl_rendercopy(render,tex,nil,@rect);
    SDL_freesurface(surf);
    SDL_destroytexture(tex);
   end;
 end;

Procedure outtextxycolored(x,y:integer; text:ansistring; r,g,b:integer);
 begin
  render_text(x,y,text,r,g,b);
 end;

Procedure OutTextXY(x,y:integer; text:ansistring);
 begin
  OutTextXYColored(x,y,text,255,255,255);
 end;


Procedure DoneAll;
 begin
  if font<>nil then
   ttf_closefont(font);
  ttf_quit;
  img_quit;
  SDL_DestroyWindow(window);
  SDL_Quit();
 end;

Procedure Delay(n:word);
 begin
  SDL_Delay(n);
 end;
Function LoadImage1(s:PAnsiChar):pointer;
 var q:psdl_surface; w:psdl_texture; a:^img;
 begin
  q:=Img_Load(pchar(s));
  w:=sdl_createtexturefromsurface(render,q);
  new(a);
  a^.rect.w:=q^.w;
  a^.rect.h:=q^.h;
  a^.image:=w;
  SDL_freesurface(q);
  loadimage1:=a;
{  writeln(sdl_geterror); }
 end;
Procedure PutImage1(x,y:integer; a:pointer);
 var p:^img;
 begin
  setcolorRGBA(255,255,255,255);
  p:=a;
  p^.rect.x:=x;
  p^.rect.y:=y;
  SDL_RenderCopy(render,p^.image,nil,@p^.rect);
 end;

Procedure addinspritelist(p:pointer);
 var tz:ref;
 begin
  tz:=inz;
  while tz^.next<>nil do
   tz:=tz^.next;
  new(tz^.next);
  tz:=tz^.next;
  tz^.s:=p;
  tz^.next:=nil;
 end;

(*Procedure genbmp(p:psprite);
 var f:file; b:word; size,q:longword; e:longint;
 const headersize=14; infoheadersize=40;
 begin
  size:=headersize+infoheadersize;
  assign(f,'____sprtemp.$$$');
  rewrite(f,1);
  bmpheader
  b:=19778; {19778='BM' in hex}
  blockwrite(f,b,2); {writing bm in bmpheader}
  blockwrite(f,size,2);
  b:=0;
  blockwrite(f,b,2);{reserved in bmp}
  blockwrite(f,b,2);{reserved}


  DIB header
  q:=40;
  blockwrite(f,q,4);
  e:=p^.spritex;
  blockwrite(f,e,4);{width}
  e:=p^.spritey;
  blockwrite(f,e,4);{height}
  b:=1;
  blockwrite(f,b,2);{colorplanes}
  b:=8;
  blockwrite(f,b,2);{depth of image}
  q:=0;
  blockwrite(f,q,4);{bl_rgb}
  q:=p^.spritex*p^.spritey;
  blockwrite(f,q,4);{imagesize}
  e:=96;
  blockwrite(f,e,4);{pixel per meter hor}
  blockwrite(f,e,4);{ppm vert}
  close(f);
 end;            *)

(*Function Loadspr1(var f:file):pointer;
 var i,j:integer; a:^sprite; e:pointer; realsize:longint; q:byte;
 begin
  new(a);
  BlockRead(f,a^.spritex,2);
  BlockRead(f,a^.spritey,2);
  BlockRead(f,realsize,2);
  BlockRead(f,q,2);
  blockread(f,q,2);
  setlength(a^.link,a^.spritey,a^.spritex);
  i:=0;
  j:=0;
  while realsize
    begin
     blockread(f,a^.link[i,j],1);
    end;
  e:=a;
  loadspr1:=e;
  {writeln('Sprite successfully loaded');}
 end;*)
function _get_pixel32(surf:tsdl_surface;x,y:integer):uint32;
 var pixels:puint32;
 begin
  pixels:=puint32(surf.pixels);
  _get_pixel32:=pixels[(y*surf.w)+x];
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
 var i,j:word; a:^par; e:pointer; realsize:longint; q:byte; spritex,spritey:word;
 w:psdl_surface; s:psdl_texture; aa:^img;ww:string; asd:longword; qq:boolean;
 c,b,n:longword;
 begin
 { new(a);}
  BlockRead(f,spritex,2);
  BlockRead(f,spritey,2);
  BlockRead(f,realsize,2);
  BlockRead(f,q,2);
  blockread(f,q,2);
 { writeln(1);}
  new(a);
{  writeln(2);}
{   writeln([0],' ',a[1],' ',a[2],' ',a[3],' ',a[4]);}
{  e:=a;}
{  loadspr1:=e;}
  {writeln('Sprite successfully loaded');}
{  w:=sdl_creatergbsurfacefrom(sdl_maprgb(sdl_rgb,$ff,$ff,$ff),spritex,spritey,24,spritey*3,rmask,gmask,bmask,0);}
  w:=sdl_creatergbsurface(0,spritex,spritey,32,rmask,gmask,bmask,amask);
  if sdl_mustlock(w) then
   begin
    sdl_locksurface(w);
    qq:=true;
   end;
{  w^.pixels:=a;}
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
     _put_pixel32(w^,i,j,(c shl 16)or (b shl 16) or (n shl 8) or asd);
     {$else}
     _put_pixel32(w^,i,j,c or (b shl 8) or (n shl 16) or (asd shl 24));
     {$endif}
{     _put_pixel32(w^,i,j,$ffffff00 or asd);}
{     a^[i]:=255;
     a^[i+1]:=255;
     a^[i+2]:=255; }
    end;
  if qq then
   sdl_unlocksurface(w);
  s:=sdl_createtexturefromsurface(render,w);
  new(aa);
  aa^.rect.w:=w^.w;
  aa^.rect.h:=w^.h;
  aa^.image:=s;
   SDL_freesurface(w);
{  ww:='1';
  while ww<>'' do
   begin
    if ww<>'1' then
     writeln(ww);
    ww:=sdl_geterror;
   end;                                            }
  loadspr1:=aa;
{  writeln(5);  }
end;
Function LoadSpr(s:string):pointer;
 var f:file;
 begin
  assign(f,s);
  reset(f,1);
  LoadSpr:=LoadSpr1(f);
  close(f);
 end;
(*Procedure ptimg(x,y:integer;a:psprite; var pixels; type_:byte);
 var i,j:integer;
 begin

 end;                         *)
Procedure PutImage(x,y:integer;p:pimg;type_:byte);
 var a:^sprite; i,j:integer; shadow:boolean;
 begin
  (*a:=p;
  for i:=0 to a^.spritey-1 do
   for j:=0 to a^.spritex-1 do
    begin
     case type_ of
      NormalPut:setcolor256({a^.link[i][j].r,a^.link[i][j].g,a^.link[i][j].b,a^.link[i][j].a}a^.link[i,j]);
      ShadowPut:setcolor(0,0,0,pal[a^.link[i][j]].a div 2);
     end;
     putpixel(x+j,y+i);
    end;*)
  if type_=shadowput then
   begin
    sdl_settexturealphamod(p^.image,192);
    sdl_settexturecolormod(p^.image,0,0,0);
   end;
  putimage1(x,y,p);
  if type_=shadowput then
   begin
    sdl_settexturealphamod(p^.image,255);
    sdl_settexturecolormod(p^.image,255,255,255);
   end;
 end;

Procedure PutSprite(x,y:integer; p:pointer);
 begin
  PutImage(x,y,p,NormalPut);
 end;

Procedure UpdateScreen;
 begin
  SDL_RenderPresent(render);
 end;

Function GetPixel(x,y:integer):byte;
 begin
  getpixel:=0;
 end;

procedure setbuttoncolorRGBA(r,g,b,a:integer);
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

Procedure DrawButton(x1,y1,x2,y2:integer; label_:ansistring;pressed,focused:boolean);
  var tx,ty:integer; t,t1:longint;
  begin
   setcolorRGBA(buttoncolor.r,buttoncolor.g,buttoncolor.b,buttoncolor.a);
{   bar(x1,y1,x2,y2);
   setcolor(20,20,20,64);}
   bar(x1,y1,x2,y2);
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
   outtextxycolored(tx+1,ty+1,label_,120,120,120);
   if (focused) or (pressed) then
    outtextxycolored(tx,ty,label_,229,196,14)
    else
    outtextxycolored(tx,ty,label_,255,255,255);
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
 begin
  setcolorRGBA(windowcolor.r,windowcolor.g,windowcolor.b,windowcolor.a);
  bar(x1,y1,x2,y2);
  setcolorRGBA(255,255,255,100);
  line(x1,y1,x1,y2);
  line(x1,y1,x2,y1);
  setcolorRGBA(0,0,0,80);
  line(x1,y2,x2,y2);
  line(x2,y1,x2,y2);
 end;
Procedure drawwindow(x1,y1,x2,y2:integer);
 begin
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
 end;

Procedure setlabelcolorRGBA(r,g,b,a:integer);
 begin
  labelcolor.r:=r;
  labelcolor.g:=g;
  labelcolor.b:=b;
  labelcolor.a:=a;
 end;

Procedure DrawLabel(x1,y1,x2,y2:integer; text:ansistring);
 var t,t1:plongint;  tx,ty:integer;
 begin
  setcolorRGBA(labelcolor.r,labelcolor.g,labelcolor.b,labelcolor.a);
  bar(x1,y1,x2,y2);
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
  new(t);new(t1);
  ttf_sizeutf8(font,pansichar(text),t,t1);
  tx:=(x1+x2-t^) div 2;
  ty:=(y1+y2-t1^) div 2;
  outtextxycolored(tx+1,ty+1,text,120,120,120);
  outtextxy(tx,ty,text);
  dispose(t);dispose(t1);
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

Procedure changedebug(b:boolean);
 begin
  debug:=b;
 end;

Procedure drawedit(x1,y1,x2,y2:integer;text:ansistring);
 var text1:ansistring;x,y:integer;
 begin
  setcolorRGBA(editcolor.r,editcolor.g,editcolor.b,editcolor.a);
  bar(x1,y1,x2,y2);
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
 end;
begin
 debug:=false;
end.
