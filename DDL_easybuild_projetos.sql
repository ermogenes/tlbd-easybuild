CREATE DATABASE easybuild_projetos;
go

USE easybuild_projetos;

CREATE TABLE alocacao(
    codigo_funcionario    int    NOT NULL,
    codigo_projeto        int    NOT NULL
);

ALTER TABLE alocacao ADD CONSTRAINT PK_alocacao 
	PRIMARY KEY CLUSTERED (codigo_funcionario, codigo_projeto);

CREATE TABLE cargo(
    codigo_cargo    int            IDENTITY(1,1),
    nome_cargo      varchar(50)    NOT NULL
);

ALTER TABLE cargo ADD CONSTRAINT PK_cargo 
	PRIMARY KEY CLUSTERED (codigo_cargo);

CREATE TABLE departamento(
    codigo_departamento             int             IDENTITY(1,1),
    nome_departamento               varchar(200)    NOT NULL,
    codigo_funcionario_gerente      int             NULL,
    codigo_departamento_superior    int             NULL
);

ALTER TABLE departamento ADD CONSTRAINT PK_departamento 
	PRIMARY KEY CLUSTERED (codigo_departamento);

CREATE TABLE engenheiro(
    codigo_funcionario    int               NOT NULL,
    numero_crea           decimal(12, 0)    NOT NULL
);

ALTER TABLE engenheiro ADD CONSTRAINT PK_engenheiro 
	PRIMARY KEY CLUSTERED (codigo_funcionario);

CREATE TABLE funcionario(
    codigo_funcionario     int               IDENTITY(1,1),
    nome_funcionario       varchar(200)      NOT NULL,
    cpf_funcionario        decimal(11, 0)    NOT NULL,
    salario_funcionario    decimal(10, 2)    NULL,
    codigo_departamento    int               NOT NULL,
    codigo_cargo           int               NOT NULL
);

ALTER TABLE funcionario ADD CONSTRAINT PK_funcionario 
	PRIMARY KEY CLUSTERED (codigo_funcionario);

CREATE TABLE motorista(
    codigo_funcionario    int               NOT NULL,
    numero_cnh            decimal(11, 0)    NOT NULL,
    tipo_cnh              char(1)           NOT NULL
);

ALTER TABLE motorista ADD CONSTRAINT PK_motorista 
	PRIMARY KEY CLUSTERED (codigo_funcionario);

CREATE TABLE projeto(
    codigo_projeto                     int             IDENTITY(1,1),
    nome_projeto                       varchar(200)    NOT NULL,
    codigo_departamento_responsavel    int             NOT NULL
);

ALTER TABLE projeto ADD CONSTRAINT PK_projeto 
	PRIMARY KEY CLUSTERED (codigo_projeto);

CREATE INDEX IX_funcionario_projeto ON alocacao(codigo_funcionario);
CREATE INDEX IX_projeto ON alocacao(codigo_projeto);

CREATE UNIQUE INDEX AK_nome_cargo ON cargo(nome_cargo);

CREATE INDEX IX_gerente ON departamento(codigo_funcionario_gerente);
CREATE INDEX IX_superior ON departamento(codigo_departamento_superior);

CREATE INDEX IX_funcionario_engenheiro ON engenheiro(codigo_funcionario);

CREATE INDEX IX_departamento ON funcionario(codigo_departamento);
CREATE INDEX IX_cargo ON funcionario(codigo_cargo);

CREATE INDEX IX_funcionario_motorista ON motorista(codigo_funcionario);

CREATE INDEX IX_responsavel ON projeto(codigo_departamento_responsavel);

ALTER TABLE departamento ADD CONSTRAINT AK_nome_departamento 
	UNIQUE NONCLUSTERED (nome_departamento);

ALTER TABLE engenheiro ADD CONSTRAINT AK_crea 
	UNIQUE NONCLUSTERED (numero_crea);

ALTER TABLE funcionario ADD CONSTRAINT AK_cpf 
	UNIQUE NONCLUSTERED (cpf_funcionario);

ALTER TABLE motorista ADD CONSTRAINT AK_cnh 
	UNIQUE NONCLUSTERED (numero_cnh);

ALTER TABLE projeto ADD CONSTRAINT AK_nome_projeto 
	UNIQUE NONCLUSTERED (nome_projeto);

ALTER TABLE alocacao ADD CONSTRAINT FK_funcionario_alocacao 
    FOREIGN KEY (codigo_funcionario)
    REFERENCES funcionario(codigo_funcionario);

ALTER TABLE alocacao ADD CONSTRAINT FK_projeto_alocacao 
    FOREIGN KEY (codigo_projeto)
    REFERENCES projeto(codigo_projeto);

ALTER TABLE departamento ADD CONSTRAINT FK_departamento_departamento_superior 
    FOREIGN KEY (codigo_departamento_superior)
    REFERENCES departamento(codigo_departamento);

ALTER TABLE departamento ADD CONSTRAINT FK_funcionario_departamento 
    FOREIGN KEY (codigo_funcionario_gerente)
    REFERENCES funcionario(codigo_funcionario);

ALTER TABLE engenheiro ADD CONSTRAINT FK_funcionario_engenheiro 
    FOREIGN KEY (codigo_funcionario)
    REFERENCES funcionario(codigo_funcionario);

ALTER TABLE funcionario ADD CONSTRAINT FK_cargo_funcionario 
    FOREIGN KEY (codigo_cargo)
    REFERENCES cargo(codigo_cargo);

ALTER TABLE funcionario ADD CONSTRAINT FK_departamento_funcionario 
    FOREIGN KEY (codigo_departamento)
    REFERENCES departamento(codigo_departamento);

ALTER TABLE motorista ADD CONSTRAINT FK_funcionario_motorista 
    FOREIGN KEY (codigo_funcionario)
    REFERENCES funcionario(codigo_funcionario);

ALTER TABLE projeto ADD CONSTRAINT FK_departamento_projeto 
    FOREIGN KEY (codigo_departamento_responsavel)
    REFERENCES departamento(codigo_departamento);
