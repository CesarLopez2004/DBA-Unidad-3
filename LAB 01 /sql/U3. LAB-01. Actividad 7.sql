-- Unidad 3. LAB-01 Bitácoras y auditoría del dato en PostgreSQL.
-- Actividad 7 — Modificaciones de datos: ddl frente a mod.
-- PARTE A. Bitácora del servidor.

ALTER SYSTEM SET log_statement = 'mod';
SELECT pg_reload_conf();

SET ROLE app_ventas;

-- 1. Modificar un dato
UPDATE public.clientes SET telefono = '6679990000' WHERE id = 3;

-- 2. Leer un dato
SELECT nombre, rfc FROM public.clientes WHERE id = 3;

RESET ROLE;

SELECT num, linea FROM dba.bitacora 
WHERE linea LIKE '%log_statement%' OR linea LIKE '%app_ventas%statement:%'
ORDER BY num DESC LIMIT 5;