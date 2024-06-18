program graph_generator;
var 
	N: integer;
	k: integer;
	p: real;
	space: char;

	i: integer;
	j: integer;
	random_thing: real;
	
begin
	space := ' ';

	writeln('Provide the length of the graph (N) and the fixed ' +
		'avarage degree (k) separated by spaces');
	Flush(Output);
	readln(N, space, k);

	p := k / (N - 1);
	writeln(p);

	for i := 0 to N - 1 do
	begin
		for j := i + 1 to N - 1 do
		begin
			random_thing := random();
			{ Just a testing thing to see how random the values actually are }
			{ writeln(random_thing); }

			if random_thing <= p then
			begin
				writeln(i, ' ', j, ' 1');
				writeln(j, ' ', i, ' 1');
			end;
		end;
	end;
end.
