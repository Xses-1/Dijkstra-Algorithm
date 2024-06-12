program Dijkstra;
type
	charlist = array [0..100000] of char;
	char_int_map = array [#0..#255] of integer;
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
	
	dist: char_int_map;
	visited: array[#0..#255] of Boolean;
	new_dist: integer;
	smallest_edge	: integer;

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

begin
	space := ' ';

	{ initialize adjacency matrix }
	for i := #0 to #255 do
	begin
		visited[i] := false;
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

	writeln(
		'Please provide the edges in the format `s d w`, ' +
		'where `s` and `d` are the source and destination nodes ' +
		'(single character), ' +
		'and `w` is the edge weight (integer). ' +
		'Provide one entry per line, ' +
		'and send EOF when you are done ' +
		'(Ctrl + D on mac/linux, Ctrl + Z then Enter on Windows).'
		);
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
				dist[next_node] := new_dist;
		end;

		visited[this_node] := true;

		this_node := closest(this_node);
	end;

	for this_node in nodes do
		writeln(this_node, space, dist[this_node]);

end.
