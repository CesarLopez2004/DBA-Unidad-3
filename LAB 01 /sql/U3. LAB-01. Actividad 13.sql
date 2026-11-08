-- Unidad 3. LAB-01 Bitácoras y auditoría del dato en PostgreSQL.
-- Actividad 13 — Altas y bajas.
-- PARTE B. Auditoría del dato con disparador.

-- 1. Asegurar sesión como administrador
RESET ROLE;

-- 2. Insertar al nuevo cliente (Pedro Ruiz)
INSERT INTO public.clientes (id, nombre, correo, rfc, edad, ciudad, codigo_postal, fecha_alta)
VALUES (888, 'Pedro Ruiz', 'pedro.ruiz@example.test', 'RUPE950101AAA', 30, 'Guasave', '81000', CURRENT_DATE);

-- 3. Borrar inmediatamente al cliente
DELETE FROM public.clientes WHERE id = 888;

-- 4. Consultar la auditoría para ver el rastro de la alta y la baja
SELECT id_auditoria, usuario_db, operacion, id_cliente,
       datos_anteriores ->> 'rfc' AS rfc_antes,
       datos_nuevos ->> 'rfc' AS rfc_despues
FROM auditoria.historial_clientes
ORDER BY id_auditoria DESC LIMIT 3;