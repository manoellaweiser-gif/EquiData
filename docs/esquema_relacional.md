# Esquema Relacional — EquiData

Convenções: PK = chave primária; FK = chave estrangeira; UK = restrição de unicidade.

- PESSOA(**id_pessoa**, nome, cpf UK, data_nascimento, telefone, email UK)
- FUNCIONARIO(**id_funcionario**, id_pessoa FK UK → PESSOA, cargo, data_admissao, ativo)
- INSTRUTOR(**id_instrutor**, id_funcionario FK UK → FUNCIONARIO, especialidade, qualificacao)
- VETERINARIO(**id_veterinario**, id_pessoa FK UK → PESSOA, registro_profissional UK, telefone_emergencia)
- CAVALEIRO(**id_cavaleiro**, id_pessoa FK UK → PESSOA, nivel_experiencia, data_inicio)
- CAVALO(**id_cavalo**, nome, raca, sexo, data_nascimento, pelagem, microchip UK, id_proprietario FK → PESSOA, ativo)
- MODALIDADE(**id_modalidade**, nome UK, descricao)
- AULA(**id_aula**, data_hora, duracao_minutos, id_cavalo FK → CAVALO, id_instrutor FK → INSTRUTOR, id_modalidade FK → MODALIDADE, observacoes)
- PARTICIPACAO_AULA(**id_aula** FK → AULA, **id_cavaleiro** FK → CAVALEIRO, presenca, observacao); PK composta (id_aula, id_cavaleiro)
- TREINO(**id_treino**, id_cavalo FK → CAVALO, id_cavaleiro_responsavel FK → CAVALEIRO NULL, id_modalidade FK → MODALIDADE NULL, data_hora, duracao_minutos, distancia_km, velocidade_media_kmh, observacoes)
- BAIA(**id_baia**, identificacao UK, localizacao, capacidade, observacoes)
- OCUPACAO_BAIA(**id_ocupacao**, id_baia FK → BAIA, id_cavalo FK → CAVALO, data_inicio, data_fim)
- ALIMENTACAO(**id_alimentacao**, id_cavalo FK → CAVALO, descricao, quantidade, frequencia, data_inicio, data_fim, observacoes)
- ATENDIMENTO_VETERINARIO(**id_atendimento**, id_cavalo FK → CAVALO, id_veterinario FK → VETERINARIO, data_atendimento, descricao_procedimento, diagnostico, observacoes)
- MEDICAMENTO(**id_medicamento**, nome UK, fabricante, descricao)
- PRESCRICAO_MEDICAMENTO(**id_prescricao**, id_atendimento FK → ATENDIMENTO_VETERINARIO, id_medicamento FK → MEDICAMENTO, dosagem, via_administracao, frequencia, data_inicio, data_fim, orientacoes)
- EQUIPAMENTO(**id_equipamento**, nome, tipo, estado_conservacao, identificacao UK)
- USO_EQUIPAMENTO(**id_uso**, id_cavalo FK → CAVALO, id_equipamento FK → EQUIPAMENTO, data_inicio, data_fim, observacoes)
- COMPETICAO(**id_competicao**, nome, data_competicao, local, descricao)
- PARTICIPACAO(**id_participacao**, id_competicao FK → COMPETICAO, id_cavaleiro FK → CAVALEIRO, id_cavalo FK → CAVALO, colocacao, pontuacao, resultado); UK (id_competicao, id_cavaleiro, id_cavalo)
- PAGAMENTO(**id_pagamento**, id_pessoa_pagadora FK → PESSOA, data_pagamento, valor, status, descricao, forma_pagamento)

## Observações de integridade

- A exclusividade de pessoa em papéis distintos é evitada pelo uso de PESSOA como cadastro central; cada subtipo tem FK única para a pessoa.
- A restrição de um cavalo por baia e uma baia por cavalo no mesmo período é implementada por índices únicos parciais para ocupações ativas e gatilhos de sobreposição temporal.
- O esquema permite histórico de alimentação, ocupação de baias, atendimentos, prescrições e uso de equipamentos.
- A tabela PARTICIPACAO_AULA resolve o relacionamento N:N entre AULA e CAVALEIRO.
- A tabela PRESCRICAO_MEDICAMENTO resolve o relacionamento N:N entre ATENDIMENTO_VETERINARIO e MEDICAMENTO, armazenando atributos próprios da prescrição.
