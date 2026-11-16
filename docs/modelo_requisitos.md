# EquiData — Levantamento e Análise de Requisitos

**Universidade Federal de Santa Catarina — Departamento de Ciência da Informação**  
**Disciplina:** CIN 8003 — Bancos de Dados e Aplicações  
**Professor:** Moisés Lima Dutra  
**Projeto:** EquiData — Sistema de Gestão e Monitoramento de Atividades Equestres  
**Versão:** 1.0 — 16 de novembro de 2026

## 1. Descrição do domínio

O EquiData é um sistema de informação destinado a apoiar a gestão de uma hípica, centralizando dados relativos a cavalos, proprietários, cavaleiros, funcionários, instrutores, aulas, treinos, modalidades, competições, baias, alimentação, atendimentos veterinários, medicamentos, equipamentos e pagamentos.

O cenário envolve atividades administrativas e operacionais que exigem o registro organizado de informações e a manutenção de histórico. O sistema deve permitir acompanhar a rotina dos cavalos, registrar aulas e treinamentos, controlar a ocupação das baias, documentar alimentação e cuidados veterinários, além de registrar participações em competições e pagamentos.

O projeto também considera a possibilidade de evolução futura para monitoramento de atividades equestres com métricas como distância, duração e velocidade. Nesta versão acadêmica, essas métricas são armazenadas quando disponíveis, sem integração obrigatória com GPS ou dispositivos externos.

## 2. Objetivo geral

Projetar e implementar um banco de dados relacional para organizar e integrar as principais informações administrativas e operacionais de uma hípica, oferecendo consistência, rastreabilidade e recuperação estruturada dos dados.

## 3. Objetivos específicos

- Manter cadastro centralizado de pessoas e seus diferentes papéis.
- Registrar cavalos e seus respectivos proprietários.
- Gerenciar aulas, instrutores, modalidades e participação de cavaleiros.
- Registrar treinos e métricas de desempenho quando disponíveis.
- Controlar baias e histórico de ocupação.
- Manter histórico de alimentação e atendimentos veterinários.
- Registrar medicamentos e prescrições vinculadas aos atendimentos.
- Controlar equipamentos e seu uso pelos cavalos.
- Registrar competições e resultados de participações.
- Registrar pagamentos associados às pessoas responsáveis.

## 4. Stakeholders

1. **Proprietário da hípica:** acompanha a operação e consulta informações administrativas e financeiras.
2. **Administrador/Gerente:** gerencia cadastros, aulas, baias, pagamentos e relatórios.
3. **Instrutor:** consulta aulas, cavaleiros e cavalos e registra informações relacionadas às atividades de ensino.
4. **Cavaleiro/Aluno:** participa de aulas, treinos e competições.
5. **Veterinário:** registra atendimentos, procedimentos, diagnósticos e prescrições.
6. **Tratador:** consulta informações operacionais dos cavalos, como alimentação e alocação em baias.
7. **Proprietário do cavalo:** acompanha os dados e o histórico do animal sob sua responsabilidade.

## 5. Requisitos funcionais

- **RF01:** O sistema deve permitir cadastrar, consultar, atualizar e inativar pessoas.
- **RF02:** O sistema deve permitir associar papéis de cavaleiro, funcionário e veterinário a pessoas cadastradas.
- **RF03:** O sistema deve permitir cadastrar e consultar cavalos e seus proprietários.
- **RF04:** O sistema deve permitir cadastrar modalidades e suas descrições.
- **RF05:** O sistema deve permitir cadastrar instrutores vinculados aos funcionários.
- **RF06:** O sistema deve permitir registrar aulas com data, duração, cavalo, instrutor e modalidade.
- **RF07:** O sistema deve permitir associar um ou mais cavaleiros a uma aula e registrar presença.
- **RF08:** O sistema deve permitir registrar treinos vinculados a cavalos e, opcionalmente, a um cavaleiro responsável.
- **RF09:** O sistema deve permitir registrar duração, distância e velocidade média dos treinos, quando disponíveis.
- **RF10:** O sistema deve permitir cadastrar baias e registrar períodos de ocupação.
- **RF11:** O sistema deve permitir consultar o histórico de ocupação de cada baia e de cada cavalo.
- **RF12:** O sistema deve permitir registrar planos e históricos de alimentação dos cavalos.
- **RF13:** O sistema deve permitir registrar atendimentos veterinários, procedimentos e diagnósticos.
- **RF14:** O sistema deve permitir cadastrar medicamentos e associá-los às prescrições de atendimentos.
- **RF15:** O sistema deve permitir cadastrar equipamentos e registrar seu uso pelos cavalos.
- **RF16:** O sistema deve permitir cadastrar competições e registrar participações de cavaleiros e cavalos.
- **RF17:** O sistema deve permitir registrar colocação, pontuação e resultado de cada participação.
- **RF18:** O sistema deve permitir registrar pagamentos, valores, datas, status e descrição.
- **RF19:** O sistema deve permitir consultar históricos por cavalo, pessoa, aula, treino, competição e atendimento.
- **RF20:** O sistema deve permitir consultar informações para acompanhamento administrativo e operacional.

