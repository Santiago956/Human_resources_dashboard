# Dashboard de Recursos Humanos
<img width="1442" height="809" alt="image" src="https://github.com/user-attachments/assets/bc769b87-c554-4607-82df-7b8c9357ca2a" />


## 📌 Descrição
Este repositório apresenta um projeto de análise de dados focado em Recursos Humanos. Inclui dados originais e tratados, scripts SQL de limpeza e transformação, e um dashboard final construído no Power BI. Ele foi concebido para fornecer uma visão clara sobre a distribuição dos funcionários em uma empresa fictícia, com dados gerados por IA. O dashboard é compatível com dados provenientes de um servidor MySQL, embora o arquivo PBIX já contenha uma cópia dos dados e das fórmulas DAX utilizadas.

## 🎲 Dados

Os dados são fictícios, gerados por inteligência artificial, abrangendo o período de 2000 a 2020. O dataset contém 22.214 registros únicos com 13 colunas.


## 📁 Estrutura

* `data/` - Contém os dados brutos e tratados.
* `script/` - Scripts SQL de tratamento e análise de dados.
* `dashboard_rh.pbix` - Dashboard em Power BI (pbix)
* `dashboard_rh.pdf` - Dashboard em PDF

## ⚙️ Tecnologias

* MySQL Server & Workbench
* Microsoft Power BI

## 🚀 Objetivos

- Oferecer uma visão geral da estrutura e distribuição dos funcionários.
- Possibilitar a análise por meio de consultas SQL e visualização com o Power BI.
- Servir como referência para projetos de BI integrando bancos de dados relacionais com dashboards interativos.

## 📉 Principais Insights

- **Distribuição de Funcionários**: Maior concentração no departamento de Engenharia, seguido por Contabilidade. Os demais setores apresentam distribuição semelhante.
- **Diversidade**:
  - **Gênero**: índice de 0,524 (diversidade moderada).
  - **Etnia**: índice de 0,819 (diversidade alta).
  - **Combinado (Gênero + Etnia)**: 0,913 (diversidade muito alta).
- **Tempo Médio na Empresa**: 14 anos, sugerindo alta retenção, mas possível envelhecimento da força de trabalho.
- **Taxa de Turnover**: 8%, com picos em 2014 e 2018.
- **Idade Média dos Funcionários**: 41 anos.
- **Cargos Mais Comuns**: Top 3 — Assistente de Pesquisa II, Analista de Negócios e Analista de Recursos Humanos II.
- **Tipo de Trabalho**: 75% presencial e 25% remoto.
- **Residência  dos Funcionários**: Grande maioria localizada no estado de Ohio, os demais estão distribuidos em cidades vizinhas. Somente os moradores de Ohio trabalham presencialmente.

## 🔧 Melhorias futuras

- Automatizar o pipeline ETL para importar dados de fontes reais.
- Publicar o dashboard via Power BI Service ou embed em site.
- Elaborar views em scripts SQL e documentar principais indicadores.

## Contato

Em caso de dúvida ou sugestão, entrar em contato pelo email: ppfsantiago@gmail.com
