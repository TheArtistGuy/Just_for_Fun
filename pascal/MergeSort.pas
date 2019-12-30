program MergeSort(input, output);
{Programm zur Sortierung einer linearen Liste nach dem Mergesort Verfahren}

  type
  tRefIntList = ^tIntList;
  tIntList = record
                Zahl : integer;
                next :trefintList;
             end;
  
  var
  AusgLst,
  tRefLst : tRefIntList;
  

  function Eingabe : tRefIntList;
  {Funktion zur Eingabe einer linearen Liste}
    var
    RootList,
    NewList : tRefIntList; 
    E       : integer;
    
  begin
    new(RootList);
    RootList^.Zahl := 0;
    RootList^.next:= nil;
    writeln ('Eine Liste von Zahlen eingeben. 0 beendet die Eingabe');
    repeat
    begin  
      readln (E);
      if E <> 0 then
      begin
          new (NewList);
          NewList^.Zahl := E;
          NewList^.next := RootList;
          RootList := NewList
      end;
    end;  
    until E = 0;
    Eingabe := RootList;
  end;{Eingabe}

  function merge (var iolinks, iorechts : tRefIntList) : trefIntList;
  {Funktion zum Sortierten und Zusammenführen zweier linearer Listen}
    var
    ListeEnde,  
    ListeAnf : tRefIntList;
    
  begin
    new (ListeAnf);
    ListeAnf := nil;
    new (ListeEnde);    
    while ((iolinks <> nil) and (iorechts <> nil)) do
    {falls Elemente in beiden Listen}
    begin
      if iolinks^.Zahl <= iorechts^.Zahl then
      begin
        if ListeAnf = nil then
        begin
          ListeEnde := iolinks;
          iolinks := iolinks^.next;
          ListeEnde^.next := nil;
          ListeAnf := ListeEnde
        end
        else
        begin 
          ListeEnde^.next := iolinks;
          ListeEnde := ListeEnde^.next;
          iolinks := iolinks^.next;
          ListeEnde^.next := nil;
        end;
      end
      else
      begin
        if ListeAnf = nil then
        begin
          ListeEnde := iorechts;
          iorechts := iorechts^.next;
          ListeEnde^.next := nil;
          ListeAnf := ListeEnde
        end
        else
        begin 
          ListeEnde^.next := iorechts;
          ListeEnde := ListeEnde^.next;
          iorechts := iorechts^.next;
          ListeEnde^.next := nil;
        end;
      end      
    end;  
    while iolinks <> nil do 
    {falls nur Links noch Elemente}
    begin
        if ListeAnf = nil then
        begin
          ListeEnde := iolinks;
          iolinks := iolinks^.next;
          ListeEnde^.next := nil;
          ListeAnf := ListeEnde
        end
        else
        begin 
          ListeEnde^.next := iolinks;
          ListeEnde := ListeEnde^.next;
          iolinks := iolinks^.next;
          ListeEnde^.next := nil;
        end;
    end;
    while iorechts <> nil do
    {falls nur Rechts noch Elemente}
    begin
      if ListeAnf = nil then
        begin
          ListeEnde := iorechts;
          iorechts := iorechts^.next;
          ListeEnde^.next := nil;
          ListeAnf := ListeEnde
        end
        else
        begin 
          ListeEnde^.next := iorechts;
          ListeEnde := ListeEnde^.next;
          iorechts := iorechts^.next;
          ListeEnde^.next := nil;
        end;
    end;
    
    merge := ListeAnf;
  end; {merge}

  function mergesort(var ioListe : tRefIntList) : trefintList;
  {Funktion zur Aufspaltung und sortierten zusammenführung von linearen Listen}
    var 
    LstRechts,
    LstLinks,
    HilfsLst : tRefIntList;
    i,
    Laenge   : integer;
    
    
  begin
    if (ioListe = nil) or (ioListe^.next = nil) then
      mergesort := ioListe
    else
    begin
      new(HilfsLst);
      new (LstRechts);
      new (LstLinks);
      Laenge := 0;
      i:= 0;
      HilfsLst := ioListe;
      while HilfsLst <> nil do
      {Bestimmen der Länge der Liste}
         begin
           HilfsLst := HilfsLst^.next;
           Laenge := Laenge + 1
         end;
       HilfsLst := ioListe;  
       while i < ((Laenge -1) div 2) do
       {Zur Mitte der Liste gehen}
       begin
         HilfsLst := HilfsLst^.next;
         i := i + 1
       end;
       {Teilen der Liste}
       LstRechts := HilfsLst^.next;
       HilfsLst^.next := nil;
       LstLinks := ioListe;
       
       {rekursiver Aufruf}
       if LstLinks <> nil then
         LstLinks  := mergesort (LstLinks);
       if LstRechts <> nil then
         LstRechts := mergesort (LstRechts);
       
       mergesort:= merge (LstLinks, LstRechts);
    end; 
  end; {mergesort}
  
  
  
  
begin
  new (tRefLst);
  new (AusgLst);
  tRefLst := Eingabe;
  AusgLst := mergesort (tRefLst);
  while AusgLst <> nil do
  {Ausgabe}
  begin
    write(AusgLst^.Zahl, ', ');
    AusgLst := AusgLst^.next 
  end;
end.
