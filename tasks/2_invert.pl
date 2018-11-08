% Разработать правила, реализующие предикат invert(L1, L2).
% Предикат удовлетворен, если список L2 (L1) является инверсией списка L1 (L2).
% Например:
%     ?- invert([a,b,c], [c,X,a]).
%     X=b

invert([],[]). 
invert([H|T], Inverted) :-
    invert(T, RevertedT),
    append(RevertedT, [H], Inverted).
