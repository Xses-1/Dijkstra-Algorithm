program Dijkstra;
type
	intlist	 = array [0..100000] of integer;
	charlist = array [0..100000] of char;
var
	sources		: charlist;
	destinations	: charlist;
	weights		: intlist;
	origin		: char;
	destination	: char;

	space		: char;
	counter		: integer;
	
	processed_vert	: intlist;
	distances	: intlist;
	smallest_edge	: integer;
begin
	counter := 0;
	sources[-1] := 'A';
	space := ' ';

	writeln('Provide the input in the format separated by spaces and with the new line');
	writeln('between each entry of the edge. After the last line write ! as EOF');

	{ Inputing the weighted edge intlist }
	while sources[counter - 1] <> '!' do
	begin
		{OMFG it reads the stupid space as an fucking input this is so retarded!}
		readln(
			sources[counter],
			space,
			destinations[counter],
			space,
			weights[counter]
			);

		counter := counter + 1;
	end;

	writeln('Now provide the origin and destination vertices in one line');
	readln(origin, destination);

	
	{ Dijkstra here }
	{ Initialize the set }
	counter		:= 0;
	distances[0]	:= 0;
	while sources[counter] <> '!' do
	begin
		processed_vert[counter] := 0;
		distances[counter + 1] := 99999999;
		counter := counter + 1;
	end;

	{ Findign the closest vertices and processing them }

	counter := 0;
	while sources[counter - 1] <> '!' do
	begin
		writeln(
			sources[counter],
			space,
			destinations[counter],
			space,
			weights[counter]
			);

		counter := counter + 1;
	end;
end.
