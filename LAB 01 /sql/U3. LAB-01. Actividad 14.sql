-- Unidad 3. LAB-01 Bitácoras y auditoría del dato en PostgreSQL.
-- Actividad 14 —  Intentar manipular la auditoría.
-- PARTE B. Auditoría del dato con disparador.

SET ROLE app_ventas;

-- Intento 1: Borrar la evidencia
DELETE FROM auditoria.historial_clientes;

-- Intento 2: Apagar la cámara de seguridad (el disparador)
ALTER TABLE public.clientes DISABLE TRIGGER trg_auditoria_clientes;

RESET ROLE;

RESET ROLE;

-- 1. Apagar el disparador (desactivar auditoría)
ALTER TABLE public.clientes DISABLE TRIGGER trg_auditoria_clientes;

-- 2. Hacer un cambio malicioso sigiloso
UPDATE public.clientes SET rfc = 'GAMA780912GHI' WHERE id = 3;

-- 3. Volver a encender el disparador
ALTER TABLE public.clientes ENABLE TRIGGER trg_auditoria_clientes;

-- 4. Revisar si la cámara atrapó el cambio
SELECT id_auditoria, operacion, datos_nuevos->>'rfc' AS nuevo_rfc 
FROM auditoria.historial_clientes 
ORDER BY id_auditoria DESC LIMIT 3;

SELECT linea FROM dba.bitacora
WHERE linea LIKE '%DISABLE TRIGGER%' OR linea LIKE '%ENABLE TRIGGER%';