{ AudioSDL.pas - Sound subsystem of VesaSDL

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
Unit AudioSDL;
interface
Uses SDL2_mixer;
Const
  {channels for initaudio}
  mono=1;
  stereo=2;
  {channel for playEffect}
  all=-1;
Procedure InitAudio(channels:word);
Procedure DoneAudio;
Function LoadMusic(path:ansistring):pointer;{WAVE,MOD,MIDI,OGG,MP3,FLAC}
Function LoadSound(path:ansistring):pointer;{WAVE AIFF RIFF OGG VOC}
Procedure PlayMusic(p:pointer; countplays:word);
Function PlayingMusic:boolean;
Procedure PauseMusic;
Function PausedMusic:boolean;
Procedure ResumeMusic;
Procedure StopMusic;
Procedure PlaySound(p:pointer; channel:integer; countplays:word);
Procedure SetVolumeAll(c:integer);
Procedure SetMusicPosition(c:double);
implementation
Procedure InitAudio(channels:word);
 begin
  if mix_openaudio(44100,MIX_DEFAULT_FORMAT,channels,2048)<0 then
   writeln('Error while init audio');
 end;
Procedure DoneAudio;
 begin
  mix_closeaudio;
 end;
Function loadmusic(path:ansistring):pointer;
 var p:pointer;
 begin
  p:=mix_loadmus(pchar(path));
  if p=nil then writeln('Error while loading '+path);
  loadmusic:=p;
 end;
function loadsound(path:ansistring):pointer;
 begin
  loadsound:=mix_loadwav(pchar(path));
 end;
Procedure PlayMusic(p:pointer; countplays:word);
 begin
  mix_playmusic(p,countplays);
 end;
Function PlayingMusic:boolean;
 begin
  playingmusic:=boolean(mix_playingmusic);
 end;
Procedure PauseMusic;
 begin
  Mix_PauseMusic;
 end;
Function PausedMusic:boolean;
 begin
  pausedmusic:=boolean(mix_pausedmusic);
 end; 
Procedure ResumeMusic;
 begin
  mix_resumemusic;
 end;
Procedure StopMusic;
 begin
  Mix_haltMusic;
 end;
Procedure Playsound(p:pointer; channel:integer; countplays:word);
 begin
  mix_playchannel(channel,p,countplays);
 end;
Procedure SetVolumeAll(c:integer);
 begin
  if c>mix_max_volume then c:=mix_max_volume;
  if c<0 then c:=0;
  mix_volume(all,c);
  mix_volumemusic(c);
 end; 
Procedure SetMusicPosition(c:double);
 begin
  mix_rewindmusic;
  if mix_setmusicposition(c)<>0 then writeln(mix_geterror)
 end;
begin
end.