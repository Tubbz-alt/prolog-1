% Разработать правила, реализующие предикат ucat(L1, L2, L3).
% Предикат удовлетворен, если список L3 содержит все элементы списка L1 и те элементы из списка L2, которых нет в L1.
% Например:
%     ?- ucat([a, b, c], [d, c, e, a], Y).
%     Y = [a, b, c, d, e]

member(H, [H|_]) :- !.
member(X, [_|Tail]) :- member(X, Tail).

diff([], _, []).
diff([H|T], L2, L3) :-
    member(H, L2),
    !,
    diff(T, L2, L3).
diff([H|T], L2, [H|L3]) :-
    not(member(H, L2)),
    diff(T, L2, L3).

ucat(L1, L2, L3) :-
    diff(L2, L1, Tmp),
    append(L1, Tmp, L3).
