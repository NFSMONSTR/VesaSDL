{ example3.pas - example of using VesaSDL

Copyright (c) 2015-2016 NFS_MONSTR(Maxim Belyaev)

This software is provided 'as-is', without any express or implied
warranty. In no event will the authors be held liable for any damages
arising from the use of this software.

Permission is granted to anyone to use this software for any purpose,
including commercial applications, and to alter it and redistribute it
freely, subject to the following restrictions:

    1. The origin of this software must not be misrepresented; you must not
       claim that you wrote the original software. If you use this software
       in a product, an acknowledgement in the product documentation would
be
       appreciated but is not required.
    2. Altered source versions must be plainly marked as such, and must not
be
       misrepresented as being the original software.
    3. This notice may not be removed or altered from any source
distribution.
}

Program Example3;
Uses VesaSDL,InputSDL;{Let's use video and input subsystem}
Var Image:pointer; x,y:integer;
Begin
 InitAllX(800,600,false,'Example3');{Init main and video subsystem
 and create window 800x600 with title'Example3'}
 InputInit;{Init input subsystem.
 Important to call InputInit after InitAll or InitAllX}

 Image:=LoadImage1('example3.png');{Load some picture named 'example3.png'}

 x:=0; y:=0;{Left corner of screen}

 While keys[kEsc]=0 do
  begin
    ClearScreen;
    PutImage1(x,y,Image);{Draw picture}
    UpdateScreen;{Update image on screen}
    InputUpdate;{Update state of keyboard}
    if (keys[kLeft]<>0) then{Move image by arrows}
     x:=x-10;
    if (keys[kRight]<>0) then
     x:=x+10;
    if (keys[kUp]<>0) then
     y:=y-10;
    if (keys[kDown]<>0) then
     y:=y+10;
  end;


 DoneAll;{Destroy window, and done SDL2}


End.

