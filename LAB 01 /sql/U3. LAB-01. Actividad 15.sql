-- Unidad 3. LAB-01 Bitácoras y auditoría del dato en PostgreSQL.
-- Actividad 15 —  Límites: lecturas y volumen.
-- PARTE B. Auditoría del dato con disparador.

-- 1. Intentar auditar una simple lectura de datos sensibles como soporte_ana
SET ROLE soporte_ana;
SELECT nombre, rfc, telefono FROM public.clientes WHERE id = 3;
RESET ROLE;

-- 2. El Administrador hace un cambio masivo (afecta a toda la tabla)
UPDATE public.clientes SET edad = edad;

-- 3. Revisar cuánto espacio ocupó el UPDATE en la bitácora del servidor
SELECT count(*) AS lineas_bitacora FROM dba.bitacora
WHERE linea LIKE '%statement: UPDATE public.clientes SET edad = edad%';

-- 4. Revisar cuánto espacio ocupó el UPDATE en nuestra tabla de auditoría
SELECT operacion, count(*) FROM auditoria.historial_clientes 
GROUP BY operacion ORDER BY operacion;

-- 5. Buscar si la lectura (SELECT) dejó algún rastro en los logs
SELECT count(*) AS lecturas_soporte FROM dba.bitacora
WHERE linea LIKE '%user=soporte_ana%SELECT nombre, rfc%';