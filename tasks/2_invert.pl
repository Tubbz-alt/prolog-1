% Разработать правила, реализующие предикат invert(L1, L2).
% Предикат удовлетворен, если список L2(L1) является инверсией списка L1(L2).
% Например:
%     ?- invert([a,b,c], [c,X,a]).
%     X=b

invert([],[]). 
invert([Head|Tail], Inverted):-  invert(Tail, RevertedTail),  append(RevertedTail, [Head], Inverted).
