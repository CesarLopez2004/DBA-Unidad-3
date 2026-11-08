-- Unidad 3. LAB-01 Bitácoras y auditoría del dato en PostgreSQL.
-- Actividad 11 — Crear la función y el disparador.
-- PARTE B. Auditoría del dato con disparador.

SELECT id_auditoria, operacion, usuario_db, fecha_evento, datos_anteriores 
FROM auditoria.historial_clientes 
ORDER BY id_auditoria DESC LIMIT 1;

INSERT INTO public.clientes (id, nombre, correo, telefono, rfc, edad, ciudad, codigo_postal, fecha_alta)
SELECT
    (datos_anteriores->>'id')::BIGINT,
    datos_anteriores->>'nombre',
    datos_anteriores->>'correo',
    datos_anteriores->>'telefono',
    datos_anteriores->>'rfc',
    (datos_anteriores->>'edad')::INTEGER,
    datos_anteriores->>'ciudad',
    datos_anteriores->>'codigo_postal',
    (datos_anteriores->>'fecha_alta')::DATE
FROM auditoria.historial_clientes
WHERE operacion = 'DELETE' AND id_cliente = 999
ORDER BY id_auditoria DESC LIMIT 1;

SELECT * FROM public.clientes WHERE id = 999;