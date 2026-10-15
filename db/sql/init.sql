-- CREATE SCHEMA healenium AUTHORIZATION healenium_user;
-- GRANT USAGE ON SCHEMA healenium TO healenium_user;



-- This script is executed by official postgres Docker entrypoint on first container initialization.
-- It bootstraps an admin user (POSTGRES_USER) and creates a restricted runtime user for the app.

-- NOTE:
--   * This script runs as superuser.
--   * Do NOT commit real passwords to public repos.

\set ON_ERROR_STOP on

-- Create runtime user (no superuser, no bypassrls)
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'healenium_app') THEN
CREATE ROLE healenium_app LOGIN PASSWORD 'healenium_app_password';
END IF;
END $$;

ALTER ROLE healenium_app NOSUPERUSER NOCREATEDB NOCREATEROLE NOREPLICATION NOBYPASSRLS;

-- Create schema if it doesn't exist
CREATE SCHEMA IF NOT EXISTS healenium;
CREATE SCHEMA IF NOT EXISTS iam;

-- Grant minimal privileges to runtime user
GRANT USAGE ON SCHEMA healenium TO healenium_app;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA healenium TO healenium_app;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA healenium TO healenium_app;

-- Default privileges for future objects
ALTER DEFAULT PRIVILEGES IN SCHEMA healenium
  GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO healenium_app;

ALTER DEFAULT PRIVILEGES IN SCHEMA healenium
  GRANT USAGE, SELECT ON SEQUENCES TO healenium_app;
