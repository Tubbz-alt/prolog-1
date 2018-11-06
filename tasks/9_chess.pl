% Написать программу отыскания кратчайшего пути коня из позиции a1
% на стандартной шахматной доске в произвольную позицию.

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

move(X, Y, NewX, NewY) :-
    possibleMove(X, Y, NewX, NewY),
    isValidX(NewX),
    isValidY(NewY).

path(X, Y, ToX, ToY, Path) :-
    move(X, Y, TmpX, TmpY),
    TmpX = ToX,
    TmpY = ToY,
    Path = [[X, Y], [ToX, ToY]],
    !.

path(X, Y, ToX, ToY, Path) :-
    move(X, Y, TmpX, TmpY),
    From = [X, Y],
    path(TmpX, TmpY, ToX, ToY, Path2),
    append([From], Path2, Path).
