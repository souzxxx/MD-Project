# Exemplos de Queries — SPFC História

Cada seção traz a pergunta em português, a query Prolog correspondente e o resultado esperado ao rodar no SWISH.

---

### Pergunta 1 — Top 10 artilheiros da história do SPFC

**Pergunta:** Quem são os 10 jogadores que mais marcaram gols pelo São Paulo?

**Query:**
```prolog
?- top_artilheiros(Top).
```

**Resultado:**
```
Top = [
    242-serginho_chulapa,
    233-gino_orlando,
    212-luis_fabiano,
    188-teixeirinha,
    182-franca,
    160-muller,
    144-leonidas_da_silva,
    136-maurinho,
    131-rogerio_ceni,
    128-rai
].
```

**Como funciona:** `setof` coleta todos os pares `Gols-Nome`, `reverse` ordena do maior para o menor, e `pegar_primeiros(10, ...)` trunca a lista.

---

### Pergunta 2 — Ranking de posições por gols marcados

**Pergunta:** Qual posição mais contribuiu com gols na história do clube?

**Query:**
```prolog
?- ranking_posicoes(R).
```

**Resultado:**
```
R = [
    2272-atacante,
    786-meia,
    186-zagueiro,
    131-goleiro,
    112-lateral
].
```

**Observação:** Rogério Ceni sozinho responde por 100% dos gols de goleiros.

**Como funciona:** Para cada posição distinta (via `todas_posicoes`), `findall` + `sum_list` soma todos os gols. O resultado é ordenado com `sort` + `reverse`.

---

### Pergunta 3 — Top 5 jogadores mais eficientes (gols/jogo)

**Pergunta:** Considerando apenas quem jogou pelo menos 100 partidas, quem tem a melhor média de gols por jogo?

**Query:**
```prolog
?- top_eficiencia(Top).
```

**Resultado:**
```
Top = [
    0.6825-leonidas_da_silva,   % 144 gols em 211 jogos
    0.6065-serginho_chulapa,    % 242 em 399
    0.6023-luis_fabiano,        % 212 em 352
    0.6021-careca,              % 115 em 191
    0.5566-franca               % 182 em 327
].
```

**Como funciona:** O predicado auxiliar `eficiencia/2` calcula `Gols / Jogos` com filtro `J >= 100`. `setof` ordena automaticamente pela razão, depois invertemos e pegamos os 5 primeiros.

---

### Pergunta 4 (bônus) — Ídolos por década de chegada

**Pergunta:** Quantos ídolos (≥ 200 jogos e ≥ 3 títulos) cada década revelou?

**Query:**
```prolog
?- contagem_idolos_por_decada(R).
```

**Resultado:**
```
R = [
    7-1980,    % Cafu, Zé Teodoro, Ronaldão, Raí, Pita, Müller, Gilmar Rinaldi
    5-1990,    % Rogério Ceni, Zetti, Marcelo Bordon, Palhinha, França
    5-1970,    % Valdir Peres, Pablo Forlán, Nelsinho, Darío Pereyra, Serginho Chulapa
    5-1940,    % Bauer, Rui, Noronha, Mauro Ramos, Leônidas
    4-2000,    % Diego Lugano, Miranda, Hernanes, Richarlyson
    1-1960,    % Roberto Dias
    1-1950,    % Jose Poy
    1-1930     % Teixeirinha
].
```

**Insight:** A década de 80, dos três títulos paulistas e da primeira Libertadores (1992), foi a mais fértil em ídolos.

**Como funciona:** Composição de `idolo/1` + `decada_chegada/2` para agrupar, depois `length` conta os nomes por década e o resultado é ranqueado.
