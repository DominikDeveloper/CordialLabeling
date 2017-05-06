:- use_module(library(clpfd)).

edge(a,b,ab).
edge(a,d,ad).
edge(b,d,bd).
edge(b,c,bc).
edge(c,e,ce).
edge(d,f,df). 

przyk5(Sol) :-
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