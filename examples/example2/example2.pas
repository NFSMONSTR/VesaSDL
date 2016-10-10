{ example2.pas - example of using VesaSDL

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

Program Example2;
Uses VesaSDL;
Var Image:pointer;
Begin
 InitAllX(800,600,false,'Example1');{Create window 800x600 with title 'Example1'}

 Image:=LoadImage1('example2.png');{Load some picture named 'example2.png'}

 PutImage1(apw div 2,aph div 2,Image);{Draw picture to center of screen}


 UpdateScreen;{Update image on screen}

 Delay(5000);{Wait 5 sec so we can see the result}
 DoneAll;{Destroy window, and done SDL2}


End.
