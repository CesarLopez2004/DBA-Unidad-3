-- Unidad 3. LAB-01 Bitácoras y auditoría del dato en PostgreSQL.
-- Actividad 17 —  Reconstruir la cronología y responder a Dirección.
-- CIERRE DE LAS PARTES A Y B.

SELECT id_auditoria, fecha_evento, usuario_db, operacion, id_cliente
FROM auditoria.historial_clientes 
ORDER BY fecha_evento ASC;

SELECT num, linea 
FROM dba.bitacora 
WHERE linea LIKE '%FATAL%' 
   OR linea LIKE '%ERROR:  permission denied%' 
   OR linea LIKE '%DISABLE TRIGGER%' 
ORDER BY num ASC;