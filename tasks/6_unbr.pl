% Разработать правила, реализующие предикат unbr(L1, L2).
% Предикат удовлетворен, если L1 есть многоуровневый список произвольных элементов, а L2 - одноуровневый список тех же элементов. 
% Например:
%     ?- unbr([[], [a, [1, [2, d], []], 56], [[[[v], b]]]], Q).
%     Q = [a, 1, 2, d, 56, v, b]

unbr([], []) :- !.
unbr(X, R) :- atomic(X), R = [X], !.
unbr([Head|Tail], Result) :- unbr(Head, HResult), unbr(Tail, TResult), append(HResult, TResult, Result).
