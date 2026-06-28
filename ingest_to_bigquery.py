import os
import pandas as pd
from google.oauth2 import service_account

# 1. Configurações de Caminhos e IDs (Altere com os seus dados)
KEY_PATH = "gcp_credentials.json"
PROJECT_ID = "fintech-credit-risk"  # Seu Project ID do GCP
DATASET_ID = "bronze_zone"          # Seu Dataset criado no BigQuery
TABLE_ID = "raw_loans"              # Nome da tabela de destino
CSV_FILE_PATH = "lending_club_loans.csv" # Seu arquivo do Kaggle

TARGET_TABLE = f"{DATASET_ID}.{TABLE_ID}"

print("🚀 Iniciando o processo de ingestão...")

# 2. Autenticação na GCP usando a Service Account
if not os.path.exists(KEY_PATH):
    raise FileNotFoundError(f"Erro: O arquivo de credenciais {KEY_PATH} não foi encontrado!")

credentials = service_account.Credentials.from_service_account_file(KEY_PATH)

# 3. Leitura Otimizada do CSV (Pareto: 50k linhas é o ponto ideal)
print(f"📖 Lendo o arquivo CSV: {CSV_FILE_PATH}...")
df = pd.read_csv(CSV_FILE_PATH, nrows=50000, low_memory=False)

# Pequena limpeza preventiva nas colunas para o BigQuery não rejeitar
df.columns = df.columns.str.strip().str.replace(' ', '_').str.replace('-', '_').str.lower()

print(f"Dataframe carregado com sucesso. Formato: {df.shape}")

# 4. Upload Direto para o Google BigQuery
print(f"📤 Enviando dados para o BigQuery na tabela {TARGET_TABLE}...")
try:
    df.to_gbq(
        destination_table=TARGET_TABLE,
        project_id=PROJECT_ID,
        credentials=credentials,
        if_exists="replace"  # Se a tabela já existir, ele substitui
    )
    print("✅ Ingestão concluída com sucesso! Os dados já estão na nuvem.")
except Exception as e:
    print(f"❌ Erro durante o upload para o BigQuery: {e}")