-- Unidad 3. LAB-01 Bitácoras y auditoría del dato en PostgreSQL.
-- Actividad 12 — El incidente auditado.
-- PARTE B. Auditoría del dato con disparador.

-- 1. Actuar como la aplicación
SET ROLE app_ventas;

-- 2. Cambiar el RFC del cliente 3
UPDATE public.clientes SET rfc = 'GAMA780912ZZZ' WHERE id = 3;

-- 3. Intentar ver la tabla de auditoría (¡Esto dará error de permisos!)
SELECT * FROM auditoria.historial_clientes;

-- 4. Soltar el rol
RESET ROLE;

-- Asegurar sesión como administrador
RESET ROLE;

-- Extraer los valores que cambiaron comparando los JSON
SELECT a.id_auditoria, a.fecha_evento, a.usuario_db,
       d.key AS campo,
       a.datos_anteriores ->> d.key AS antes,
       d.value #>> '{}' AS despues
FROM auditoria.historial_clientes a
CROSS JOIN LATERAL jsonb_each(a.datos_nuevos) d
WHERE a.operacion = 'UPDATE'
  AND a.datos_anteriores -> d.key IS DISTINCT FROM d.value
ORDER BY a.id_auditoria DESC LIMIT 1;