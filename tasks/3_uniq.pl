% Разработать правила, реализующие предикат uniq(L1, L2).
% Предикат удовлетворен, если список L2 содержит все элементы L1 без повторений. 
% Например:
%     ?- uniq([a, b, a, c, d, d], Z).
%     Z = [a, b, c, d]

delete(_, [], []).
delete(H, [H|T], NewList) :-
    delete(H, T, NewList),
    !.
delete(X, [H|T], NewList) :-
    delete(X, T, Tmp),
    !,
    NewList = [H|Tmp].

uniq([], []).
uniq([H|T], Unique) :-
    delete(H, T, Cleared),
    !,
    uniq(Cleared, UT),
    Unique = [H|UT].
