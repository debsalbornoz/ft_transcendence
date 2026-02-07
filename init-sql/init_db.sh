#!/bin/bash

# Script de inicialização do banco de dados SQL Server para o projeto ft_transcendence.
#
# Este script aguarda o serviço de banco (`db`) estar disponível, cria o banco
# "transcendence" caso ainda não exista e executa os scripts DDL fornecidos
# (ddl_1_2.sql, ddl_mtrk_stub.sql e ddl_3.sql). Após concluir, ele encerra sua execução.

set -euo pipefail

# Configurações de conexão. Para simplificar, as credenciais são embutidas aqui.
DB_HOST="db"
DB_USER="sa"
DB_PASS="YourStrong!Passw0rd"
DB_NAME="transcendence"

wait_for_sql() {
  echo "Aguardando o SQL Server iniciar em ${DB_HOST}..."
  # Tenta se conectar até que tenha sucesso.
  until /opt/mssql-tools/bin/sqlcmd -S "$DB_HOST" -U "$DB_USER" -P "$DB_PASS" -Q "SELECT 1;" &> /dev/null; do
    echo "SQL Server indisponível — aguardando 2 segundos..."
    sleep 2
  done
  echo "SQL Server disponível, prosseguindo com a inicialização."
}

create_database() {
  echo "Criando banco '${DB_NAME}' caso não exista..."
  /opt/mssql-tools/bin/sqlcmd -S "$DB_HOST" -U "$DB_USER" -P "$DB_PASS" \
    -Q "IF DB_ID('$DB_NAME') IS NULL CREATE DATABASE [$DB_NAME];"
}

run_migrations() {
  echo "Aplicando scripts DDL ao banco '${DB_NAME}'..."
  # A ordem é importante: primeiro criamos os módulos core/auth, depois o stub
  # do módulo de métricas (mtrk) e, por fim, as tabelas de marketing (ddl_3.sql).
  for script in /init-sql/ddl_1_2.sql /init-sql/ddl_mtrk_stub.sql /init-sql/ddl_3.sql; do
    echo "Executando $script..."
    /opt/mssql-tools/bin/sqlcmd -S "$DB_HOST" -U "$DB_USER" -P "$DB_PASS" \
      -d "$DB_NAME" -i "$script"
  done
  echo "Scripts executados com sucesso."
}

main() {
  wait_for_sql
  create_database
  run_migrations
  echo "Inicialização concluída."
}

main "$@"