program Dijkstra;
type
	list	 = array [-1..100000] of real;
	charlist = array [-1..100000] of char;
var
	sources		: charlist;
	destinations	: charlist;
	weights		: list;

	space		: char;
	counter		: integer;
begin
	counter := 0;
	sources[-1] := 'A';
	space := ' ';

	{ Inputing the weighted edge list }
	while sources[counter - 1] <> '!' do
	begin
		{OMFG it reads the stupid space as an fucking input this is so retarded!}
		readln(	sources[counter], space,
			destinations[counter], space,
			weights[counter]);

		counter := counter + 1;
	end;


	{ Outputing the list for a test }
	counter := 0;
	while sources[counter - 1] <> '!' do
	begin
		writeln( sources[counter], space,
			 destinations[counter], space,
			 weights[counter]);

		counter := counter + 1;
	end;
end.
