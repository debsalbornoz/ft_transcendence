-----------------------------------------------------------------------
-- ft_transcendence | Módulo 3 — Tracking & Métricas (definições mínimas)
-- SQL Server | Este stub cria apenas as tabelas mtrk.Contatos e mtrk.Campanhas
-- necessárias para satisfazer as chaves estrangeiras do módulo 4. Ele não
-- implementa todas as colunas dos módulos de rastreamento; adicione ou
-- ajuste conforme necessário quando os requisitos completos estiverem
-- disponíveis.
-----------------------------------------------------------------------

-- Criar esquema mtrk se ainda não existir
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = N'mtrk')
BEGIN
    EXEC('CREATE SCHEMA mtrk');
END;
GO

-- Tabela mtrk.Contatos
IF OBJECT_ID('mtrk.Contatos', 'U') IS NULL
BEGIN
    CREATE TABLE mtrk.Contatos (
        rid        BIGINT NOT NULL PRIMARY KEY,
        tenant_id  BIGINT NOT NULL,
        email      NVARCHAR(320) NULL,
        name       NVARCHAR(200) NULL,

        CONSTRAINT FK_Contatos_Tenants
            FOREIGN KEY (tenant_id) REFERENCES core.Tenants(tenant_id)
    );
END;
GO

-- Tabela mtrk.Campanhas
IF OBJECT_ID('mtrk.Campanhas', 'U') IS NULL
BEGIN
    CREATE TABLE mtrk.Campanhas (
        cid        BIGINT NOT NULL PRIMARY KEY,
        tenant_id  BIGINT NOT NULL,
        title      NVARCHAR(200) NOT NULL,
        created_at DATETIME2(3) NOT NULL CONSTRAINT DF_Campanhas_created_at DEFAULT (SYSUTCDATETIME()),

        CONSTRAINT FK_Campanhas_Tenants
            FOREIGN KEY (tenant_id) REFERENCES core.Tenants(tenant_id)
    );
END;
GO