-- Unidad 3. LAB-01 Bitácoras y auditoría del dato en PostgreSQL.
-- Actividad 16 —  Exportar y conservar la bitácora.
-- CIERRE DE LAS PARTES A Y B.

SELECT replace(
    convert_from(pg_read_binary_file(pg_current_logfile()), 'LATIN1'), 
    'Temporal_Practica_2026', 
    '<REDACTED>'
);