-- Ejecutar en Supabase → SQL Editor (proyecto nuevo o existente)

create table if not exists reservations (
  id uuid primary key default gen_random_uuid(),
  spot_id text not null,
  section text not null,
  spot_type text not null,
  date date not null,
  start_time text not null,
  duration int not null,
  end_time text not null,
  client_name text not null,
  client_email text not null,
  pay_method text not null default 'efectivo',
  price numeric not null,
  code text not null,
  status text not null default 'confirmada',
  created_at timestamptz not null default now()
);

create index if not exists reservations_date_idx on reservations (date);

-- Realtime: permite que la app reciba altas/bajas en vivo
alter publication supabase_realtime add table reservations;

-- Row Level Security
alter table reservations enable row level security;

-- Política abierta para probar rápido con la clave "anon":
-- cualquiera con el link puede reservar, ver reservas del día y cancelar.
-- Es la misma exposición que ya tenía el prototipo (sin login).
-- Antes de usarla con clientes reales, restringí "delete" (cancelar)
-- a un panel autenticado — ver nota al final del README.
create policy "cualquiera puede leer reservas"
  on reservations for select
  using (true);

create policy "cualquiera puede crear reservas"
  on reservations for insert
  with check (true);

create policy "cualquiera puede cancelar reservas"
  on reservations for delete
  using (true);
