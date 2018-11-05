% Разработать правила, реализующие предикат uniq(L1, L2).
% Предикат удовлетворен, если список L2 содержит все элементы L1 без повторений. 
% Например:
%     ?- uniq([a, b, a, c, d, d], Z).
%     Z = [a, b, c, d]

delete(_, [], []).
delete(X, [X|Tail], NewList) :- delete(X, Tail, NewList), !.
delete(X, [Head|Tail], NewList) :- delete(X, Tail, Tmp), !, NewList = [Head|Tmp].

uniq([], []).
uniq([Head|Tail], Unique) :- delete(Head, Tail, Cleared), !, uniq(Cleared, UTail), Unique = [Head|UTail].
