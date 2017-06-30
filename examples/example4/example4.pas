{ example4.pas - example of using VesaSDL

Copyright (c) 2015-2017 NFS_MONSTR(Maxim Belyaev)

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

Program Example4;
uses VesaSDL;
begin
 InitAllX(800,600,false,'test');

 LoadFont('pathtofont',15,0);{Load some font}

 SetWindowTexture('example4.png');
 SetButtonTexture('example4.png');
 SetLabelTexture('example4.png');
 SetEditTexture('example4.png');

 DrawWindow(50,50,450,150);
 DrawButton(10,10,450,30,'test',false,false);
 DrawLabel(10,160,460,180,'test');
 DrawEdit(10,190,500,400,'test');

 UpdateScreen;

 Delay(10000);

 DoneAll;
end.