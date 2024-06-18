program Dijkstra;

type
	{ Node struct. Has a `next` pointer to facilitate
	construction of linked list.
	Nodes are determined by looking for unique names in
	edge list 

	`path` is a pointer to the previous node (when walking the shortest path).
	If `path` is a pointer to self, that means the node is not
	initialized, or is the origin node.
	-- maybetree
	}
	Tnode = record
		name: string;
		path: ^Tnode;
		dist: integer;
		visited: boolean;

		next: ^Tnode;
	end;

	{ Edge struct. Has `next` pointer to facilitate making linked list.
	-- maybetree }
	Tedge = record
		source, dest: ^Tnode;
		weight: integer;

		next: ^Tedge;
	end;

	{ Sometime Pascal allows specifying pointer type inline,
	sometimes it demands you specify it explicitly here.
	-- maybetree}
	Pnode = ^Tnode;
	Pedge = ^Tedge;

var
	{ These are (pointers to first elements of)
	linked lists of nodes and edges }
	edges: Pedge;
	nodes: Pnode;

	{ These are set correctly, but not used anywhere else
	in the program. }
	num_edges: integer = 0;
	num_nodes: integer = 0;

function read_until_space(): string;
{ read a string from stdin until space.
 Returns string without space. }
var
	in_string: string;
	in_char: char;

begin
	in_string := '';
	while not Eof(Input) do
	begin
		read(in_char);
		if in_char = ' ' then break;
		in_string := in_string + in_char;
	end;
	exit(in_string);
end;

function new_node(const name: string): Pnode;
{ Allocate and initialize a new node on the heap and return a pointer to it. }
var
	node: ^Tnode;
begin
	new(node);
	node^.name := name;
	node^.path := node;
	node^.dist := MaxInt;
	node^.next := nil;
	node^.visited := False;
	exit(node);
end;

function push_node(const name: string): Pnode;
{ function that handles a new node name read from input.
If the node corresponding to the name already exists,
it returns a pointer to it.
If it doesn't yet exist, it creates it and returns a pointer to it. }
var
	this_node: Pnode;
begin
	this_node := nodes;

	{ special case: this is the first node }
	if this_node = nil then
	begin
		nodes := new_node(name);
		Inc(num_nodes);
		exit(this_node);
	end;

	while this_node^.next <> nil do
	begin
		if this_node^.name = name then exit(this_node);
		this_node := this_node^.next;
	end;

	if this_node^.name = name then exit(this_node);

	this_node^.next := new_node(name);
	Inc(num_nodes);
	exit(this_node^.next);
end;

procedure read_edges();
{ read edge list from stdin until EOF. }
var
	this_edge: Pedge;
	source_name, dest_name: string;
	source_node, dest_node: Pnode;
begin
	new(edges);
	this_edge := edges;

	while true do
	begin
		source_name:= read_until_space();
		dest_name := read_until_space();
		readln(this_edge^.weight);

		source_node := push_node(source_name);
		dest_node := push_node(dest_name);

		this_edge^.source := source_node;
		this_edge^.dest := dest_node;
		Inc(num_edges);

		if eof(input) then
			break
		else
		begin
			{ allocate new edge }
			new(this_edge^.next);
			this_edge := this_edge^.next;
		end;
		this_edge^.next := nil;
	end;
end;

function get_weight(const source: Pnode; const dest: Pnode): integer;
{ iterate through edge list and find the weight of the edge
connecting the two specified nodes.
If no edge is found, return -2 }
var
	this_edge: Pedge;
begin
	this_edge := edges;
	while this_edge <> nil do
	begin
		if (this_edge^.source = source) and (this_edge^.dest = dest) then
			exit(this_edge^.weight);
		this_edge := this_edge^.next;
	end;
	exit(-2);
end;

function closest(): Pnode;
{ find next node to be visited by looking for the unvisited node
with shortest distance. If all nodes visited, return nil}
var
	this_node: Pnode;
	best_node: Pnode;
label skip;
begin
	best_node := nil;
	this_node := nodes;

	while this_node <> nil do
	begin
		if this_node^.visited then goto skip;
		if (best_node = nil) or (this_node^.dist < best_node^.dist) then
		begin
			best_node := this_node;
		end;

		skip:
		this_node := this_node^.next;
	end;

	exit(best_node);
end;

procedure dijkstra();
{ main implementation of dijkstra's algo }
var
	this_node: Pnode;
	next_node: Pnode;
	this_weight: integer = 0;
label skip;
begin
	{ the first node in the linked list is always the starting node,
	per the definition in the main body of the program }
	this_node := nodes;

	while this_node <> nil do
	begin
		next_node := nodes;
		while next_node <> nil do
		begin
			this_weight := get_weight(this_node, next_node);
			if this_weight = -2 then goto skip;

			if this_node^.dist + this_weight < next_node^.dist then
			begin
				next_node^.dist := this_node^.dist + this_weight;
				next_node^.path := this_node;
			end;

			skip:
			next_node := next_node^.next;
		end;
		this_node^.visited := True;
		this_node := closest();
	end;
end;

procedure print_path(const node: Pnode);
{ recursively print shortest path to specified node }
begin
	if node^.path = node then
		write(node^.name)
	else
	begin
		print_path(node^.path);
		write(' ', node^.name);
	end;
end;

var
	source_name: string;
	dest_name: string;

	node: Pnode;
	edge: Pedge;

begin
	nodes := nil;
	edges := nil;

	writeln(
		'Please provide the origin node name (any alphanumeric string) ' +
		'then press Enter.'
		);
	Flush(Output);
	readln(source_name);

	writeln(
		'Please provide the destination node name (any alphanumeric string) ' +
		'then press Enter.'
		);
	Flush(Output);
	readln(dest_name);

	push_node(source_name);
	push_node(dest_name);

	writeln('Please provide the edges in the format `s d w`, ');
	writeln('where `s` and `d` are the source and destination node names ');
	writeln('(any alphanumeric strings), ');
	writeln('and `w` is the edge weight (integer). ');
	writeln('Provide one entry per line, ');
	writeln('and send EOF when you are done ');
	writeln('(Ctrl + D on mac/linux, Ctrl + Z then Enter on Windows).');
	Flush(Output);
	read_edges();

	nodes^.dist := 0;
	dijkstra();

	writeln('The shortest path from origin to destination is:');
	{ Remember, the finish node is second in the linked list }
	print_path(nodes^.next);
	writeln();

end.

