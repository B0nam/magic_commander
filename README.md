`[Observação] observação para facilitar a correção foi criado um usuario padrão admin@admin com a senha admin123@`
`[Observação] toda a logica para a geração de cartas está definida dentro do arquivo /magic_commander/lib/magic_commander/api_client.ex`

# Magic Commander

Atividade avaliativa para a disciplina de Desafio Profissional VI do 6º semestre do curso de graduação de Engenharia de Software da Unicesumar.

Desenvolvido por **Daniel Bonam Rissardi (22013838-2)**


Todo o projeto foi desenvolvido em Elixir com o framework Phoenix

![image](https://github.com/user-attachments/assets/fed658ed-5ecf-4992-a3d3-14b8b56b8263)

## Sumário

- Visão geral
- Tecnologias utilizadas
- Funcionalidades
- Diagrama de classes
- Testes
- Build
- Escopo do projeto

## Visão Geral

Magic Commander é uma aplicação rest api para gerar decks do jogo de cartas magic. Os decks gerados são destinados ao modo de jogo Commander, onde há uma carta central e as cartas auxiliares que seguem o padrão da carta central.

`[Observação] Caso o jogador não tenha completado a MD10 da season, não é posivel mostrar as informações de Vitória, Derrota, KD e Rank.`

## Tecnologias utilizadas

- [Elixir](https://elixir-lang.org/)
- [Phoenix](https://www.phoenixframework.org/)
- [Postgresql](https://www.postgresql.org/)
- [Docker](https://www.docker.com/)

## Funcionalidades
`[Observação] O fluxo para a criação de um novo deck é o seguinte: criar conta -> logar a conta criada -> criar deck fornecendo nome e nome do commander -> exportar o deck populado pelo id. (/accounts/register -> /accounts/signin -> /api/decks -> /decks/:id/export`

Abaixo as funcionalidades desenvolvidas.

- Autenticação/Autorização
    - O sistema conta com uma autenticação, onde para realizar ações relevantes na aplicação é necessário que o usuário esteja tenha criado uma conta válida e esteja logado ao sistema.
    - Possui uma autorização baseada em roles (Admin, Moderador, Usuario)
- Cartas
    - O sistema permite a busca de cartas por nomes, alem de informar se ela é ou não elegivel a commander
- Decks
    - O sistema permite a criação de decks, onde você define o nome do deck e o commander responsável
    - O sistema permite popular o deck, ao chamar /populate o deck é preenchido com 99 cartas
    - O sistema permite a importação/exportação de decks no formato .json
    - O sistema gera arquivos .json contendo o deck na pasta public/deck_exports/

## Diagrama de classes
Aqui esta o diagrama de classes da aplicação:

![DiagramaDeClasses_2024-09-06T13_39_33 052Z](https://github.com/user-attachments/assets/121fb175-df54-4d99-afcb-7ef70da609c9)


## Testes
Os testes unitários foram desenvolvidos para a classe que possui a regra de negocio principal api_client e para os endpoints e controllers. Para executar os testes, basta executar `mix test`

![image](https://github.com/user-attachments/assets/4b63c18a-0a66-45e1-b603-b79de2647daf)

## Build
Para subir o projeto basta executar o seguinte comando dentro da pasta do repositório: `docker-compose up --build`, desta forma a aplicação pode ser acessada por `http://localhost:4000`

## Rotas
Todas as rotas do sistema podem ser encontradas em `/magic_commander/lib/magic_commander_web/router.ex`. Todas as rotas principais estão definidas dentro de /api ou seja, para buscar uma carta, utilize /api/cards/find/:name 

![image](https://github.com/user-attachments/assets/3f01c77d-9e1b-4f04-a796-6b2216e87c01)

A autenticação e a autoriazão estão definidas dentro de pipe_through

## Escopo do projeto - Solicitação do professor.
## Avaliação - Requisitos
Magic the Gathering é um jogo de cartas competitivo e colecionável publicado pela empresa Wizards of the Coast.
MTG tem diversos formatos de jogo, commander, pauper, standard, entre outros.
Cada modo de jogo tem suas próprias regras, que irão ditar mecanicas, quantidade de cartas, cards permitidos entre outras caracteristicas.
Um dos modos mais jogados no mundo todo é o Commander, também conhecido como Elder Dragon Highlander (EDH).
As características desse modo de jogo, é que seu baralho será composto de 99 cartas + 1 card de comandante. Porém não pode haver repetição de cartas, somente terremos básicos podem ser repetidos (basic lands) ou cartas que tenham explicitamente em seu texto uma indicação de que podem ter mais de uma cópia, sendo essa uma exceção rara.
Um comandante é uma criatura Lendária, e isso está indicado no card desta criatura.

Outra regra importante a ser seguinda é que em seu baralho só podem existir cards que tenham a cor de seu comandante, por exemplo:
Se o sua comandante é a carta Gisa, ressuscitadora gloriosa, somente cartas de cor preta podem estar em seu baralho.
Se sua comandante for Dina Imbuidora de Almas, seu baralho poderá ter cartas pretas e verdes.

`[FEITO] As regras de negócio foram levadas em consideração durante o desenvolvimento do projeto.`

1 - Tendo essas informações como base, você deve ler a documentação fornecida, e buscar por 99 cards nessa base de dados para formar o seu baralho.
Procure primeiro por um comandante, pois ele irá ditar quais cores suas outras 99 cartas poderão ter.
Escolhendo o comandante, utilize as informações na doc para buscar outras 99 cartas na base de dados correspondente as cores permitidas, lembrando que você pode repetir somente os terrenos básicos.

`[FEITO] O sistema funciona conforme o solicitado, usuários podem criar decks baseados no nome do commander e suas caracteristicas`

2- Após consumir a API e buscar esses dados, salve eles em um arquivo.json.

`[FEITO] O sistema funciona conforme o solicitado, usuários podem criar decks baseados no nome do commander e suas caracteristicas`

3 - Crie uma rota em sua API para trazer os 100 cards de seu baralho

`[FEITO] Quando visualizado os detalhes de um baralho, todas as 100 cartas são exibidas`

4 - Salve seu deck no banco de dados de sua escolha

`[FEITO] As entidades do sistema são salvas no banco de dados Postgres`

5 - Criar o sistema de Autenticação para sua API (Só usuários autenticados podem criar e editar seus baralhos)

`[FEITO] O sistema possui um sistema de Autenticação`

6 - Criar o sistema de Autorização

`[FEITO] O sistema possui um sistema de Autorização baseado em cargos`

7 - Crie os testes automatizados para validar as regras de negócio e o funcionamento de seus endpoints, você pode utilizar mocks para isso.

`[FEITO] Foram criados testes automatizados`

DOC do Scryfall: https://scryfall.com/docs/api

Link para a documentação: https://docs.magicthegathering.io/#documentationrate_limits

É permitido que você utilize outras APIs de cartas de magic como o Scryfall para realizar sua atividade, contanto que indique isso.
Você pode realizar a atividade em qualquer linguagem de programação.

CRUD do usuário no banco

`[FEITO] Foi realizado o crud de usuarios`

Criptografia da senha

`[FEITO] Foi realizado a criptografia da senha com hashing`

Diagrama de Classe da aplicação

`[FEITO] Diagrama de classes mostrado anteriormente`

# MagicCommander

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
