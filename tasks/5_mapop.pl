% Разработать правила, реализующие предикат mapop(Op, L1, L2, L3).
% Предикат удовлетворен, если i-ый элемент списка L3 представляет собой результат применения инфиксной операции Op к i-ым элементам списков L1 и L2.
% Например:
%     ?- mapop(+, [1, 2, 3], [4, 5, 6], R).
%     R = [5, 7, 9]

compute(Op, X, Y, Result) :- Eq=..[Op, X, Y], Result is Eq.

mapop(_, [], [], []) :- !.
mapop(Op, [H1|T1], [H2|T2], Result) :- compute(Op, H1, H2, HResult), mapop(Op, T1, T2, TResult), Result = [HResult|TResult].