## 6. Requisitos não funcionais

- **RNF01 — Integridade:** o banco deve aplicar chaves primárias, estrangeiras e restrições de domínio.
- **RNF02 — Consistência:** operações devem respeitar as regras de negócio e evitar referências inválidas.
- **RNF03 — Persistência:** os dados devem permanecer armazenados no banco SQLite.
- **RNF04 — Portabilidade:** a solução deve utilizar tecnologias acessíveis e reproduzíveis, especialmente SQLite e SQL.
- **RNF05 — Manutenibilidade:** tabelas e scripts devem ser organizados e documentados.
- **RNF06 — Rastreabilidade:** informações históricas relevantes devem ser preservadas em registros próprios, evitando sobrescrever eventos anteriores.

## 7. Regras de negócio

As regras abaixo consolidam o cenário validado e as decisões de modelagem adotadas para sua implementação:

- **RN01:** Cada cavalo deve possuir um cadastro único no sistema.
- **RN02:** Um cavalo pode ocupar somente uma baia por vez.
- **RN03:** Uma baia pode abrigar somente um cavalo por vez.
- **RN04:** Todo cavalo deve possuir um proprietário cadastrado.
- **RN05:** Toda aula deve estar associada a pelo menos um cavaleiro e a um instrutor.
- **RN06:** Toda aula deve estar associada a uma modalidade equestre.
- **RN07:** Um instrutor pode ministrar várias aulas.
- **RN08:** Um cavaleiro pode participar de várias aulas.
- **RN09:** Todo treino deve estar associado a um cavalo.
- **RN10:** Um treino pode possuir um cavaleiro responsável.
- **RN11:** Todo treino deve possuir data e duração.
- **RN12:** Um cavalo pode possuir vários registros de treino.
- **RN13:** Um treino pode registrar métricas de desempenho, como distância e duração.
- **RN14:** Um cavalo pode possuir vários atendimentos veterinários.
- **RN15:** Todo atendimento veterinário deve possuir data e descrição do procedimento.
- **RN16:** Um atendimento veterinário pode gerar uma ou mais prescrições de medicamentos.
- **RN17:** Toda competição deve possuir data e local.
- **RN18:** Um cavaleiro pode participar de várias competições.
- **RN19:** Um cavalo pode participar de várias competições.
- **RN20:** Cada registro de participação deve relacionar uma competição, um cavaleiro e um cavalo.

## 8. Escopo

### Incluído nesta versão
Cadastro e relacionamento de pessoas, cavalos, papéis, aulas, treinos, modalidades, competições, baias, alimentação, atendimentos veterinários, medicamentos, equipamentos e pagamentos. Também estão incluídos histórico de ocupação e registros de participação.

### Fora do escopo desta versão
- Aplicativo móvel para usuários finais.
- Integração com dispositivos GPS ou sensores.
- Diagnóstico veterinário automatizado.
- Integração com sistemas financeiros externos.
- Controle de estoque avançado de medicamentos e rações.
- Autenticação, autorização por perfil e implantação em servidor de produção.

## 9. Premissas e decisões de modelagem

- Pessoa é a entidade central de identificação. Uma mesma pessoa pode exercer mais de um papel sem duplicação de cadastro.
- Instrutores são funcionários da hípica.
- Cada cavalo possui exatamente um proprietário cadastrado.
- Cada aula utiliza exatamente um cavalo e um instrutor; uma aula pode envolver vários cavaleiros.
- A participação de cavaleiros em aulas é representada por entidade associativa.
- Aulas e treinos são registros independentes.
- Os históricos de alimentação, ocupação de baias, atendimentos e uso de equipamentos são mantidos em registros próprios.
- Medicamentos são cadastrados separadamente; dosagem, frequência e período pertencem à prescrição específica.
- Dados inseridos para demonstração e teste são fictícios.

## 10. Limitações conhecidas

O banco relacional assegura diretamente a maior parte das restrições por meio de PK, FK, UNIQUE, CHECK, índices e gatilhos. A regra de que uma aula deve possuir pelo menos um cavaleiro associado depende também do fluxo transacional da aplicação, pois uma restrição CHECK convencional não valida a existência de registros em outra tabela após a inserção da aula.
