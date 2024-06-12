program Dijkstra;
var
	{ #xx is how Pascal does escape sequences.
	So `adj` is a 2D array indexed by any 8bit ASCII character }
	adj: array [#0..#255, #0..#255] of integer;
	nodes: set of char = [];
	num_nodes: integer;
	count: integer;
	origin: char;
	dest: char;

	i: char;
	j: char;

	node_from: char;
	node_to: char;
	weight: integer;

	this_node: char;
	next_node: char;

	space: char;
	
	dist: array [#0..#255] of integer;
	path: array [#0..#255] of char;
	visited: array[#0..#255] of Boolean;
	new_dist: integer;

function closest(const node: char): char;
	{ Function to find the closest node to a given node }
var
	min_node: char;
	next: char;
begin
	min_node := #0;
	for next in nodes do
	begin
		if (adj[node, next] < adj[node, min_node]) and not visited[next] then
			min_node := next;
	end;
	exit(min_node);
end;

procedure print_path(const node: char);
{ procedure to print path to a node }
var
	from: char;
begin
	from := path[node];
	if from = node then
	begin
		write(from);
		exit();
	end;
	print_path(from);
	write(space, node);
end;

begin
	space := ' ';

	{ initialize adjacency matrix }
	for i := #0 to #255 do
	begin
		for j := #0 to #255 do
		begin
			adj[i, j] := MaxInt;
		end;
	end;

	writeln(
		'Please provide the origin node as a single character ' +
		'then press Enter.'
		);
	Flush(Output);
	readln(origin);

	writeln(
		'Please provide the destination node as a single character ' +
		'then press Enter.'
		);
	Flush(Output);
	readln(dest);

	writeln('Please provide the edges in the format `s d w`, ');
	writeln('where `s` and `d` are the source and destination nodes ');
	writeln('(single character), ');
	writeln('and `w` is the edge weight (integer). ');
	writeln('Provide one entry per line, ');
	writeln('and send EOF when you are done ');
	writeln('(Ctrl + D on mac/linux, Ctrl + Z then Enter on Windows).');
	Flush(Output);

	{ Inputing the weighted edge intlist }
	while not Eof(Input) do
	begin
		{OMFG it reads the stupid space as an fucking input this is so retarded!}
		readln(
			node_from,
			space,
			node_to,
			space,
			weight
			);

		{ update adjacency matrix }
		adj[node_from, node_to] := weight;

		{ initialize distance }
		dist[node_from] := MaxInt;
		dist[node_to] := MaxInt;

		{ initialize visited }
		visited[i] := false;

		{ initialize path }
		path[node_from] := node_from;
		path[node_to] := node_to;

		{ add to set of nodes }
		Include(nodes, node_from);
		Include(nodes, node_to);
	end;

	{ Get number of nodes.
	Yes, to the extent of my knowledge,
	pascal has no builtin way to get the
	number of elements in a set other than
	to iterate over it and increment a
	variable. }
	num_nodes := 0;
	for this_node in nodes do
		Inc(num_nodes);

	{ Initialize distance to origin }
	dist[origin] := 0;
	this_node := origin;

	for count := 0 to num_nodes - 1 do
	begin

		for next_node in nodes do
		begin
			if adj[this_node, next_node] = MaxInt then continue;

			new_dist := dist[this_node] + adj[this_node, next_node];
			if new_dist < dist[next_node] then
			begin
				dist[next_node] := new_dist;
				path[next_node] := this_node;
			end
		end;

		visited[this_node] := true;

		this_node := closest(this_node);
	end;

	writeln('The shortest path from origin to destination is:');
	print_path(dest);
	writeln();
	Flush(Output);

	{
	for this_node in nodes do
		writeln(this_node, space, path[this_node], space, dist[this_node]);
	}

end.
