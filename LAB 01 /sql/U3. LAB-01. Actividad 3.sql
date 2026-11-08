-- Unidad 3. LAB-01 Bitácoras y auditoría del dato en PostgreSQL.
-- Actividad 3 — El incidente sin bitácora.
-- PARTE A. Bitácora del servidor.

-- 1. Crear el rol (si te dice que ya existe, ignora el error) y darle permisos
CREATE ROLE app_ventas LOGIN PASSWORD 'Ventas_Practica_2026';
GRANT SELECT, UPDATE ON public.clientes TO app_ventas;

-- 2. Simular el incidente cambiando temporalmente a ese rol
SET ROLE app_ventas;
UPDATE public.clientes SET rfc = 'GAMA780912XXX' WHERE id = 3;
RESET ROLE;

SELECT linea FROM dba.bitacora
WHERE linea ILIKE '%update%' OR linea LIKE '%app_ventas%';