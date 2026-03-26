-- =============================================
-- SCHEMA SENAI TI — Diagnósticos de Laboratório
-- Execute no Supabase SQL Editor
-- =============================================

-- Habilitar UUID
create extension if not exists "pgcrypto";

-- 1. Diagnósticos (cabeçalho principal)
create table if not exists diagnosticos (
  id uuid primary key default gen_random_uuid(),
  criado_em timestamptz default now(),
  unidade text not null,
  especialista text,
  acompanhante text,
  data_visita date,
  gerado_em timestamptz,
  fonte text -- 'html', 'txt', 'manual'
);

-- 2. Rede
create table if not exists rede (
  id uuid primary key default gen_random_uuid(),
  diagnostico_id uuid references diagnosticos(id) on delete cascade,
  hostname text,
  ip text,
  dominio text,
  tipo_conexao text,
  velocidade text,
  mac text,
  gateway text,
  dns text,
  internet boolean
);

-- 3. Laboratório
create table if not exists laboratorio (
  id uuid primary key default gen_random_uuid(),
  diagnostico_id uuid references diagnosticos(id) on delete cascade,
  nome_lab text,
  qtd_computadores int,
  codigo_patrimonio text,
  observacoes text
);

-- 4. Hardware
create table if not exists hardware (
  id uuid primary key default gen_random_uuid(),
  diagnostico_id uuid references diagnosticos(id) on delete cascade,
  processador text,
  familia_cpu text,
  nucleos_fisicos int,
  nucleos_logicos int,
  frequencia_mhz int,
  ram_gb numeric(6,2),
  ram_tipo text,
  discos jsonb
);

-- 5. Sistema Operacional
create table if not exists sistema_operacional (
  id uuid primary key default gen_random_uuid(),
  diagnostico_id uuid references diagnosticos(id) on delete cascade,
  sistema text,
  arquitetura text,
  data_instalacao date,
  ultimo_boot timestamptz,
  build text,
  versao text
);

-- 6. Apps DS (checklist de apps esperados)
create table if not exists apps_ds (
  id uuid primary key default gen_random_uuid(),
  diagnostico_id uuid references diagnosticos(id) on delete cascade,
  nome text,
  grupo text,
  prioridade text,
  versao text,
  status text
);

-- 7. Apps instalados (lista completa)
create table if not exists apps_instalados (
  id uuid primary key default gen_random_uuid(),
  diagnostico_id uuid references diagnosticos(id) on delete cascade,
  nome text,
  versao text,
  publicador text,
  data_instalacao date
);

-- 8. Compatibilidade
create table if not exists compatibilidade (
  id uuid primary key default gen_random_uuid(),
  diagnostico_id uuid references diagnosticos(id) on delete cascade,
  criterio text,
  detalhe text,
  status text
);

-- =============================================
-- RLS: Permitir acesso público (ajuste conforme necessário)
-- =============================================
alter table diagnosticos enable row level security;
alter table rede enable row level security;
alter table laboratorio enable row level security;
alter table hardware enable row level security;
alter table sistema_operacional enable row level security;
alter table apps_ds enable row level security;
alter table apps_instalados enable row level security;
alter table compatibilidade enable row level security;

-- Políticas permissivas (anon pode ler e escrever)
do $$ 
declare t text;
begin
  foreach t in array array['diagnosticos','rede','laboratorio','hardware','sistema_operacional','apps_ds','apps_instalados','compatibilidade']
  loop
    execute format('create policy "allow_all_%s" on %s for all using (true) with check (true)', t, t);
  end loop;
end $$;
