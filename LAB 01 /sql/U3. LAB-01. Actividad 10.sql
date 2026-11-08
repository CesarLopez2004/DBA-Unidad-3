-- Unidad 3. LAB-01 Bitácoras y auditoría del dato en PostgreSQL.
-- Actividad 10 — Diseñar y crear el registro de auditoría.
-- PARTE B. Auditoría del dato con disparador.

-- 1. Crear un esquema dedicado para la auditoría (separado de los datos públicos)
CREATE SCHEMA IF NOT EXISTS auditoria;
REVOKE ALL ON SCHEMA auditoria FROM PUBLIC;

-- 2. Crear la tabla que guardará el rastro de los cambios
CREATE TABLE auditoria.historial_clientes (
    id_auditoria BIGSERIAL PRIMARY KEY,
    fecha_evento TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    usuario_db VARCHAR(50) DEFAULT current_user,
    operacion VARCHAR(10), -- Guardará si fue INSERT, UPDATE o DELETE
    id_cliente BIGINT,
    datos_anteriores JSONB, -- Formato JSON para guardar toda la fila vieja
    datos_nuevos JSONB      -- Formato JSON para guardar toda la fila nueva
);

-- 1. Crear la función del Trigger
CREATE OR REPLACE FUNCTION auditoria.fn_auditar_clientes()
RETURNS TRIGGER AS $$
BEGIN
    IF (TG_OP = 'DELETE') THEN
        INSERT INTO auditoria.historial_clientes (operacion, id_cliente, datos_anteriores, datos_nuevos)
        VALUES ('DELETE', OLD.id, row_to_json(OLD), NULL);
        RETURN OLD;
    ELSIF (TG_OP = 'UPDATE') THEN
        INSERT INTO auditoria.historial_clientes (operacion, id_cliente, datos_anteriores, datos_nuevos)
        VALUES ('UPDATE', NEW.id, row_to_json(OLD), row_to_json(NEW));
        RETURN NEW;
    ELSIF (TG_OP = 'INSERT') THEN
        INSERT INTO auditoria.historial_clientes (operacion, id_cliente, datos_anteriores, datos_nuevos)
        VALUES ('INSERT', NEW.id, NULL, row_to_json(NEW));
        RETURN NEW;
    END IF;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

-- 2. Conectar la función a la tabla clientes mediante el Trigger
CREATE TRIGGER trg_auditoria_clientes
AFTER INSERT OR UPDATE OR DELETE ON public.clientes
FOR EACH ROW EXECUTE FUNCTION auditoria.fn_auditar_clientes();