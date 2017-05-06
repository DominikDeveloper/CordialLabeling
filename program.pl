:- use_module(library(clpfd)).

edge(a,b,ab).
edge(a,d,ad).
edge(b,d,bd).
edge(b,c,bc).
edge(c,e,ce).
edge(d,f,df). 

len([],0).
len([_|T],N)  :-  len(T,X),  N  is  X+1.

list_sum([Item], Item).
list_sum([Item1,Item2 | Tail], Total) :-
    list_sum([Item1+Item2|Tail], Total).
	
if_all_bool([]).
if_all_bool([H|T]) :-
    H >= 0, H =< 1, integer(H),
    if_all_bool(T).
	
sum_list([], 0).
sum_list([H|T], Sum) :-
   sum_list(T, Rest),
   Sum is H + Rest.
   
m2([A|As], [B|Bs], [A,B|Rs]) :-
    !, m2(As, Bs, Rs).
	m2([], Bs, Bs) :- !.
	m2(As, [], As).
	
merge_list([],L,L ).
merge_list([H|T],L,[H|M]):-
    merge_list(T,M,L).
	

przyklUni([VertexHead|VertexTail], [EdgeHead|EdgeTail], Sol):-
	
	if_all_bool([VertexHead|VertexTail]),
	if_all_bool([EdgeHead|EdgeTail]),
	
	len([VertexHead|VertexTail], VertexNumber),
	write('L. wierzch.: '), writeln(VertexNumber),
	sum_list([VertexHead|VertexTail], VertexSum), 
	write('Suma wartosci wierzch.: '), writeln(VertexSum),
  
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
	append([VertexHead|VertexTail], [EdgeHead|EdgeTail], Sol),
	
	writeln(Sol),
	A+B+C+D+E+F #=3,
	Ab #= abs(A-B),
	Ad #= abs(A-D),
	Bd #= abs(B-D),
	Bc #= abs(B-C),
	Ce #= abs(C-E),
	Df #= abs(D-F),
	Ab+Ad+Bd+Bc+Ce+Df #=3,    
	labeling([leftmost], Sol).


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