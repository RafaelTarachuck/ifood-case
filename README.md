# Case Técnico Data Engineer - iFood

![iFood](https://img.shields.io/badge/iFood-Data_Architecture-EA1D2C)

## 📋 Sobre o Projeto

Este projeto apresenta uma solução completa para o desafio de Data Architecture do iFood, abordando a ingestão, processamento, armazenamento e análise de dados de corridas de táxi de Nova York.

A solução implementa uma arquitetura de dados moderna, escalável e eficiente, utilizando tecnologias como Google Cloud Storage, Delta Lake, PySpark e BigQuery para criar um pipeline de dados que vai desde a ingestão dos dados brutos até a disponibilização para análise.

## 🏗️ Arquitetura da Solução

A solução segue uma arquitetura em camadas:

1. **Landing Zone (Raw)**: Armazenamento inicial dos dados brutos em seu formato original (Parquet)
2. **Processing Zone (Delta Lake)**: Conversão para formato Delta Lake, otimizado para processamento
3. **Consumption Zone (BigQuery)**: Disponibilização dos dados tratados para análise via SQL

```
Fonte de Dados → GCS (Raw) → Delta Lake → BigQuery → Análises SQL
```

## 🗂️ Estrutura do Projeto

```
ifood-case/
├─ src/                       # Código fonte da solução
│  ├─ to_cloud_storage.ipynb  # Script de ingestão para o Data Lake
│  └─ lake_to_warehouse.ipynb # Script de processamento para o Data Warehouse
├─ analysis/                  # Scripts SQL com as respostas das perguntas
│  ├─ yellow - média do total_amount por mês para yellow táxis.sql
│  ├─ yellow - média de passageiros por hora.sql
│  ├─ yellow - análise por dia da semana e hora do dia.sql
│  └─ Comparação entre Yellow e Green táxis.sql
├─ README.md                  # Documentação do projeto
└─ requirements.txt           # Dependências do projeto
```

## 🔧 Tecnologias Utilizadas

- **Linguagens**: Python, SQL
- **Framework de Processamento**: PySpark
- **Armazenamento**: Google Cloud Storage (GCS)
- **Formato de Dados**: Parquet, Delta Lake
- **Data Warehouse**: BigQuery
- **Ambiente**: Dataproc Spark Connect

## ⚙️ Requisitos

- Conta Google Cloud Platform com acesso a GCS, BigQuery e Dataproc
- Python 3.9+
- Databricks Community Edition ou ambiente Spark local (opcional para testes)

## 🚀 Instruções de Execução

### 1. Configuração do Ambiente

```bash
# Clonar o repositório
git clone https://github.com/seu-usuario/ifood-case.git
cd ifood-case

# Instalar dependências
pip install -r requirements.txt

# Configurar credenciais GCP (substitua pelo caminho do seu arquivo de credenciais)
export GOOGLE_APPLICATION_CREDENTIALS="/caminho/para/seu/arquivo-credenciais.json"
```

### 2. Execução dos Notebooks

Os notebooks devem ser executados na seguinte ordem:

1. `src/to_cloud_storage.ipynb` - Realiza a ingestão dos dados para o Data Lake
2. `src/lake_to_warehouse.ipynb` - Processa os dados e disponibiliza no BigQuery

Estes notebooks podem ser executados em um ambiente Jupyter local, no Databricks Community Edition, ou no Google Colab conectado ao Dataproc.

### 3. Análises SQL

Após a execução dos notebooks, as análises SQL podem ser executadas no BigQuery console ou em qualquer ferramenta SQL conectada ao BigQuery.

## 📊 Análises Realizadas

1. **Média do valor total por mês para yellow táxis**
   - Analisa a média do `total_amount` recebido em cada mês, considerando todos os yellow táxis da frota.

2. **Média de passageiros por hora em maio**
   - Calcula a média de `passenger_count` por cada hora do dia no mês de maio de 2023.

3. **Análise por dia da semana e hora do dia**
   - Analisa padrões de uso dos táxis por dia da semana e hora do dia.

4. **Comparação entre táxis Yellow e Green**
   - Compara métricas-chave entre os dois tipos de táxis.

## 📝 Justificativas Técnicas

### Escolha das Tecnologias

- **PySpark**: Processamento distribuído para lidar com grandes volumes de dados.
- **Delta Lake**: Formato otimizado que oferece ACID transactions, viabilizando operações confiáveis.
- **Google Cloud Storage**: Armazenamento escalável e de baixo custo para a landing zone.
- **BigQuery**: Data warehouse serverless que permite consultas SQL rápidas e eficientes.

### Modelagem de Dados

Optei por uma modelagem simplificada que mantém as colunas essenciais solicitadas:
- VendorID
- passenger_count
- total_amount
- tpep_pickup_datetime
- tpep_dropoff_datetime

### Estratégia de Ingestão

Implementei uma estratégia de ingestão em duas etapas:
1. Ingestão inicial para GCS (dados brutos)
2. Processamento e disponibilização em BigQuery (dados tratados)

Esta abordagem permite manter os dados originais intactos enquanto oferece uma camada otimizada para consultas analíticas.
