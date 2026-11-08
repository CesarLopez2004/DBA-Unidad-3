-- Unidad 3. LAB-01 Bitácoras y auditoría del dato en PostgreSQL.
-- Actividad 4 — Configurar la bitácora.
-- PARTE A. Bitácora del servidor.

ALTER SYSTEM SET log_connections = on;
ALTER SYSTEM SET log_disconnections = on;
ALTER SYSTEM SET log_line_prefix = '%m [%p] user=%u db=%d app=%a client=%h ';
ALTER SYSTEM SET log_statement = 'ddl';
SELECT pg_reload_conf();

SELECT name, setting, source
FROM pg_settings
WHERE name IN ('log_connections', 'log_line_prefix', 'log_statement')
ORDER BY name;

SELECT num, linea FROM dba.bitacora ORDER BY num DESC LIMIT 6;
SELECT num, linea FROM dba.bitacora ORDER BY num DESC LIMIT 6;

