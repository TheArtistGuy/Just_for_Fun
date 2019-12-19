program digit_to_char (input, output);
{Programm um eine Zahl zwischen 0 und 9 in ein Zeichen des Char Typs umzuwandeln}
  
  var
  c : Char;
  z : integer;
  
  
  
  
begin
  z := 100;
  write ('Zahl zwischen 0 und 9 eingeben : ');
  while (z > 9) or (z < 0) do
    readln (z);
  c := chr(z + 48);
  writeln ('Zahl als Char : ', c);
end.
