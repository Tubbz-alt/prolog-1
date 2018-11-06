% Разработать правила, реализующие предикат path(From, To, Path) поиска пути в лабиринте
% из комнаты From в комнату To (Path - список комнат, составляющих путь).
% Конфигурация лабиринта описывается базой фактов.

w(0, 0).  w(1, 0).
          w(1, 1).  w(2, 1).
                    w(2, 2).  w(3, 2).
                              w(3, 3).
w(0, 4).  w(1, 4).            w(3, 4).
          w(1, 5).  w(2, 5).  w(3, 5).
          w(1, 6).
w(0, 7).  w(1, 7). 


member(X, [Head|_]) :- X = Head, !.
member(X, [_|Tail]) :- member(X, Tail).

connected(X0, Y0, X0, Y) :- Y is Y0 + 1.
connected(X0, Y0, X0, Y) :- Y is Y0 - 1.
connected(X0, Y0, X, Y0) :- X is X0 + 1.
connected(X0, Y0, X, Y0) :- X is X0 - 1.

distance(X0, Y0, X, Y) :- connected(X0, Y0, X, Y), w(X, Y).

findPath(X, Y, X, Y, Path, Path).
findPath(X0, Y0, X, Y, PrevPath, Path) :-
    distance(X0, Y0, X1, Y1), 
    not(member(w(X1, Y1), PrevPath)),
    UpdPath = [w(X1, Y1)|PrevPath],
    findPath(X1, Y1, X, Y, UpdPath, Path).

path(X0, Y0, X1, Y1, Path) :- findPath(X0, Y0, X1, Y1, [], Path).
