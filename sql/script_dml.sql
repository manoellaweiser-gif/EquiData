PRAGMA foreign_keys = ON;

INSERT INTO pessoa (nome, cpf, data_nascimento, telefone, email) VALUES
('Ana Martins', '00000000001', '1995-04-12', '(48) 99999-0001', 'ana@example.com'),
('Bruno Costa', '00000000002', '1988-09-20', '(48) 99999-0002', 'bruno@example.com'),
('Carla Souza', '00000000003', '1992-01-15', '(48) 99999-0003', 'carla@example.com'),
('Daniel Ribeiro', '00000000004', '1980-07-30', '(48) 99999-0004', 'daniel@example.com'),
('Eduarda Lima', '00000000005', '1998-11-02', '(48) 99999-0005', 'eduarda@example.com');

INSERT INTO funcionario (id_pessoa, cargo, data_admissao) VALUES
(2, 'Instrutor', '2023-02-01'),
(4, 'Tratador', '2022-06-10');

INSERT INTO instrutor (id_funcionario, especialidade, qualificacao)
VALUES (1, 'Salto', 'Instrutor de equitação');

INSERT INTO veterinario (id_pessoa, registro_profissional, telefone_emergencia)
VALUES (3, 'CRM-VET-EXEMPLO-001', '(48) 98888-0003');

INSERT INTO cavaleiro (id_pessoa, nivel_experiencia, data_inicio) VALUES
(1, 'intermediario', '2024-03-01'),
(5, 'iniciante', '2025-02-10');

INSERT INTO cavalo (nome, raca, sexo, data_nascimento, pelagem, microchip, id_proprietario) VALUES
('Estrela', 'Mangalarga', 'F', '2017-05-10', 'Castanha', 'CHIP-EX-001', 1),
('Trovão', 'Quarto de Milha', 'M', '2016-08-21', 'Alazão', 'CHIP-EX-002', 5);

INSERT INTO modalidade (nome, descricao) VALUES
('Salto', 'Modalidade de salto equestre'),
('Adestramento', 'Modalidade de adestramento clássico');

INSERT INTO aula (data_hora, duracao_minutos, id_cavalo, id_instrutor, id_modalidade, observacoes)
VALUES ('2026-11-10 09:00:00', 60, 1, 1, 1, 'Aula demonstrativa de exemplo');

INSERT INTO participacao_aula (id_aula, id_cavaleiro, presenca, observacao) VALUES
(1, 1, 'PRESENTE', 'Participação de exemplo'),
(1, 2, 'PENDENTE', NULL);

INSERT INTO treino (id_cavalo, id_cavaleiro_responsavel, id_modalidade, data_hora, duracao_minutos, distancia_km, velocidade_media_kmh, observacoes)
VALUES (2, 1, 2, '2026-11-11 07:30:00', 45, 6.2, 8.27, 'Treino fictício para teste');

INSERT INTO baia (identificacao, localizacao, observacoes) VALUES
('B-01', 'Pavilhão A', 'Baia de exemplo'),
('B-02', 'Pavilhão A', 'Baia de exemplo');

INSERT INTO ocupacao_baia (id_baia, id_cavalo, data_inicio, data_fim) VALUES
(1, 1, '2026-01-01', NULL),
(2, 2, '2026-01-01', NULL);

INSERT INTO alimentacao (id_cavalo, descricao, quantidade, frequencia, data_inicio, observacoes)
VALUES (1, 'Feno e ração', '2 kg de ração', '2 vezes ao dia', '2026-01-01', 'Plano fictício');

INSERT INTO atendimento_veterinario (id_cavalo, id_veterinario, data_atendimento, descricao_procedimento, diagnostico)
VALUES (1, 1, '2026-10-20', 'Avaliação clínica de rotina', 'Sem alterações no exemplo');

INSERT INTO medicamento (nome, fabricante, descricao)
VALUES ('Medicamento de demonstração', 'Fabricante fictício', 'Registro fictício para teste do banco');

INSERT INTO prescricao_medicamento (id_atendimento, id_medicamento, dosagem, via_administracao, frequencia, data_inicio, data_fim, orientacoes)
VALUES (1, 1, 'Conforme prescrição fictícia', 'Oral', 'Conforme orientação veterinária', '2026-10-20', '2026-10-22', 'Dado ilustrativo; não constitui orientação clínica');

INSERT INTO equipamento (nome, tipo, estado_conservacao, identificacao)
VALUES ('Sela de treinamento', 'Sela', 'Bom', 'EQ-001');

INSERT INTO uso_equipamento (id_cavalo, id_equipamento, data_inicio, observacoes)
VALUES (1, 1, '2026-01-01', 'Uso de demonstração');

INSERT INTO competicao (nome, data_competicao, local, descricao)
VALUES ('Copa Equestre de Exemplo', '2026-12-05', 'Florianópolis - SC', 'Competição fictícia para teste');

INSERT INTO participacao (id_competicao, id_cavaleiro, id_cavalo, colocacao, pontuacao, resultado)
VALUES (1, 1, 1, 2, 85.5, 'Segundo lugar - dado fictício');

INSERT INTO pagamento (id_pessoa_pagadora, data_pagamento, valor, status, descricao, forma_pagamento)
VALUES (1, '2026-11-05', 350.00, 'PAGO', 'Mensalidade fictícia', 'PIX');
