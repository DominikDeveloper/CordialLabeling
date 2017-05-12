:- use_module(library(clpfd)).
:- Dynamic edge/3.

%README: infos about edges and vertexList are available in "input.txt" file. There you can modify values.
%There should be letters (later) but we currently use numbers
%EXAMPLE (write in file):
%edge(Vertex1, Vertex2, Edge)
%...
%[a,b,c,d] --> list of vertexes
%last empty line

	
if_all_bool([]).
if_all_bool([H|T]) :-
    H in 0..1,
    if_all_bool(T).
	
ifVertexesAreGood(List):-
	if_all_bool(List),
	length(List, Len),
	sum_list(List, Sum), 
	Sum >= floor(Len / 2),
	Sum =< ceiling(Len / 2).
	
start:-
	open('input.txt', read, Str),
	readFile(Str,Lines),
	close(Str),!, 
	writeln(Lines),!,
	buildDataFromFile(Lines, VertexList),!,
	
	write('Vertexes: '), writeln(VertexList),
	findall(Z,edge(_,_,Z),Edges),
	findall([Q,W],edge(Q,W,_),VertexPairs),
	retractall(edge(_,_,_)), %delete dynamically edges from memory
	write('Edges: '), writeln(Edges),
	write('VertexPairs: '), writeln(VertexPairs),
	%TODO,
	sumElemListInList(VertexPairs, VertexSumPairs),
	write('VertexSumPairs: '), writeln(VertexSumPairs),
	Edges == VertexSumPairs.


%region sum list which is in list (example: [[1,3],[7,-1]] --> [4,6])
sumElemListInList([FirstList|Tail], FinalResult):-
	sumElemListInList([FirstList|Tail], [], FinalResult).
	
sumElemListInList([], R):-
	R = 0.
	
sumElemListInList([FirstList|Tail], StashList, Q):-
	sum_list(FirstList, SumElem),
	%writeln(SumElem),
	append(StashList, [SumElem], Accumulator),
	%writeln(Accumulator),
	%writeln(Tail),
	sumElemListInList(Tail, Accumulator, Q).
	
sumElemListInList([], L, NL):-
	NL = L.
%endregion
	
%region read file
buildDataFromFile([H|T], L):-
	assert(H),
	buildDataFromFile(T, L).
	
buildDataFromFile([H,_], H).
	
readFile(Stream,[]) :-
    at_end_of_stream(Stream).

readFile(Stream,[X|L]) :-
    \+ at_end_of_stream(Stream),
    read(Stream,X),
    readFile(Stream,L).
%endregion
	
%input for przyk5
%edge(a,b,ab).
%edge(a,d,ad).
%edge(b,d,bd).
%edge(b,c,bc).
%edge(c,e,ce).
%edge(d,f,df). 

przyk5( Sol) :-
	A in 0..1,   
	B in 0..1,   
	C in 0..1,   
	D in 0..1,  
	E in 0..1,   
	F in 0..1,  
	Ab in 0..1,   
	Ad in 0..1,   
	Bd in 0..1,   
	Bc in 0..1,  
	Ce in 0..1,   
	Df in 0..1, 
	Sol = [A,B,C,D,E,F,Ab,Ad,Bd,Bc,Ce,Df],
	A+B+C+D+E+F #=3,
	Ab #= abs(A-B),
	Ad #= abs(A-D),
	Bd #= abs(B-D),
	Bc #= abs(B-C),
	Ce #= abs(C-E),
	Df #= abs(D-F),
	Ab+Ad+Bd+Bc+Ce+Df #=3,    
	labeling([leftmost],Sol).