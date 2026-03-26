# SENAI TI — Central de Diagnósticos de Laboratório

Sistema web para importação, armazenamento e análise comparativa de diagnósticos de laboratórios de TI das unidades SENAI Bahia.

## Funcionalidades

- **Importar** arquivos `.html` e `.txt` gerados pelo diagnóstico
- **Histórico** de todos os diagnósticos com filtros por unidade e ano
- **Análise Comparativa** com gráficos entre unidades
- **Relatório** detalhado por unidade com exportação para PDF

## Tecnologias

- HTML/CSS/JS puro (sem framework)
- [Supabase](https://supabase.com) — banco de dados PostgreSQL na nuvem
- [Chart.js](https://www.chartjs.org) — gráficos
- GitHub Pages — hospedagem

## Deploy

Este projeto é hospedado via **GitHub Pages**.  
Acesse em: `https://<seu-usuario>.github.io/<nome-do-repo>/`

## Banco de Dados

O schema SQL está em `supabase_schema.sql`.  
Execute no **Supabase → SQL Editor** antes do primeiro uso.

---
Desenvolvido para SENAI Bahia — Especialista de TI
