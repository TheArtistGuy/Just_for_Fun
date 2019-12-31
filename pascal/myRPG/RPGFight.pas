program RPGFight(input, output);
uses crt;
{Programm zur Abhandlung von Kämpfen in einem RPG, noch sehr Ausbaufähig}
  
  const 
  atkmed = 20;
  WVierzig = 40;
  MonsterMax = 100;
  InvPlaetze = 10;
  
  
  type 
  tItem = record
            name     : string;
            Art      : char; 
            staerke  : integer;
            equipped : boolean;
          end;
  tItemlist = array [1..InvPlaetze] of tItem;
  
  tChar = record
	          name     : string;
       	    atk,
            dmg,
	          hlthmax,
	          hlthakt,
	          Lvl,
            XP       : integer;
            inventar : tItemList;
          end;
  tMonsterLst = array [1..MonsterMax] of tChar;			  	 
				  	 

          
  var
  tMonsterListe : tMonsterLst;
  tHero, 
  tEnemy        : tChar;
  key           : char;
  counter,
  Monsterakt    : integer;
  HeroName      : string;

  function ReadMonsters (var outMonsterAktuell : integer)  : tMonsterLst;
  {Funktion zur Auslesen der Gegenerliste aus einer externen Datei}
  	const
  	MonsterDat = './enmy.txt';
  	
  	var
  	gelesenStr : string;
  	gelesenint,
  	i          : integer;
		Datei 		 : text;
		
  begin

   Assign (Datei, MonsterDat);
   Reset (Datei);
   if not (EOF (Datei)) then {falls nicht leer}
   begin
     i:= 0;
     while not (EOF (Datei)) and (i <= MonsterMax) do
     begin
        i := i+1;
        readln (Datei, gelesenstr);
        ReadMonsters[i].name := gelesenstr;  
        readln (Datei, gelesenint);
        ReadMonsters[i].atk := gelesenint;
        readln (Datei, gelesenint);
        ReadMonsters[i].dmg := gelesenint;
        readln (Datei, gelesenint);
        ReadMonsters[i].hlthmax := gelesenint ;   
        ReadMonsters[i].hlthakt := ReadMonsters[i].hlthmax;
        readln (Datei, gelesenint);
        ReadMonsters[i].XP := gelesenint;
        readln (Datei, gelesenint);
        ReadMonsters[i].Lvl := gelesenint ;
        readln (Datei)
      end;
      outMonsteraktuell := i
    end
    else
      writeln ('Enmy.txt konnte nicht geoeffnet werden'); 
    close (Datei);
  end;{ReadMonsters}	



  function Wuerfel (inMax : integer) : integer;
  {Funktion zum erzeugen eines Zufallswertes}
        
  begin
    randomize;
    Wuerfel := Random (inMax); 
  end; { Wuerfel} 

  function GegnerBestimmen (inListe : tMonsterLst; inHero : tChar; inMax : integer) : tChar;
  {Funktion zum Auswählen eines Monsters aus der Liste}
  
    var i : integer;
    
  begin
    i := 1;
    {Bestimmen der Auswahl. Geht davon aus, dass die Liste nach Lvl aufsteigend sortiert ist}
    while (inListe[i].Lvl <= inHero.Lvl) and (i <= inMax) do  
      i := i + 1;
    
    {Zufällige Auswahl}
    i := wuerfel(i-1) + 1; {Damit keine 0 Entstehen kann}
    GegnerBestimmen := inListe[i];
          
  end;  

  
  procedure LevelUp (var ioHero : tChar);
  {Prozedur zum ausführen eines Levelups} 
  begin
    if ioHero.XP > (50 * (ioHero.Lvl * ioHero.Lvl)) then
    begin
      writeln (50 * (ioHero.Lvl * ioHero.Lvl));
      ioHero.Lvl := ioHero.Lvl + 1;
      writeln (50 * (ioHero.Lvl * ioHero.Lvl));
      ioHero.atk := ioHero.atk + 1;
      ioHero.dmg := ioHero.dmg + 1;
      ioHero.hlthmax := ioHero.hlthmax + 4;
      ioHero.hlthakt := ioHero.hlthmax;
      writeln(ioHero.name, ' LEVELT AUF ! Level : ', ioHero.Lvl);
    end
  end; {levelUp}

  procedure Inventar (var ioHero : tchar);
  {Prozedur zur Verwaltung des Inventars}
  var
  i,
  j : integer;
  E : Char;
    
  
  begin
    repeat
      for i := 1 to InvPlaetze do
      begin
        write (i:2, ' : ', ioHero.inventar[i].name, ' ', ioHero.inventar[i].Art, ioHero.inventar[i].staerke);
        if ioHero.Inventar[i].equipped = true then
          writeln ('  [E]')
        else
          writeln;
      end;
      writeln;
      writeln ('[A]nlegen, A[B]legen, [W]egwerfen, E[X]it');
      repeat
        E := Readkey;
      until ((E = 'a') or (E = 'A') or (E = 'b') or (E = 'B') or (E = 'w') or (E = 'W') or (E = 'x') or (E = 'X'));
      
      if ((E = 'a') or (E = 'A')) then
      begin 
        write ('Welcher Gegenstand soll ausgerüstet werden ? '); 
        readln (j);
        if ioHero.inventar[j].Art = ' ' then 
          writeln ('Kann nicht ausgeruestet werden.');
        if ioHero.inventar[j].Art = 'W' then
        begin
          ioHero.dmg := ioHero.dmg + ioHero.inventar[j].staerke;
          ioHero.inventar[j].equipped := true;
          writeln (ioHero.inventar[j].name, ' wurde ausgerüstet') 
        end;
        if ioHero.inventar[j].Art = 'A' then
        begin
          ioHero.atk := ioHero.atk + ioHero.inventar[j].staerke;
          ioHero.inventar[j].equipped := true;
          writeln (ioHero.inventar[j].name, ' wurde ausgerüstet') 
        end;        
        if ioHero.inventar[j].Art = 'P' then
        begin
          ioHero.hlthakt := ioHero.hlthakt + ioHero.inventar[j].staerke;
          if ioHero.hlthakt > ioHero.hlthmax then
            iohero.hlthakt := ioHero.hlthmax;
          ioHero.inventar[j].name := 'leer';
          ioHero.inventar[j].Art :=  ' ';
          ioHero.inventar[j].staerke := 0;
          ioHero.inventar[j].equipped := false;
          writeln (ioHero.inventar[j].name, ' wurde ausgerüstet') 
        end;        
        
      if ((E = 'b') or (E = 'B')) then
      begin 
        write ('Welcher Gegenstand soll abgelegt werden ? '); 
        readln (j);
        if ioHero.inventar[j].equipped = false then 
          writeln ('Kann nicht abgelegt werden.')
        else
        begin
          if ioHero.inventar[j].Art = 'W' then
          begin
            ioHero.dmg := ioHero.dmg - ioHero.inventar[j].staerke;
            ioHero.inventar[j].equipped := false;
            writeln (ioHero.inventar[j].name, ' wurde abgelegt') 
          end;
          if ioHero.inventar[j].Art = 'A' then
          begin
            ioHero.atk := ioHero.atk - ioHero.inventar[j].staerke;
            ioHero.inventar[j].equipped := false;
            writeln (ioHero.inventar[j].name, ' wurde abgelegt') 
          end                     
        end
      end;
      
      if ((E = 'w') or (E = 'W')) then
      begin
        write ('Welcher Gegenstand soll weggeworfen werden ? '); 
        readln (j);
        if ioHero.inventar[j].name = 'leer' then
          writeln ('Das Fach ist Leer')
        else 
        begin
          ioHero.inventar[j].name := 'leer';
          ioHero.inventar[j].Art :=  ' ';
          ioHero.inventar[j].staerke := 0;
          ioHero.inventar[j].equipped := false;
        end;
      end;    
      end;    
    until ((E = 'x') or (E = 'X'))
  end; {Inventar}
  
  
  procedure encounter (var ioHero, inMonster : tChar);
  {Procedur zur Verwaltung von Begegnungen}
  
    var 
    Enemy : tChar;
  
    procedure battle ( var ioCharO, ioCharT : tChar);
    {Unter - Prozedur zum Abhandeln von Kämpfe}
    
      begin
        if (ioCharO.hlthakt > 0) and (ioCharT.hlthakt > 0) then
        {wenn LP nicht 0}
        begin
          write (ioCharO.Name, ' greift an : ');
          if Wuerfel (WVierzig) > (atkmed - (ioCharO.atk - ioCharT.atk)) then
          {Falls getroffen}
          begin
            ioCharT.hlthakt := ioCharT.hlthakt - ioCharO.dmg;
            writeln (ioCharT.name, ', wurde getroffen für ', ioCharO.dmg,' Schaden');
	    writeln ('Noch ', ioCharT.hlthakt, 'LP')
  	  end
  	  else
  	    writeln ('verfehlt');
  	    battle(ioCharT, ioCharO); {Rekursiver Aufruf mit vertauschten Rollen}	            
        end;
      end; {battle}
  
  begin
    Enemy := inMonster;
    write   ('Begegnung zwischen ', ioHero.name, ' ', ioHero.hlthakt,' LP  und ');
    writeln (Enemy.name, ' ', Enemy.hlthakt, 'LP '); 
    battle (ioHero, Enemy);
    if ioHero.hlthakt < 1 then  
    begin
      writeln (ioHero.name, ' ist gestorben');
      Enemy.XP  := Enemy.XP + ioHero.XP
    end;
    if Enemy.hlthakt < 1 then 
    begin
      writeln (Enemy.name, ' ist gestorben');
      ioHero.XP  := ioHero.XP + Enemy.XP;
    end;  
    writeln;
  end; {encounter}
  
  


