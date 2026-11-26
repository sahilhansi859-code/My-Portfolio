-- Run this in Supabase SQL Editor

-- Skills & Tools
create table if not exists skills (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  icon text default '',
  chips text[] default '{}',
  sort int default 0,
  created_at timestamptz default now()
);

-- Projects
create table if not exists projects (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  problem text default '',
  tech text default '',
  outcome text default '',
  github_url text default '',
  demo_url text default '',
  sort int default 0,
  created_at timestamptz default now()
);

-- Certifications
create table if not exists certifications (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  platform text default '',
  link text default '',
  sort int default 0,
  created_at timestamptz default now()
);

-- Coding profiles
create table if not exists profiles (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  url text default '',
  note text default '',
  sort int default 0,
  created_at timestamptz default now()
);

-- Blogs
create table if not exists blogs (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  link text default '',
  sort int default 0,
  created_at timestamptz default now()
);

-- Contact messages (from portfolio form)
create table if not exists messages (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  email text not null,
  message text not null,
  read boolean default false,
  created_at timestamptz default now()
);

-- Enable RLS
alter table skills enable row level security;
alter table projects enable row level security;
alter table certifications enable row level security;
alter table profiles enable row level security;
alter table blogs enable row level security;
alter table messages enable row level security;

-- Public can READ content tables
create policy "public read skills" on skills for select using (true);
create policy "public read projects" on projects for select using (true);
create policy "public read certifications" on certifications for select using (true);
create policy "public read profiles" on profiles for select using (true);
create policy "public read blogs" on blogs for select using (true);

-- Only authenticated (admin) can WRITE content
create policy "auth write skills" on skills for all to authenticated using (true) with check (true);
create policy "auth write projects" on projects for all to authenticated using (true) with check (true);
create policy "auth write certifications" on certifications for all to authenticated using (true) with check (true);
create policy "auth write profiles" on profiles for all to authenticated using (true) with check (true);
create policy "auth write blogs" on blogs for all to authenticated using (true) with check (true);

-- Anyone (anon) can INSERT a message; only admin can read/update
create policy "anon insert messages" on messages for insert to anon with check (true);
create policy "auth read messages" on messages for select to authenticated using (true);
create policy "auth update messages" on messages for update to authenticated using (true) with check (true);
create policy "auth delete messages" on messages for delete to authenticated using (true);