Program karteisystem (input, output);
{Programm zum anlegen und verwalten einer Büchersammlung.}
uses Crt;

  type
  trefVektor = ^trefBuch;
  trefBuch   = record
                  Titel,
		  Autor : String;
		  next : tRefVektor;
		end;
			
  var
  Bib : trefVektor;	
	
	
  procedure	Speichern (var inBib : trefVektor);																			
  {Prozedur zum Speichern der Bibliothek in einer Datei}	
    
    var
    Dateiname : String;
    Datei : text;
    SpeicherPointer : tRefVektor;
				
  begin
    Speicherpointer := inBib;
    write ('Datei zum Speichern : ');
    readln (Dateiname);
    assign (Datei, Dateiname);
    rewrite (Datei);
    while Speicherpointer <> nil do
    begin	
      writeln (Datei, Speicherpointer^.Autor);
      writeln (Datei, Speicherpointer^.Titel);
      Speicherpointer := Speicherpointer^.next
    end;{while}	
    close (Datei)
  end;	{Speichern}
		
	
  function Laden : trefVektor;																					
  {Procedur zum Laden einer Bibliothek}
    var
    gelesen,
    Dateiname : String;
    Datei     : text;
    newBib,
    newBibAnf,
    temp : tRefVektor;
		
  begin
    new (newBib);
    new (newBibAnf);
    writeln ('Datei zum Laden : ');
    readln (Dateiname);
    Assign (Datei, Dateiname);
    Reset (Datei);
    if not EOF (Datei) then {Falls Datei nicht leer ist}
    begin
      readln (Datei, gelesen);
      newBib^.Autor := gelesen;
      readln (Datei, gelesen);
      newBib^.Titel := gelesen;
      newBib^.next := nil;
      newBibAnf := newBib;
      while not EOF (Datei) do
      begin
        new(temp);
        readln (Datei, gelesen);
        temp^.Autor := gelesen;
        readln (Datei, gelesen);
        temp^.Titel := gelesen;
        temp^.next := nil;
        newBib^.next := temp;
        newBib := newBib^.next;
      end;
      Laden := newBibAnf
    end; {if not EOF}
    close (Datei);
  end;{Laden}	

		
  procedure BuchAnlegen(var ioBibAnf : trefVektor);
  {Procedur zum eintragen eines neuen Buches in das Verzeichungssystem}	
    var
    Buch,
    Fach :trefVektor;
    gefunden : boolean;
	
  begin
    {neues Buch anlegen}
    new(Buch);
    write ('Titel : ');
    readln (Buch^.Titel);	
    write ('Autor : ');
    readln (Buch^.Autor);
	
    {In Bibliothek einsortieren}
    if ioBibAnf = nil then	{Fall das Bibliothek noch leer}
    begin
      Buch^.next := nil;
      ioBibAnf := Buch
    end
    else
    begin
      if (Buch^.Autor <= ioBibAnf^.Autor) and (Buch^.Titel <= ioBibAnf^.Titel) then
      {Fall ist das Buch mit dem alphabetisch kleinsten Namen des Autors}
      begin
        Buch^.next := ioBibAnf;
	ioBibAnf := Buch
       end
       else
       begin
         Fach := ioBibAnf;
	 gefunden := false;
	 while ((Fach^.next <> nil) and not gefunden) do
	 begin
	   if Fach^.next^.Autor >= Buch^.Autor then
	   begin
	     if Fach^.next^.Autor = Buch^.Autor then
	       begin
	         if Fach^.next^.Titel >= Buch^.Titel then
		   begin
		     Buch^.next := Fach^.next;
		     Fach^.next := Buch;
		     gefunden := true
		   end
	         end
		 else
		 begin
		   Buch^.next := Fach^.next;
		   Fach^.next := Buch;
		   gefunden := true
		 end
	       end;
	       Fach := Fach^.next;
	     end;
	     if not gefunden then
	     begin
	       Fach^.next := Buch;
	       Buch^.next := nil
	     end
	  end {else}
      end {else}
  end; {BuchAnlegen}		
				
				
  procedure Anzeigen (inBibAnf : trefVektor);
  {Prozedur zum Anzeigen der Bibliothek}
    var
      BuchAkt : tRefVektor;
		
  begin
    BuchAkt := inBibAnf;
    while BuchAkt <> nil do
    begin
      writeln (Buchakt^.Autor:20,' :  ',BuchAkt^.Titel);
        BuchAkt := BuchAkt^.next;
    end;
    write ('weiter mit Tastendruck..');
    repeat until keypressed;
  end;{Anzeigen}	


  Procedure AutorSearch (inBib : trefVektor);
  {Procedur um Bücher eines Autors zu suchen und die gefundenen auf dem
  * Bildschirm auszugeben}
    var
      tempList : trefVektor;
      Autor : string;
		
  begin
    tempList := inBib;
    write ('Gesuchter Autor : ');
    readln (Autor);
    while tempList <> nil do
    begin
      if tempList^.Autor = Autor then
        writeln (tempList^.Autor:20,' :  ',tempList^.Titel);
      tempList := tempList^.next
    end; {while}
    writeln;
    writeln ('Weiter mit KEYPRESS');
    repeat until Keypressed;
  end; {AutorSearch}	
	
	
  procedure BuchEntfernen (var ioBib : trefVektor);
  {Prozedur zum entfernen eines Buches aus der Liste}
     var
       Laeufer : trefVektor;
       Autor,
       Titel : String;
	
  begin
    write ('Autor des zu entfernenden Buches eingeben : '); 
    readln (Autor);
    write ('Titel des zu entfernenden Buches eingeben : ');
    readln (Titel);
    if ((ioBib^.Autor = Autor) and (ioBib^.Titel = Titel)) then
      ioBib := ioBib^.next
    else
    begin
      Laeufer := ioBib;
      while Laeufer^.next <> nil do
      begin
        if ((Laeufer^.next^.Titel = Titel) and (Laeufer^.next^.Autor = Autor)) then
	  Laeufer^.next := Laeufer^.next^.next;
	Laeufer := Laeufer^.next
      end;{while}
    end {else}
  end; {BuchEntfernen}
		


  procedure menue(var ioBib : tRefVektor);
  {Hauptmenue}	
    var
      z : integer;
		
  begin
    repeat
      clrscr;
      writeln ('(1) Bibliothek laden');
      writeln ('(2) neues Buch anlegen');
      writeln ('(3) Buch aus Bibliothek entfernen');
      writeln ('(4) Bibliothek anzeigen');
      writeln ('(5) Buecher von Autoren suchen');
      writeln ('(6) Speichern');
      writeln ('(7) Beenden');
      writeln;
      repeat
        readln (z);
      until ((z > 0) and (z < 8));
      writeln;
      if z = 1 then
        ioBib := Laden;
      if z = 2 then
        BuchAnlegen (ioBib);
      if z = 3 then 
        BuchEntfernen (ioBib);
      if z = 4 then 
        Anzeigen (ioBib);
      if z = 5 then 
        AutorSearch (ioBib);
      if z = 6 then
        Speichern (ioBib);
     until z = 7;
  end; {menue}



begin {main}
  new (Bib);
  Bib := nil;
  menue (Bib);
end. {Karteisystem}
