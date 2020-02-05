program PascalDr (input, output);
{Programm zur berechnung und Ausgabe des pascalschen Dreiecks} 
  type 
  tRefListe = ^tListe;
  tListe    = record
                wert : integer;
                next : tRefListe
              end;

  var 
  Liste,
  AusgList : tRefListe;
  i,
  Zeilen   : integer;
  
  
  function pascalDreieck (inListeAlt: tRefListe) : tRefListe;
  {iterative Funktion zur Berechnung einer Zeile im pascalschen Dreieck}
  
    var 
    newListAnf,
    newList,
    temp : tRefListe;
    
  begin
    {Initialisierung}
    new(newList);
    newList^.wert:= 1;
    newList^.next := nil;
    newListAnf := newList;
    
    {Berechnung}
    while inListeAlt^.next <> nil do
    begin
      new (temp);
      temp^.wert := inListeAlt^.wert + inListeAlt^.next^.wert;
      temp^.next:= nil;
      
      {Anhängen an Liste}
      newList^.next := temp;
      newList := newList^.next;
      inListeAlt := inListeAlt^.next;
    end;
    
    new(temp);
    temp^.wert:= 1;
    temp^.next := nil;
    newList^.next := temp;
    
    pascalDreieck := newListAnf
  end; {pascalDreieck}
  
begin {main}
  new (Liste);
  Liste^.wert := 1;
  Liste^.next := nil;
  
  write ('Wie viele Zeilen des pascalschen Dreiecks ausgeben ? : ');
  readln (Zeilen);
  
  {Ausgabe und Berechnung}
  for i := 1 to Zeilen do
  begin
    new (AusgList);
    AusgList := Liste;
    while AusgList <> nil do
    begin
      write (AusgList^.wert, ' ');
      AusgList := AusgList^.next;
    end;
    writeln;
    Liste := pascalDreieck(Liste);
  end
end. {PascalDr}  
   
  
