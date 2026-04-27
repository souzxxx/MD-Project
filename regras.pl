% predicados auxiliares que eu reaproveito nas perguntas que terao no queries.pl

% filtros por posicao, so pra facilitar consulta
goleiro(Nome)  :- jogador(Nome, goleiro,  _, _, _, _, _, _).
zagueiro(Nome) :- jogador(Nome, zagueiro, _, _, _, _, _, _).
lateral(Nome)  :- jogador(Nome, lateral,  _, _, _, _, _, _).
meia(Nome)     :- jogador(Nome, meia,     _, _, _, _, _, _).
atacante(Nome) :- jogador(Nome, atacante, _, _, _, _, _, _).

% pega a decada em que o cara chegou no clube (1940, 1990, 2000...)
decada_chegada(Nome, Dec) :-
    jogador(Nome, _, _, Ano, _, _, _, _),
    Dec is (Ano // 10) * 10.

% quantos anos o jogador ficou no clube
tempo_clube(Nome, Anos) :-
    jogador(Nome, _, _, Chegada, Saida, _, _, _),
    Anos is Saida - Chegada.

% media de gols por jogo (so faz sentido se jogou pelo menos uma vez)
media_gols(Nome, Media) :-
    jogador(Nome, _, _, _, _, J, G, _),
    J > 0,
    Media is G / J.

% jogador estrangeiro, qualquer pais que nao seja brasil
estrangeiro(Nome) :-
    jogador(Nome, _, Pais, _, _, _, _, _),
    Pais \= brasil.

% meu criterio de idolo: pelo menos 200 jogos e 3 titulos
idolo(Nome) :-
    jogador(Nome, _, _, _, _, J, _, T),
    J >= 200,
    T >= 3.

% lista todas as posicoes que aparecem na base, sem repetir
todas_posicoes(Posicoes) :-
    setof(P,
          N^Pa^Ac^As^J^G^T^jogador(N, P, Pa, Ac, As, J, G, T),
          Posicoes).

% utilitario: pega os N primeiros elementos de uma lista
pegar_primeiros(0, _, []) :- !.
pegar_primeiros(_, [], []) :- !.
pegar_primeiros(N, [X|Xs], [X|Ys]) :-
    N > 0,
    N1 is N - 1,
    pegar_primeiros(N1, Xs, Ys).
