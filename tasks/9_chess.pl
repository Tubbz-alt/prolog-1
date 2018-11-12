% Написать программу отыскания кратчайшего пути коня из позиции a1
% на стандартной шахматной доске в произвольную позицию.
% Пример:
%     ?- sol([6, 6], X).
%     X = [[0, 0], [1, 2], [2, 4], [4, 5], [6, 6]].

% Список возможных ходов конём
possibleMove(X, Y, NewX, NewY) :- NewX is X+1, NewY is Y+2.
possibleMove(X, Y, NewX, NewY) :- NewX is X+2, NewY is Y+1.
possibleMove(X, Y, NewX, NewY) :- NewX is X+2, NewY is Y-1.
possibleMove(X, Y, NewX, NewY) :- NewX is X+1, NewY is Y-2.
possibleMove(X, Y, NewX, NewY) :- NewX is X-1, NewY is Y-2.
possibleMove(X, Y, NewX, NewY) :- NewX is X-2, NewY is Y+1.
possibleMove(X, Y, NewX, NewY) :- NewX is X-2, NewY is Y-1.
possibleMove(X, Y, NewX, NewY) :- NewX is X-1, NewY is Y+2.

% Проверяет координаты на выход за границы доски
isValidX(Value) :- Value >= 0, Value =< 7.
isValidY(Value) :- Value >= 0, Value =< 7.

% Собирает вершину из координат
node(A, B, [A, B]).

% Делает ход конём из @1 в @2.
%     @1 Стартовая позиция
%     @2 Конечная позиция
move(From, To) :-
    node(X, Y, From),
    possibleMove(X, Y, NewX, NewY),
    isValidX(NewX),
    isValidY(NewY),
    node(NewX, NewY, To).

% Создает список ветвей от вершины @1 до каждой вершины из @2, результат в @3.
%     @1 Исходная вершина
%     @2 Список конечных вершин
%     @3 Результат - список ветвей
edges(_, [], []).
edges(X, [H|T], R) :-
    edges(X, T, Tmp),
    append([(X, H)], Tmp, R).

% Возвращает разность между списком @1 и @2 в список @3.
%     @1 Список из которого вычитают
%     @1 Вычитаемый список
%     @3 Результат
diff([], _, []).
diff([H|T], L2, L3) :-
    member(H, L2),
    !,
    diff(T, L2, L3).
diff([H|T], L2, [H|L3]) :-
    not(member(H, L2)),
    diff(T, L2, L3).

% Выполняет один шаг метода поиска в ширину.
%    @1 Список вершин в очереди
%    @3 Список пройденных вершин
%    @2 Список пройденных дуг
%    @1 Обновленный список вершин в очереди
%    @5 Обновленный список добавленных вершин
%    @6 Обновленный список пройденных дуг
iteration([], _, _, _, _, _) :-
    !,
    fail.
iteration([H|T], Nodes, Edges, UpdQueue, UpdNodes, UpdEdges) :-
    findall(X, move(H, X), AdjNodes),    % Ищем все смежные вершины

    diff(AdjNodes, Nodes, UpdNodes),     % Оставляем только непосещенные вершины
    append(T, UpdNodes, UpdQueue),       % Отправили непосещенные вершины в очередь

    edges(H, UpdNodes, TmpEdges),        % Построили пути до непосещенных вершин
    append(Edges, TmpEdges, UpdEdges),   % Добавили их в список пройденных путей
    !.

% Обходит граф в ширину до вершины @4.
%     @1 Список вершин в очереди
%     @2 Список пройденных вершин
%     @3 Список пройденных дуг
%     @4 Конечная вершина
%     @5 Обновленный список пройденных дуг
breadth([], _, _, _, _) :- !, fail.
breadth([H|_], _, Branches, H, Branches) :- !.
breadth(Queue, Nodes, Edges, End, UpdEdges) :-
    iteration(Queue, Nodes, Edges, UpdQueue, UpdNodes, TmpEdges),
    breadth(UpdQueue, UpdNodes, TmpEdges, End, UpdEdges).

% Ищет кратчайший путь @3 из вершины @1 в врешину @2.
%     @1 Стартовая вершина
%     @2 Конечная вершина
%     @3 Кратчайший путь
path(A, B, Path) :-
    breadth([A], [], [], B, Edges),
    path(A, B, Edges, Path).

% Восстанавливает путь @4 из вершины @1 в вершину @2.
%     @1 Стартовая вершина
%     @2 Конечная вершина
%     @3 Список пройденных дуг
%     @4 Найденный путь
path(A, B, Branches, [(A, B)]) :-
    member((A, B), Branches),
    !.
path(A, B, Branches, Path) :-
    member((X, B), Branches),
    !,
    path(A, X, Branches, TPath),
    append(TPath, [(X, B)], Path).

% Нормализует представление списка вершин @1 в @2.
normalize([], []).
normalize([(X, _)|T], Out) :-
    normalize(T, Tmp),
    append([X], Tmp, Out).

% Ищет путь @2 из вершины [0, 0] до @1.
sol(To, Path) :-
    path([0, 0], To, Nodes),
    normalize(Nodes, Tmp),
    append(Tmp, [To], Path).
sol(ToX, ToY, Path) :-
    sol([ToX, ToY], Path).

