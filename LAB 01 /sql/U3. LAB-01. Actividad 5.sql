-- Unidad 3. LAB-01 Bitácoras y auditoría del dato en PostgreSQL.
-- Actividad 5 — Accesos exitosos y fallidos.
-- PARTE A. Bitácora del servidor.

SELECT linea FROM dba.bitacora 
WHERE linea LIKE '%FATAL%' OR linea LIKE '%authenticated%' OR linea LIKE '%disconnection%'
ORDER BY num DESC LIMIT 15;

SELECT linea FROM dba.bitacora 
WHERE linea LIKE '%FATAL:  password authentication failed%' AND linea LIKE '%user=app_ventas%';