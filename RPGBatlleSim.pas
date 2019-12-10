program RPGFight(input, output);
uses crt;
{Programm zur Abhandlung von Kämpfen in einem RPG, noch sehr Ausbaufähig}
  
  const 
  atkmed = 20;
  WVierzig = 40;
  
  
  type 
  trefChar  = ^tCharacter;
  tCharacter = record
		 			  		name     : string;
		 			  		atk,
		   		  		dmg,
				    		hlthmax,
					    	hlthakt  : integer;
				  	  	next     : trefChar;
				  	 end;

  var
  trefMonster : trefChar;
  trefHero    : trefChar;
  key         : char;

  function Wuerfel (inMax : integer) : integer;
  {Funktion zum erzeugen eines Zufallswertes}
        
  begin
    randomize;
    Wuerfel := Random (inMax); 
  end; { Wuerfel} 

  procedure encounter (var ioCharOne, ioCharTwo : trefChar);
  {Procedur zur Verwaltung von Begegnungen}
  
	  procedure battle ( var ioCharO, ioCharT : trefChar);
    {Unter - Prozedur zum Abhandeln von Kämpfe}
    
      begin
        if (ioCharO^.hlthakt > 0) and (ioCharT^.hlthakt > 0) then
        {wenn LP nicht 0}
        begin
          write (ioCharO^.Name, ' greift an : ');
          if Wuerfel (WVierzig) > (atkmed - (ioCharO^.atk - ioCharT^.atk)) then
          {Falls getroffen}
          begin
            ioCharT^.hlthakt := ioCharT^.hlthakt - ioCharO^.dmg;
	  				writeln (ioCharT^.name, ', wurde getroffen für ', ioCharO^.dmg,' Schaden');
	  				writeln ('Noch ', ioCharT^.hlthakt, 'LP')
  				end
  				else
  				  writeln (' verfehlt');
  				battle(ioCharT, ioCharO); {Rekursiver Aufruf mit vertauschten Rollen}	            
        end;
      end; {battle}
  
  begin
    write   ('Begegnung zwischen ', ioCharOne^.name, ' ', ioCharOne^.hlthakt,' LP  und ');
    writeln (ioCharTwo^.name, ' ', ioCharTwo^.hlthakt, 'LP '); 
    battle (ioCharOne, ioCharTwo);
    if ioCharOne^.hlthakt < 1 then
      writeln (ioCharOne^.name, ' ist gestorben');
    if ioCharTwo^.hlthakt < 1 then 
      writeln (ioCharTwo^.name, ' ist gestorben');
    writeln;
  end; {encounter}
  

begin
  new (trefHero);
  trefHero^.name := 'Conan';
  trefHero^.atk := 5;
  trefHero^.dmg := 3;
  trefHero^.hlthmax := 20;
  trefHero^.hlthakt := trefHero^.hlthmax;
  trefHero^.next := nil;
  
  repeat
    new (trefMonster);
    trefMonster^.name := 'Ratte';
    trefMonster^.atk := 4;
    trefMonster^.dmg := 1;
    trefMonster^.hlthmax := 5;
    trefMonster^.hlthakt := trefMonster^.hlthmax;
    trefMonster^.next := nil;
          
    encounter(trefHero, trefMonster);

    writeln ('Ein weiterer Kampf ? (j/n)');
    repeat
      key := Readkey;
    until ((key = 'n') or (key = 'N') or (key = 'j') or (key = 'J')) 
  until ((key = 'n') or (key = 'N') or (trefHero^.hlthakt < 1));
  writeln ('GAME OVER') 
 
end.
 {RPGFight}
  
