:- use_module(library(clpfd)).
%:- initialization(start).


readFile(Stream,[]) :-
    at_end_of_stream(Stream).

readFile(Stream,[X|L]) :-
    \+ at_end_of_stream(Stream),
    read(Stream,X),
    readFile(Stream,L).
		
%----------

sub_list([], 0).
sub_list([H|T], Sub):-
		sub_list(T, Rest),
		Sub is H - Rest.

%region abs sub list which is in list (example: [[1,3],[7,-1]] --> [4,8])
absSubElemListInList([FirstList|Tail], FinalResult):-
	absSubElemListInList([FirstList|Tail], [], FinalResult).
	
absSubElemListInList([], R):-
	R = 0.
	
absSubElemListInList([FirstList|Tail], StashList, Q):-
	sub_list(FirstList, SubElem),
	AbsSubElem is abs(SubElem),
	%writeln(SubElem),
	append(StashList, [AbsSubElem], Accumulator),
	%writeln(Accumulator),
	%writeln(Tail),
	absSubElemListInList(Tail, Accumulator, Q).
	
absSubElemListInList([], L, NL):-
	NL = L.
%endregion


clpfd_Solver(AllObj, Edges, Vertexes):-
	AllObj ins 0..1,	
	labeling([leftmost], AllObj),
	
	length(Vertexes, VertexNumber),
	length(Edges, EdgeNumber),
	sum_list(Edges, EdgeSum),
	sum_list(Vertexes, VertexSum),
	VertexSum >= floor(VertexNumber / 2),
	VertexSum =< ceiling(VertexNumber / 2),	
	EdgeSum >= floor((EdgeNumber) / 2),
	EdgeSum =< ceiling((EdgeNumber) / 2).
	

solve(AllObjects,ConnectVertexes,Edges,Vertexes):-
	clpfd_Solver(AllObjects, Edges, Vertexes),
	absSubElemListInList(ConnectVertexes, VertexSubstractions),

	Edges = VertexSubstractions,

	labeling([leftmost],Edges),

	append([Vertexes], [Edges], VertexesPlusEdges),

	writeln(VertexesPlusEdges),
	false.
	
start:-
	open('input.txt', read, Str),
	readFile(Str,Lines),
	%writeln(Lines),
	close(Str),!, 
	
	nth0(0,Lines,InString),
	
	nth0(0,InString,Vertexes),

	%write('Vertexes: '), writeln(Vertexes),
	
	nth0(1,InString,Edges),
	
	nth0(2,InString,ConnectVertexes),
	
	append(Vertexes, Edges, AllObjects),
	
	solve(AllObjects, ConnectVertexes, Edges, Vertexes).
	