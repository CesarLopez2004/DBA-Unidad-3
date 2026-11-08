-- Unidad 3. LAB-01 Bitácoras y auditoría del dato en PostgreSQL.
-- Actividad 9 — Sesiones activas con pg_stat_activity.
-- PARTE A. Bitácora del servidor.

SELECT 
    pid, 
    usename AS usuario, 
    application_name AS aplicacion, 
    client_addr AS ip_cliente, 
    state AS estado, 
    query AS ultima_consulta
FROM pg_stat_activity
WHERE datname = 'comercial' AND pid <> pg_backend_pid();