import os
import pandas as pd
import pandas_gbq  # Importação direta para eliminar o FutureWarning
from google.oauth2 import service_account

# 1. Configurações de Caminhos e IDs
KEY_PATH = "gcp_credentials.json"
PROJECT_ID = "fintech-credit-risk"  # Seu Project ID do GCP
DATASET_ID = "bronze_zone"          # Seu Dataset criado no BigQuery
TABLE_ID = "raw_loans"              # Nome da tabela de destino
CSV_FILE_PATH = "lending_club_loans.csv" 

TARGET_TABLE = f"{DATASET_ID}.{TABLE_ID}"

print("🚀 Iniciando o processo de ingestão da base COMPLETA (Versão Blindada)...")

# 2. Autenticação na GCP usando a Service Account
if not os.path.exists(KEY_PATH):
    raise FileNotFoundError(f"Erro: O arquivo de credenciais {KEY_PATH} não foi encontrado!")

credentials = service_account.Credentials.from_service_account_file(KEY_PATH)

# 3. Configuração de Leitura em Blocos (Chunking)
CHUNK_SIZE = 100000  # Processa 100 mil linhas por vez
print(f"📖 Lendo o arquivo CSV em blocos de {CHUNK_SIZE} linhas...")

first_chunk = True

try:
    # SOLUÇÃO DO ERRO: Adicionado 'dtype=str'
    # Força o Pandas a ler absolutamente TUDO como string. Evita conflitos de tipos entre blocos.
    for i, chunk in enumerate(pd.read_csv(CSV_FILE_PATH, chunksize=CHUNK_SIZE, dtype=str, low_memory=False)):
        print(f"📦 Processando e limpando o bloco {i + 1}...")
        
        # Mantém a sua limpeza de cabeçalhos
        chunk.columns = chunk.columns.str.strip().str.replace(' ', '_').str.replace('-', '_').str.lower()
        
        mode = "replace" if first_chunk else "append"
        
        print(f"📤 Enviando bloco {i + 1} para o BigQuery (Modo: {mode})...")
        
        # Correção do FutureWarning utilizando pandas_gbq diretamente
        pandas_gbq.to_gbq(
            chunk,
            destination_table=TARGET_TABLE,
            project_id=PROJECT_ID,
            credentials=credentials,
            if_exists=mode
        )
        
        if first_chunk:
            print("🗑️ Tabela antiga deletada com sucesso. Iniciando acúmulo dos novos dados...")
            first_chunk = False  # Próximos blocos farão append seguro

    print("\n✅ INGESTÃO CONCLUÍDA COM SUCESSO! Toda a base de 1,10 GB está salva no BigQuery.")

except Exception as e:
    print(f"\n❌ Erro crítico durante o processo: {e}")
