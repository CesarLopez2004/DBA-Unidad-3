-- Unidad 3. LAB-01 Bitácoras y auditoría del dato en PostgreSQL.
-- Actividad 8 — Errores y operaciones rechazadas.
-- PARTE A. Bitácora del servidor.

-- 1. Asegurar permisos (por si acaso)
GRANT SELECT ON public.clientes TO soporte_ana;

-- 2. El analista intenta borrar un dato (Provocará Error de permisos)
SET ROLE soporte_ana;
DELETE FROM public.clientes WHERE id = 5;
RESET ROLE;

-- 3. El administrador intenta eliminar el rol (Provocará Error de dependencias)
DROP ROLE soporte_ana;

SELECT linea FROM dba.bitacora
WHERE linea ~ '(ERROR|STATEMENT|DETAIL):  (permission|privileges|role|DELETE|DROP)'
ORDER BY num DESC LIMIT 10;