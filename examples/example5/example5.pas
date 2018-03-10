{ example5.pas - example of using VesaSDL and AudioSDL

Copyright (c) 2015-2018 NFS_MONSTR(Maxim Belyaev)

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

Program example5;
Uses VesaSDL,AudioSDL;
var p:pointer;
begin
 if paramcount>=1 then
  begin
   InitSDL;{Init SDL2, but don't create window}
   InitAudio(Mono);
    p:=LoadMusic(paramstr(1));{Load music file with name from command line params}
    PlayMusic(p,0);
    while PlayingMusic do
     Delay(100);
   DoneAudio;
   Doneall;
  end
  else
  begin
   writeln('Missing filename');
   writeln('Example: example5 <SomeMusicFile>');
  end;
end.
