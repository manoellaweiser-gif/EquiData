# EquiData

Sistema de Gestão e Monitoramento de Atividades Equestres.

Projeto acadêmico da disciplina CIN 8003 — Bancos de Dados e Aplicações, Universidade Federal de Santa Catarina (UFSC).

## Objetivo
Modelar e implementar um banco de dados relacional para apoiar a gestão de uma hípica, abrangendo cavalos, pessoas, aulas, treinos, baias, alimentação, atendimentos veterinários, competições, equipamentos e pagamentos.

## Estrutura
- `docs/`: requisitos e esquema relacional.
- `diagrams/`: modelo entidade-relacionamento em Mermaid.
- `sql/`: scripts de criação e população do banco.
- `database/`: banco SQLite de demonstração.

## Como executar
Com Python 3 instalado, na raiz do projeto:

```bash
python3 -c "import sqlite3; c=sqlite3.connect('database/equidata.db'); c.executescript(open('sql/script_ddl.sql', encoding='utf-8').read()); c.executescript(open('sql/script_dml.sql', encoding='utf-8').read()); c.commit(); c.close()"
```

Ou utilize o SQLite CLI:

```bash
sqlite3 database/equidata.db < sql/script_ddl.sql
sqlite3 database/equidata.db < sql/script_dml.sql
```

## Documentação
- [Modelo de requisitos](docs/modelo_requisitos.md)
- [Esquema relacional](docs/esquema_relacional.md)
- [Diagrama MER](diagrams/MER.md)

## Dados de demonstração
Os registros inseridos em `script_dml.sql` são fictícios e servem exclusivamente para validar o funcionamento do banco.

## Tecnologias
- SQLite
- SQL (DDL e DML)
- Mermaid para documentação do MER

## Observação
Projeto acadêmico. Não utilizar os dados fictícios como registros reais de uma hípica.
