# lê o csv dos jogadores e cospe o base.pl com os fatos em prolog
# normaliza os nomes (tira acento, deixa minusculo, troca espaco por _)
# e troca "Presente" por 2026 pros caras que ainda jogam

import pandas as pd
from unidecode import unidecode

ANO_ATUAL = 2026


def normalize(s: str) -> str:
    # vira um atomo valido do prolog
    return (
        unidecode(str(s))
        .lower()
        .strip()
        .replace(' ', '_')
        .replace('-', '_')
    )


def parse_ano(valor) -> int:
    # se tiver "Presente" joga pro ano atual, se nao converte pra int normal
    if isinstance(valor, str) and valor.strip().lower() == 'presente':
        return ANO_ATUAL
    return int(valor)


def main() -> None:
    df = pd.read_csv('data/jogadores_spfc.csv')

    with open('base.pl', 'w', encoding='utf-8') as f:
        # cabecalho do arquivo gerado (em prolog o comentario eh com %)
        f.write('% base de conhecimento gerada pelo etl.py, nao mexer aqui\n')
        f.write('% jogador(Nome, Posicao, Pais, AnoChegada, AnoSaida, Jogos, Gols, Titulos)\n\n')

        for _, r in df.iterrows():
            f.write(
                f"jogador({normalize(r['nome'])}, "
                f"{normalize(r['posicao'])}, "
                f"{normalize(r['pais'])}, "
                f"{parse_ano(r['ano_chegada'])}, "
                f"{parse_ano(r['ano_saida'])}, "
                f"{int(r['jogos'])}, "
                f"{int(r['gols'])}, "
                f"{int(r['titulos_conquistados'])}).\n"
            )

    print(f'base.pl gerada com {len(df)} jogadores.')


if __name__ == '__main__':
    main()
