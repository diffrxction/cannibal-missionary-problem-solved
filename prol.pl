proj :-
    initial(I),
    writeln("M C Moves M C"),
    bfs([[I]], Side),
    maplist(writeln, Side).

% Writing rules for number of missionaries and cannibals. At no instance can the number of cannibals exceed the number of missionaries.

safe_state(M, C) :-

% Actual rules    
%    M = 2, C = 0 ;
%    M = 1, C = 0 ;
%    M = 1, C = 1 ;
%    M = 0, C = 2 ;
%    M = 0, C = 1 .

% On reversing the order of rules, we get
    M = 0, C = 2 ;
    M = 0, C = 1 ;
    M = 2, C = 0 ;
    M = 1, C = 1 ;   
    M = 1, C = 0 .

% Using a breath-first search (BFS) algorithm
bfs(Sides, Side) :-
    bfs1(Sides, Extra),
    (   member(Right, Extra),
        Right = [H|_],
        final(H),
        reverse(Right, Side)
    ;   bfs(Extra, Side)).

bfs1(Sides, Extra) :-
    findall([Q,H|R], (   member([H|R], Sides), move(H, Q), \+ member(Q, R)), Extra), Extra \= [].

% Initializing the starting condition of the problem as mentioned
initial((3,3, east , 0,0)).

% Initializing the goal condition of the problem as needed
final((0,0, west , 3,3)).

% The values of F1 and F2 will be changed according to the direction of movement
direction(east, -1, +1, west).
direction(west, +1, -1, east).

% Now, applying valid moves only. Possible values of MM and CM will come from safe_state()
move((M1i,C1i, Bi, M2i,C2i), (M1j, C1j, Bj, M2j, C2j)) :-

    direction(Bi, F1, F2, Bj),
    safe_state(MM, CM),
    
    M1j is M1i + MM * F1, M1j >= 0,
    C1j is C1i + CM * F1, C1j >= 0,
    ( M1j >= C1j ; M1j == 0 ),
    
    M2j is M2i + MM * F2, M2j >= 0,
    C2j is C2i + CM * F2, C2j >= 0,
    ( M2j >= C2j ; M2j == 0 ).