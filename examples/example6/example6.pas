{ example6.pas - example of using VesaSDL

Copyright (c) 2018 NFS_MONSTR(Maxim Belyaev)

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

Program Example6;
Uses VesaSDL;
Var Image:pointer; angle:double; i:longint;
Begin
 InitAllX(800,600,false,'Example6');{Create window 800x600 with title 'Example2'}

 Image:=LoadImage1('example6.png');{Load some picture named 'example2.png'}


 angle:=0;
 for i:=1 to 500 do
  begin
   ClearScreen;

   PutImage(apw div 2,aph div 2,Image,NormalPut,{Draw picture to center of screen}
            angle,
            100,100) {center of image is (100,100)};


   UpdateScreen;{Update image on screen}

   angle:=angle+0.5;

   delay(10);
  end;

 DoneAll;{Destroy window, and done SDL2}


End.
