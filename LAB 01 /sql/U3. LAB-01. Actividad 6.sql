-- Unidad 3. LAB-01 Bitácoras y auditoría del dato en PostgreSQL.
-- Actividad 6 — Cambios de privilegios y de estructura.
-- PARTE A. Bitácora del servidor.

-- 1. Intentar revocar un permiso (aunque no lo tenga, es buena práctica preventiva)
REVOKE UPDATE ON public.clientes FROM soporte;

-- 2. Otorgar permisos a la aplicación
GRANT UPDATE ON public.clientes TO app_ventas;

-- 3. Cambiar la estructura de la tabla agregando una columna
ALTER TABLE public.clientes ADD COLUMN segmento VARCHAR(20);

-- 4. Crear un rol con la contraseña expuesta en el comando y luego borrarlo
CREATE ROLE rol_temporal LOGIN PASSWORD 'Temporal_Practica_2026';
DROP ROLE rol_temporal;

SELECT linea FROM dba.bitacora 
WHERE linea LIKE '%statement:%' 
ORDER BY num DESC LIMIT 10;