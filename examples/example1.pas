Program Example1;
Uses VesaSDL;{Use only video subsystem}
Begin
 InitAllX(800,600,false,'Example1');{Create window 800x600 with title 'Example1'}

 SetColorRGBA(255,255,255,255);{Set white color}
 Bar(0,0,apw,aph);{Draw white filled rectangle on whole screen}

 SetColorRGBA(0,255,0,255);{Set Green color}
 Ellipse(apw div 2,aph div 2,200,100);{Draw Ellipse 200x100 in center of screen}

 Bar(apw-100,aph-100,apw+100,aph+100);{Draw green filled rectangle in right down corner of screen}

 UpdateScreen;{Update image on screen}

 Delay(5000);{Wait 5 sec so we can see the result}
 DoneAll;{Destroy window, and done SDL2}
End.