begin
  write ('Name des Helden eingeben : ');
  readln (HeroName);
  writeln;
  tHero.name := HeroName;
  tHero.atk := 5;
  tHero.dmg := 3;
  tHero.hlthmax := 20;
  tHero.hlthakt := tHero.hlthmax;
  tHero.XP := 0;
  tHero.Lvl := 1;	
  for counter := 1 to Invplaetze do
  begin
    tHero.inventar[counter].name := 'leer';
    tHero.inventar[counter].Art :=  ' ';
    tHero.inventar[counter].staerke := 0;
    tHero.inventar[counter].equipped := false;
  end;
  
  Monsterakt := 0;
  tMonsterListe := ReadMonsters (Monsterakt);
  repeat 
    tEnemy := GegnerBestimmen(tMonsterListe, tHero, Monsterakt);        
    encounter(tHero, tEnemy );
    if tHero.XP > (50 * (tHero.Lvl * tHero.Lvl)) then
        LevelUp (tHero);    
    writeln ('Ein weiterer Kampf ? (j/n)');
    repeat
      key := Readkey;
    until ((key = 'n') or (key = 'N') or (key = 'j') or (key = 'J')) 
  until ((key = 'n') or (key = 'N') or (tHero.hlthakt < 1));
  writeln ('GAME OVER') 
 
end.
 {RPGFight}
