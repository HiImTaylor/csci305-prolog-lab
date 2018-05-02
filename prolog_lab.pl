% Taylor Koth
% CSCI 305 Prolog Lab 2

%Rule used to define a mother of a child
mother(M, C) :-
  parent(M, C),
  female(F).

%Rule used to define a father of a child
father(F, C) :-
  parent(F, C),
  male(F).

%Rule used to define spouses
spouse(S1, S2) :-
  married(S1, S2);
  married(S2, S1).

%Rule used to define a child of a parent
child(C, P) :-
  parent(P, C).

%Rule used to define a son of a parent
son(S, P) :-
  child(S, P),
  male(S).

%Rule used to define a daughter of a parent
daughter(D, P) :-
  child(D, P),
  female(D).

%Rule used to define if two children are siblings
sibling(C1, C2) :-
  parent(S1, C1),
  parent(S2, C2),
  not(C1 = C2),
  (S1 = S2).

%Rule used to define brothers
brother(C1, C2) :-
  sibling(C1, C2),
  male(C1).

%Rule used to define sisters
sister(C1, C2) :-
  sibling(C1, C2),
  female(C1).

%Rule to define uncle by blood
uncle(U1, C1) :-
  parent(P1, C1),
  brother(U1, P1).

%Rule to define uncle by marriage.
uncle(U1, C1) :-
 parent(P1, C1),
 sibling(P1, C1),
 married(U1, S1),
 male(U1).

%Rule to define aunt by blood
aunt(A1, C1) :-
  parent(P1, C1),
  sister(A1, P1).

%Rule to define aunt by marriage.
aunt(A1, C1) :-
  parent(P1, C1),
  sibling(P1, C1),
  married(A1, S1),
  female(A1).

%Rule used to define grandparents
grandparent(G1, C1) :-
  parent(P1, C1),
  parent(G1, P1).

%Rule used to define grandfather
grandfather(G1, C1) :-
  grandparent(G1, C1),
  male(G1).

%Rule used to define grandmother
grandmother(G1, C1) :-
  grandparent(G1, C1),
  female(G1).

%Rule used to define grandchild
grandchild(C1, G1) :-
  grandparent(G1, C1).

%Rule for the ancestor base case
ancestor(X, Y) :-
  parent(X, Y).

%ancestor recursion rule
ancestor(A1, D1) :-
  parent(P1, D1),
  ancestor(A1, P1).

%Rule for the descendant base case
descendant(X, Y) :-
  child(X, Y).

%descendant recursion rule
descendant(D1, A1) :-
  child(C1, A1),
  descendant(D1, C1).

%Rules used to define older
%Both people are dead
older(X, Y) :-
 died(X, XDeathYear),
 died(Y, YDeathYear),
 born(X, XBirthYear),
 born(Y, YBirthYear),
 XAge is XDeathYear - XBirthYear,
 YAge is YDeathYear - YBirthYear,
 XAge > YAge.

%One Person is dead
older(X, Y) :-
 died(X, XDeathYear),
 born(X, XBirthYear),
 born(Y, YBirthYear),
 XAge is XDeathYear - XBirthYear,
 YAge is 2018 - YBirthYear,
 XAge > YAge.

%The other person is dead
older(X, Y) :-
 born(X, XBirthYear),
 died(Y, YDeathYear),
 born(Y, YBirthYear),
 XAge is 2018 - XBirthYear,
 YAge is YDeathYear - YBirthYear,
 XAge > YAge.

%neither people are dead
older(X, Y) :-
 born(X, XBirthYear),
 born(Y, YBirthYear),
 XAge is 2018 - XBirthYear,
 YAge is 2018 - YBirthYear,
 XAge > YAge.

%Rules used to define younger
%Both people are dead
younger(X, Y) :-
 died(X, XDeathYear),
 died(Y, YDeathYear),
 born(X, XBirthYear),
 born(Y, YBirthYear),
 XAge is XDeathYear - XBirthYear,
 YAge is YDeathYear - YBirthYear,
 XAge < YAge.

%One Person is dead
younger(X, Y) :-
 died(X, XDeathYear),
 born(X, XBirthYear),
 born(Y, YBirthYear),
 XAge is XDeathYear - XBirthYear,
 YAge is 2018 - YBirthYear,
 XAge < YAge.

%The other person is dead
younger(X, Y) :-
 born(X, XBirthYear),
 died(Y, YDeathYear),
 born(Y, YBirthYear),
 XAge is 2018 - XBirthYear,
 YAge is YDeathYear - YBirthYear,
 XAge < YAge.

%neither people are dead
younger(X, Y) :-
 born(X, XBirthYear),
 born(Y, YBirthYear),
 XAge is 2018 - XBirthYear,
 YAge is 2018 - YBirthYear,
 XAge < YAge.

%Rule used to define who was ruling at birth of a person
regentWhenBorn(X, Y) :-
  born(Y, YBirthYear),
  reigned(X, StartReign, EndReign),
  YBirthYear > StartReign,
  YBirthYear < EndReign.

%Extra Credit Rule to define a cousin
cousin(X, Y) :-
  parent(XParent, X),
  parent(YParent, Y),
  sibling(XParent, YParent).
