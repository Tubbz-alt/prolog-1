% Написать программу отыскания кратчайшего пути коня из позиции a1
% на стандартной шахматной доске в произвольную позицию.

min(X, Y, X) :- X =< Y.
min(X, Y, Y) :- Y =< X.

sublist([H|_], Len, H) :- length(H, Len).
sublist([_|T], Len, List) :- sublist(T, Len, List).

minlen([], 999).
minlen([H|T], Min) :-
    minlen(T, TMin),
    length(H, HMin),
    min(TMin, HMin, Min),
    !.

shortest(X, Shortest) :-
    minlen(X, Len),
    sublist(X, Len, Shortest).

member(X, [Head|_]) :- X = Head, !.
member(X, [_|Tail]) :- member(X, Tail).

possibleMove(X, Y, NewX, NewY) :- NewX is X+1, NewY is Y+2.
possibleMove(X, Y, NewX, NewY) :- NewX is X+2, NewY is Y+1.
possibleMove(X, Y, NewX, NewY) :- NewX is X+2, NewY is Y-1.
possibleMove(X, Y, NewX, NewY) :- NewX is X+1, NewY is Y-2.
possibleMove(X, Y, NewX, NewY) :- NewX is X-1, NewY is Y-2.
possibleMove(X, Y, NewX, NewY) :- NewX is X-2, NewY is Y+1.
possibleMove(X, Y, NewX, NewY) :- NewX is X-2, NewY is Y-1.
possibleMove(X, Y, NewX, NewY) :- NewX is X-1, NewY is Y+2.

isValidX(Value) :- Value >= 0, Value =< 7.
isValidY(Value) :- Value >= 0, Value =< 7.

point(X, Y, [X, Y]) :- !.

move(From, To) :-
    point(X, Y, From),
    possibleMove(X, Y, NewX, NewY),
    isValidX(NewX),
    isValidY(NewY),
    point(NewX, NewY, To).

path(From, To, PrevPath, Path) :-
    move(From, To),
    append(PrevPath, [To], Path),
    !.
path(From, To, PrevPath, Path) :-
    move(From, Tmp),
    not(member(Tmp, PrevPath)),
    append(PrevPath, [Tmp], TmpPath),
    !,
    path(Tmp, To, TmpPath, Path).

way(To, Way) :- path([0, 0], To, [], Way).

shortestway(To) :-
    findall(Way, way(To, Way), Ways),
    shortest(Ways, Shortest),
    print(Shortest).
