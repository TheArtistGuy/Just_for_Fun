program GameofLife (input, output);
{Programm zum Berechnen und Ausgeben von Conways Spiel des Lebens.}
uses Crt;
	
	const
	Zeilen = 25;
	Spalten = 30;
		
	type
	tFeld = array [1..Zeilen,1..Spalten] of char;
	
	var
	Feld : tFeld;
	C : char;
	Pop : integer;
	
	function Eingabe : tFeld;
	{Prozedur zur Eingabe des Ausgangsarrays}
		var
		temp : tFeld;
		i, 
		j : integer; {Laufvariablen}
	
	begin
		writeln ('X (lebendig) oder O (leer) eingeben');
		writeln (Zeilen * Spalten, ' Felder : ');
		writeln;
		for i := 1 to Zeilen do
		begin
			for j:= 1 to Spalten do
			begin
				(temp [i,j]) := ReadKey;
				write(temp [i,j] :2);		
			end;
		writeln;	
		end;
		Eingabe := temp 
	end; {Eingabe}
	
	function exists (	inY, 
										inX : integer) : boolean;
	{Funktion zur Bestimmung ob ein angesprochenes Feld existiert}									
	begin
		if ((inX <= Spalten) and (inX >= 1) and (inY <= Zeilen) and (inY >= 1)) then
			exists := true
		else
			exists := false		
	end; {exists}									
	
	
	function alive (inY, inX :integer;
									inFeld : tFeld) : boolean;
	{Funktion zur Ermittlung ob das angegebene Feld lebendig ist}
	begin
		if (inFeld [inY, inX] = 'x') or (inFeld [inY, inX] = 'X') then
			alive := true
		else
			alive := false
	end;{alive}
	
	function Nachbarn (inY, inX : integer;
										inFeld : tFeld) : integer;
	{Funktion zur Bestimmung der Zahl der lebenden Nachbarn von inFeld[y,x]}
	
	var Zahl : integer;
	
	begin
		Zahl:= 0;
		if exists(inY-1,inX-1) then 
			begin
				if alive(inY-1,inX-1, inFeld) then
					Zahl := Zahl+1
			end;
			
		if exists(inY-1,inX) then 
			begin
				if alive(inY-1,inX, inFeld) then
					Zahl := Zahl+1
			end;	
		
		if exists(inY-1,inX+1) then 
			begin
				if alive(inY-1,inX+1, inFeld) then
					Zahl := Zahl+1
			end;
		
		if exists(inY,inX-1) then 
			begin
				if alive(inY,inX-1, inFeld) then
					Zahl := Zahl+1
			end;
		
		if exists(inY,inX+1) then 
			begin
				if alive(inY,inX+1, inFeld) then
					Zahl := Zahl+1
			end;
		
		if exists(inY+1,inX-1) then 
			begin
				if alive(inY+1,inX-1, inFeld) then
					Zahl := Zahl+1
			end;
		
		if exists(inY+1,inX) then 
			begin
				if alive(inY+1,inX, inFeld) then
					Zahl := Zahl+1
			end;
			
		if exists(inY+1,inX+1) then 
			begin
				if alive(inY+1,inX+1, inFeld) then
					Zahl := Zahl+1
			end;
		
		Nachbarn := Zahl			
	end; {Nachbarn}									
	
	procedure PopulationPlus (var ioFeld : tFeld);
	{Prozedur zum Berechnen der nächsten Population}
		var
		x,
		y : integer;
		newFeld : tFeld;
		
	begin
		for y := 1 to Zeilen do
		begin
			for x:= 1 to Spalten do
			begin
				if alive(y,x, ioFeld) then
				begin
					if ((nachbarn(y, x, ioFeld) = 3) or (nachbarn(y, x, ioFeld) = 2)) then
						newFeld [y,x] := 'X'
					else
						newFeld[y,x] := ' ';
				end
				else
					if nachbarn (y, x, ioFeld) = 3 then
						newFeld [y,x] := 'X'
					else
						newFeld [y,x] := ' ';
			end;		
		end;
		ioFeld := newFeld;
	end;
	
	procedure Ausgabe (inFeld : tFeld; 
										 inPop :integer);
	{Procedur zum Anzeigen des aktuellen Arrays}
		
		var
		x,
		y : integer;
		
	begin
		clrscr;
		writeln ('Population : ', Pop);
		writeln;
		for y := 1 to Zeilen do
		begin
			for x:= 1 to Spalten do
			begin
				write (inFeld [y,x]:2)		
			end;
			writeln;
		end;
	end; {Ausgabe}
	
begin
	Pop := 0;
	Feld := Eingabe;
	repeat
	begin	
		Ausgabe(Feld, Pop);
		writeln;
		write ('Naechste Population Anzigen (ENTER) oder Exit (Q) : ');
		readln (C);
		Pop := Pop +1;
		PopulationPlus (Feld)
	end;	
	until ((C = 'q') or (C = 'Q'))
end. {GameOfLife}
