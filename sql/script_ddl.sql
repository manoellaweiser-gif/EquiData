PRAGMA foreign_keys = ON;

CREATE TABLE pessoa (
    id_pessoa INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    cpf TEXT UNIQUE,
    data_nascimento TEXT,
    telefone TEXT,
    email TEXT UNIQUE
);

CREATE TABLE funcionario (
    id_funcionario INTEGER PRIMARY KEY AUTOINCREMENT,
    id_pessoa INTEGER NOT NULL UNIQUE,
    cargo TEXT NOT NULL,
    data_admissao TEXT NOT NULL,
    ativo INTEGER NOT NULL DEFAULT 1 CHECK (ativo IN (0,1)),
    FOREIGN KEY (id_pessoa) REFERENCES pessoa(id_pessoa)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE instrutor (
    id_instrutor INTEGER PRIMARY KEY AUTOINCREMENT,
    id_funcionario INTEGER NOT NULL UNIQUE,
    especialidade TEXT,
    qualificacao TEXT,
    FOREIGN KEY (id_funcionario) REFERENCES funcionario(id_funcionario)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE veterinario (
    id_veterinario INTEGER PRIMARY KEY AUTOINCREMENT,
    id_pessoa INTEGER NOT NULL UNIQUE,
    registro_profissional TEXT UNIQUE,
    telefone_emergencia TEXT,
    FOREIGN KEY (id_pessoa) REFERENCES pessoa(id_pessoa)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE cavaleiro (
    id_cavaleiro INTEGER PRIMARY KEY AUTOINCREMENT,
    id_pessoa INTEGER NOT NULL UNIQUE,
    nivel_experiencia TEXT CHECK (nivel_experiencia IN ('iniciante','intermediario','avancado')),
    data_inicio TEXT,
    FOREIGN KEY (id_pessoa) REFERENCES pessoa(id_pessoa)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE cavalo (
    id_cavalo INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    raca TEXT,
    sexo TEXT CHECK (sexo IN ('M','F','NAO_INFORMADO')),
    data_nascimento TEXT,
    pelagem TEXT,
    microchip TEXT UNIQUE,
    id_proprietario INTEGER NOT NULL,
    ativo INTEGER NOT NULL DEFAULT 1 CHECK (ativo IN (0,1)),
    FOREIGN KEY (id_proprietario) REFERENCES pessoa(id_pessoa)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE modalidade (
    id_modalidade INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL UNIQUE,
    descricao TEXT
);

CREATE TABLE aula (
    id_aula INTEGER PRIMARY KEY AUTOINCREMENT,
    data_hora TEXT NOT NULL,
    duracao_minutos INTEGER NOT NULL CHECK (duracao_minutos > 0),
    id_cavalo INTEGER NOT NULL,
    id_instrutor INTEGER NOT NULL,
    id_modalidade INTEGER NOT NULL,
    observacoes TEXT,
    FOREIGN KEY (id_cavalo) REFERENCES cavalo(id_cavalo)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (id_instrutor) REFERENCES instrutor(id_instrutor)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (id_modalidade) REFERENCES modalidade(id_modalidade)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE participacao_aula (
    id_aula INTEGER NOT NULL,
    id_cavaleiro INTEGER NOT NULL,
    presenca TEXT NOT NULL DEFAULT 'PENDENTE'
        CHECK (presenca IN ('PRESENTE','AUSENTE','PENDENTE')),
    observacao TEXT,
    PRIMARY KEY (id_aula, id_cavaleiro),
    FOREIGN KEY (id_aula) REFERENCES aula(id_aula)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (id_cavaleiro) REFERENCES cavaleiro(id_cavaleiro)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE treino (
    id_treino INTEGER PRIMARY KEY AUTOINCREMENT,
    id_cavalo INTEGER NOT NULL,
    id_cavaleiro_responsavel INTEGER,
    id_modalidade INTEGER,
    data_hora TEXT NOT NULL,
    duracao_minutos INTEGER NOT NULL CHECK (duracao_minutos > 0),
    distancia_km REAL CHECK (distancia_km IS NULL OR distancia_km >= 0),
    velocidade_media_kmh REAL CHECK (velocidade_media_kmh IS NULL OR velocidade_media_kmh >= 0),
    observacoes TEXT,
    FOREIGN KEY (id_cavalo) REFERENCES cavalo(id_cavalo)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (id_cavaleiro_responsavel) REFERENCES cavaleiro(id_cavaleiro)
        ON UPDATE CASCADE ON DELETE SET NULL,
    FOREIGN KEY (id_modalidade) REFERENCES modalidade(id_modalidade)
        ON UPDATE CASCADE ON DELETE SET NULL
);

CREATE TABLE baia (
    id_baia INTEGER PRIMARY KEY AUTOINCREMENT,
    identificacao TEXT NOT NULL UNIQUE,
    localizacao TEXT,
    capacidade INTEGER NOT NULL DEFAULT 1 CHECK (capacidade = 1),
    observacoes TEXT
);

CREATE TABLE ocupacao_baia (
    id_ocupacao INTEGER PRIMARY KEY AUTOINCREMENT,
    id_baia INTEGER NOT NULL,
    id_cavalo INTEGER NOT NULL,
    data_inicio TEXT NOT NULL,
    data_fim TEXT,
    CHECK (data_fim IS NULL OR data_fim >= data_inicio),
    FOREIGN KEY (id_baia) REFERENCES baia(id_baia)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (id_cavalo) REFERENCES cavalo(id_cavalo)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE UNIQUE INDEX uq_baia_ocupacao_ativa
ON ocupacao_baia(id_baia) WHERE data_fim IS NULL;

CREATE UNIQUE INDEX uq_cavalo_ocupacao_ativa
ON ocupacao_baia(id_cavalo) WHERE data_fim IS NULL;

CREATE TABLE alimentacao (
    id_alimentacao INTEGER PRIMARY KEY AUTOINCREMENT,
    id_cavalo INTEGER NOT NULL,
    descricao TEXT NOT NULL,
    quantidade TEXT,
    frequencia TEXT,
    data_inicio TEXT NOT NULL,
    data_fim TEXT,
    observacoes TEXT,
    CHECK (data_fim IS NULL OR data_fim >= data_inicio),
    FOREIGN KEY (id_cavalo) REFERENCES cavalo(id_cavalo)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE atendimento_veterinario (
    id_atendimento INTEGER PRIMARY KEY AUTOINCREMENT,
    id_cavalo INTEGER NOT NULL,
    id_veterinario INTEGER NOT NULL,
    data_atendimento TEXT NOT NULL,
    descricao_procedimento TEXT NOT NULL,
    diagnostico TEXT,
    observacoes TEXT,
    FOREIGN KEY (id_cavalo) REFERENCES cavalo(id_cavalo)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (id_veterinario) REFERENCES veterinario(id_veterinario)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE medicamento (
    id_medicamento INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL UNIQUE,
    fabricante TEXT,
    descricao TEXT
);

CREATE TABLE prescricao_medicamento (
    id_prescricao INTEGER PRIMARY KEY AUTOINCREMENT,
    id_atendimento INTEGER NOT NULL,
    id_medicamento INTEGER NOT NULL,
    dosagem TEXT NOT NULL,
    via_administracao TEXT,
    frequencia TEXT,
    data_inicio TEXT,
    data_fim TEXT,
    orientacoes TEXT,
    CHECK (data_fim IS NULL OR data_inicio IS NULL OR data_fim >= data_inicio),
    FOREIGN KEY (id_atendimento) REFERENCES atendimento_veterinario(id_atendimento)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (id_medicamento) REFERENCES medicamento(id_medicamento)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE equipamento (
    id_equipamento INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    tipo TEXT,
    estado_conservacao TEXT,
    identificacao TEXT UNIQUE
);

CREATE TABLE uso_equipamento (
    id_uso INTEGER PRIMARY KEY AUTOINCREMENT,
    id_cavalo INTEGER NOT NULL,
    id_equipamento INTEGER NOT NULL,
    data_inicio TEXT NOT NULL,
    data_fim TEXT,
    observacoes TEXT,
    CHECK (data_fim IS NULL OR data_fim >= data_inicio),
    FOREIGN KEY (id_cavalo) REFERENCES cavalo(id_cavalo)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (id_equipamento) REFERENCES equipamento(id_equipamento)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE competicao (
    id_competicao INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    data_competicao TEXT NOT NULL,
    local TEXT NOT NULL,
    descricao TEXT
);

CREATE TABLE participacao (
    id_participacao INTEGER PRIMARY KEY AUTOINCREMENT,
    id_competicao INTEGER NOT NULL,
    id_cavaleiro INTEGER NOT NULL,
    id_cavalo INTEGER NOT NULL,
    colocacao INTEGER CHECK (colocacao IS NULL OR colocacao > 0),
    pontuacao REAL,
    resultado TEXT,
    UNIQUE (id_competicao, id_cavaleiro, id_cavalo),
    FOREIGN KEY (id_competicao) REFERENCES competicao(id_competicao)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (id_cavaleiro) REFERENCES cavaleiro(id_cavaleiro)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (id_cavalo) REFERENCES cavalo(id_cavalo)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE pagamento (
    id_pagamento INTEGER PRIMARY KEY AUTOINCREMENT,
    id_pessoa_pagadora INTEGER NOT NULL,
    data_pagamento TEXT NOT NULL,
    valor REAL NOT NULL CHECK (valor > 0),
    status TEXT NOT NULL DEFAULT 'PENDENTE'
        CHECK (status IN ('PENDENTE','PAGO','ATRASADO','CANCELADO')),
    descricao TEXT NOT NULL,
    forma_pagamento TEXT,
    FOREIGN KEY (id_pessoa_pagadora) REFERENCES pessoa(id_pessoa)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

-- Regra de negócio: não permitir períodos de ocupação sobrepostos para a mesma baia
-- ou para o mesmo cavalo, mesmo quando as datas finais são informadas.
CREATE TRIGGER trg_ocupacao_baia_sem_sobreposicao
BEFORE INSERT ON ocupacao_baia
BEGIN
    SELECT CASE WHEN EXISTS (
        SELECT 1 FROM ocupacao_baia o
        WHERE o.id_baia = NEW.id_baia
          AND NEW.data_inicio <= COALESCE(o.data_fim, '9999-12-31')
          AND COALESCE(NEW.data_fim, '9999-12-31') >= o.data_inicio
    ) THEN RAISE(ABORT, 'Baia ja ocupada no periodo informado') END;

    SELECT CASE WHEN EXISTS (
        SELECT 1 FROM ocupacao_baia o
        WHERE o.id_cavalo = NEW.id_cavalo
          AND NEW.data_inicio <= COALESCE(o.data_fim, '9999-12-31')
          AND COALESCE(NEW.data_fim, '9999-12-31') >= o.data_inicio
    ) THEN RAISE(ABORT, 'Cavalo ja possui baia no periodo informado') END;
END;

CREATE TRIGGER trg_ocupacao_baia_sem_sobreposicao_update
BEFORE UPDATE ON ocupacao_baia
BEGIN
    SELECT CASE WHEN EXISTS (
        SELECT 1 FROM ocupacao_baia o
        WHERE o.id_ocupacao <> OLD.id_ocupacao
          AND o.id_baia = NEW.id_baia
          AND NEW.data_inicio <= COALESCE(o.data_fim, '9999-12-31')
          AND COALESCE(NEW.data_fim, '9999-12-31') >= o.data_inicio
    ) THEN RAISE(ABORT, 'Baia ja ocupada no periodo informado') END;

    SELECT CASE WHEN EXISTS (
        SELECT 1 FROM ocupacao_baia o
        WHERE o.id_ocupacao <> OLD.id_ocupacao
          AND o.id_cavalo = NEW.id_cavalo
          AND NEW.data_inicio <= COALESCE(o.data_fim, '9999-12-31')
          AND COALESCE(NEW.data_fim, '9999-12-31') >= o.data_inicio
    ) THEN RAISE(ABORT, 'Cavalo ja possui baia no periodo informado') END;
END;
