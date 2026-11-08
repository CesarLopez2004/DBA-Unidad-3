**Informe Final de Práctica de Laboratorio**
**Unidad III: LAB-01 Bitácoras y auditoría del dato en PostgreSQL**

**1. Objetivo del Laboratorio**
Implementar, gestionar y analizar mecanismos de auditoría en PostgreSQL mediante bitácoras del servidor (logs) y disparadores (`triggers`) forenses, garantizando la integridad de la evidencia frente a manipulaciones de usuarios y administradores.

**2. Cronología del Incidente (Actividad 17)**

| # | Fecha y hora | Usuario | Cliente | Tipo de evento | Qué ocurrió | ¿Exitoso? | Fuente (línea o id_evento) |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | Octubre 2026 | app_ventas | 3 | UPDATE | Cambió el RFC a GAMA780912XYZ | Sí | id_evento: 1 |
| 2 | Octubre 2026 | soporte_ana | - | Acceso | Intento de conexión con contraseña incorrecta | No | línea de bitácora |
| 3 | Octubre 2026 | soporte_ana | 3 | Privilegio | Intentó leer/borrar cliente sin permisos | No | línea de bitácora |
| 4 | Octubre 2026 | app_ventas | 3 | UPDATE | Cambió el RFC a GAMA780912ZZZ | Sí | id_evento: 2 |
| 5 | Octubre 2026 | postgres | 888 | INSERT | Dio de alta al cliente Pedro Ruiz | Sí | id_evento: 3 |
| 6 | Octubre 2026 | postgres | 888 | DELETE | Eliminó al cliente Pedro Ruiz | Sí | id_evento: 4 |
| 7 | Octubre 2026 | postgres | - | Estructura | Apagó trigger `trg_auditoria_clientes` | Sí | línea de bitácora |
| 8 | Octubre 2026 | postgres | 3 | UPDATE | Modificó RFC evadiendo auditoría | Sí | línea de bitácora |

*Nota: Las fechas exactas corresponden a los registros temporales (`timestamps`) generados en el servidor durante la ejecución de la práctica.*

**3. Respuestas a la Dirección**

* **¿Quién cambió el RFC la primera vez? ¿Y en los eventos posteriores?** El primer cambio lo realizó `app_ventas`. Posteriormente, `soporte_ana` intentó hacer un cambio pero fue bloqueada por el sistema. Luego, `app_ventas` lo volvió a modificar de forma exitosa. Finalmente, el usuario `postgres` (Administrador) modificó el RFC evadiendo los controles del trigger.
* **¿Quién cambió el teléfono?** No hay evidencia. En la auditoría ni en la bitácora existen registros de comandos `UPDATE` orientados al campo de teléfono.
* **¿Hubo intentos de acceso fallidos?** Sí, existieron intentos fallidos de autenticación por parte del usuario `soporte_ana` desde la dirección IP `127.0.0.1`, evidenciados en la bitácora del servidor.
* **¿Qué valor tenía el RFC antes de cada cambio?** Antes del cambio auditado en la Actividad 12, el RFC era `GAMA780912XYZ`. Antes del cambio no auditado de la Actividad 14, el RFC era `GAMA780912ZZZ`.

**4. Hallazgos Técnicos y Forenses (Resumen Actividades 12-16)**

* **Valor de la evidencia:** El campo `ip_cliente` resulta fundamental para las investigaciones, dado que el parámetro `application_name` puede ser falsificado fácilmente por el cliente desde su cadena de conexión.
* **Altas y bajas:** El ciclo de vida de los registros queda documentado en la tabla forense. Existe un conflicto inherente entre retener esta información por seguridad y eliminarla para cumplir con la minimización de datos (privacidad).
* **Evasión y separación de funciones:** Un administrador (`postgres`) tiene los privilegios necesarios para desactivar los triggers y modificar datos sin dejar rastro en las tablas de auditoría. Este riesgo subraya la necesidad de enviar los logs a un servidor externo y segregar las funciones de administración y auditoría.
* **Límites de los triggers:** Las operaciones masivas sin cláusula `WHERE` pueden saturar rápidamente el almacenamiento. Asimismo, los disparadores convencionales no pueden registrar eventos de lectura (`SELECT`), dejando consultas sensibles fuera de la auditoría.
* **Preservación de la evidencia:** El log exportado (`bitacora-lab01.log`) fue procesado eliminando secretos en texto plano. Se generó su respectivo hash criptográfico SHA-256 (`bitacora-lab01.sha256`), el cual sirve para demostrar matemáticamente la integridad del archivo y detectar futuras manipulaciones.

**5. Justificación de Omisión (Parte C: pgaudit)**
La Parte C de este laboratorio (Actividades 18 y 19) correspondiente a la configuración de la extensión `pgaudit` no fue completada debido a limitaciones de compatibilidad del entorno. El sistema operativo local es Windows, plataforma que no cuenta con un paquete precompilado oficial para dicha extensión, limitación que se encuentra contemplada en las instrucciones oficiales del laboratorio.

El laboratorio demuestra empíricamente cómo combinar el registro a nivel de motor de base de datos con triggers forenses a nivel de tabla. Se validó que, aunque los triggers con ejecución escalada (`SECURITY DEFINER`) son eficaces contra usuarios y aplicaciones, la bitácora inmutable del servidor es el último recurso confiable frente a las acciones de administradores con privilegios absolutos.
