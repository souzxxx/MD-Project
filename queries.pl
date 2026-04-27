% perguntas do projeto
% cada uma é uma regra nomeada que pode ser chamada direto no SWISH

% Pergunta 1:
% Quem sao os 10 maiores artilheiros da historia do SPFC?
% Sofisticacao: setof + ordenacao decrescente + truncamento
top_artilheiros(Top10) :-
    setof(G-N,
          P^Pa^Ac^As^J^T^jogador(N, P, Pa, Ac, As, J, G, T),
          Lista),
    reverse(Lista, ListaOrd),
    pegar_primeiros(10, ListaOrd, Top10).


% Pergunta 2:
% Qual posicao mais contribuiu em gols na historia do clube?
% Sofisticacao: agrupamento por chave + sum_list + ranking
gols_por_posicao(Pos, Total) :-
    findall(G, jogador(_, Pos, _, _, _, _, G, _), Lista),
    sum_list(Lista, Total).

ranking_posicoes(Ranking) :-
    todas_posicoes(Posicoes),
    findall(Total-Pos,
            ( member(Pos, Posicoes),
              gols_por_posicao(Pos, Total)
            ),
            Lista),
    sort(Lista, Asc),
    reverse(Asc, Ranking).


% Pergunta 3:
% Top 5 jogadores mais eficientes em gols/jogo
% (filtro: pelo menos 100 jogos pelo clube)
% Sofisticacao: composicao de regras + aritmetica + filtro
eficiencia(Nome, Ratio) :-
    jogador(Nome, _, _, _, _, J, G, _),
    J >= 100,
    G > 0,
    Ratio is G / J.

top_eficiencia(Top5) :-
    setof(R-N, eficiencia(N, R), Lista),
    reverse(Lista, ListaOrd),
    pegar_primeiros(5, ListaOrd, Top5).


% Pergunta 4 (bonus):
% Quantos idolos (>=200 jogos e >=3 titulos) cada decada revelou?
% Sofisticacao: composicao pesada + agregacao temporal + ranking
idolos_da_decada(Decada, Nomes) :-
    findall(N,
            ( idolo(N),
              decada_chegada(N, Decada)
            ),
            Nomes).

contagem_idolos_por_decada(Ranking) :-
    setof(D,
          N^( idolo(N), decada_chegada(N, D) ),
          Decadas),
    findall(Qtd-Dec,
            ( member(Dec, Decadas),
              idolos_da_decada(Dec, L),
              length(L, Qtd)
            ),
            Lista),
    sort(Lista, Asc),
    reverse(Asc, Ranking).
