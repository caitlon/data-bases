CREATE USER readonly_user_psinder WITH PASSWORD 'cixfo6-fyqjyQ-nohbog';
GRANT CONNECT ON DATABASE "psinder-db" TO readonly_user_psinder;
GRANT USAGE ON SCHEMA public TO readonly_user_psinder;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO readonly_user_psinder;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO readonly_user_psinder;
