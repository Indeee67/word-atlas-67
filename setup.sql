create table if not exists public.word_atlas_sync (
  user_id uuid primary key references auth.users(id) on delete cascade,
  payload jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.word_atlas_sync enable row level security;

create policy "read own word atlas data"
on public.word_atlas_sync for select to authenticated
using (auth.uid() = user_id);

create policy "insert own word atlas data"
on public.word_atlas_sync for insert to authenticated
with check (auth.uid() = user_id);

create policy "update own word atlas data"
on public.word_atlas_sync for update to authenticated
using (auth.uid() = user_id)
with check (auth.uid() = user_id);
