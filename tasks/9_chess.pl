% Написать программу отыскания кратчайшего пути коня из позиции a1
% на стандартной шахматной доске в произвольную позицию.

possibleMove(X, Y, NewX, NewY) :- NewX is I+1, NewY is Y+2.
possibleMove(X, Y, NewX, NewY) :- NewX is I+2, NewY is Y+1.
possibleMove(X, Y, NewX, NewY) :- NewX is I+2, NewY is Y-1.
possibleMove(X, Y, NewX, NewY) :- NewX is I+1, NewY is Y-2.
possibleMove(X, Y, NewX, NewY) :- NewX is I-1, NewY is Y-2.
possibleMove(X, Y, NewX, NewY) :- NewX is I-2, NewY is Y+1.
possibleMove(X, Y, NewX, NewY) :- NewX is I-2, NewY is Y-1.
possibleMove(X, Y, NewX, NewY) :- NewX is I-1, NewY is Y+2.
