# Informe de Auditoría y Gobernanza de Datos (LAB-02)

**Entorno de evaluación:** MongoDB Community Edition v7.0 (Docker)
**Objetivo:** Evaluar las capacidades nativas de trazabilidad, identificar brechas de seguridad y establecer controles compensatorios para el cumplimiento del gobierno de datos.

## 1. Hallazgos Principales y Limitaciones

Durante la ejecución del laboratorio, se identificaron limitaciones críticas en la versión Community respecto a la auditoría de bases de datos:

* **Ausencia de Auditoría Nativa:** El motor de auditoría nativo es exclusivo de MongoDB Enterprise. En la versión Community, no es posible registrar automáticamente y de forma segura todos los eventos de acceso, DDL y DCL sin afectar el rendimiento.
* **El Database Profiler como parche, no como solución:** Se utilizó la colección `system.profile` para registrar operaciones de escritura (CRUD). Sin embargo, esto presenta tres problemas graves:
  1. No registra el "antes" del cambio (before-images), haciendo imposible saber qué dato fue sobrescrito.
  2. Es una colección limitada (capped collection); si hay mucho volumen de transacciones, la evidencia antigua se sobrescribe y se pierde para siempre.
  3. Tiene un "punto ciego" de seguridad: no registra cambios en la configuración de privilegios (ej. `grantRolesToUser`).
* **Volatilidad de la Bitácora (`mongod`):** Aunque el log del servidor es útil para detectar fallos de autenticación e intentos de acceso no autorizados, su almacenamiento en la salida estándar (stdout) de un contenedor efímero lo hace altamente volátil.

## 2. Controles Compensatorios Implementados

Ante las deficiencias de la versión, se diseñaron e implementaron mecanismos paliativos:

* **Filtrado Avanzado del Perfilador:** Se configuró el nivel 1 de perfilado con un filtro estricto (`{ op: { $in: ["insert", "update", "remove"] } }`) para ignorar lecturas. Esto reduce el consumo de disco y evita que operaciones comunes (ruido) borren la evidencia crítica de modificaciones.
* **Instantáneas de Privilegios:** Para cubrir el punto ciego del perfilador frente a la escalación de privilegios, se implementó un script que toma "fotos" periódicas de los roles de los usuarios y las guarda en una colección inmutable (`auditoria.instantaneas_privilegios`). Esto permite detectar si un usuario (como `app_ventas`) obtiene repentinamente permisos de administrador (`dbAdmin`), aunque no revele quién ejecutó el comando.
* **Proceso de Exportación:** Se establecieron comandos de extracción (`mongoexport`) para resguardar la evidencia efímera del perfilador hacia un sistema de archivos externo seguro.

## 3. Conclusión y Recomendación a Dirección

La infraestructura actual basada en **MongoDB Community Edition no es apta para entornos sujetos a normativas de cumplimiento estrictas** (como PCI-DSS, HIPAA o leyes de protección de datos personales). Aunque los controles compensatorios mitigan parcialmente el riesgo, las brechas técnicas impiden una respuesta a incidentes forense completa (imposibilidad de rastrear al autor exacto de una asignación de roles o recuperar el estado previo de un registro borrado/modificado).

**Recomendación:** Si los datos manejados en la base de datos `comercial` son sensibles y la organización tiene requerimientos legales de trazabilidad al 100%, se recomienda justificar presupuestalmente la migración a **MongoDB Enterprise** o **MongoDB Atlas**, los cuales incluyen un motor de auditoría nativo independiente y herramientas robustas de retención de logs.
