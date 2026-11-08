# LAB-01: Bitácoras y auditoría del dato en PostgreSQL

## Descripción
Este repositorio contiene las evidencias y scripts de la práctica de laboratorio enfocada en la seguridad y el análisis forense dentro de bases de datos. El objetivo principal fue configurar el rastreo de conexiones en el servidor, implementar disparadores (triggers) forenses utilizando formato `JSONB`, y evadir/detectar manipulaciones de administradores.

## Tecnologías y Herramientas
* PostgreSQL 16
* Terminal (PowerShell) para extracción segura de logs y cálculo de funciones Hash (SHA-256)
* Herramientas cliente: psql / pgAdmin / DBeaver

## Estructura del Repositorio
El proyecto está organizado de la siguiente manera:

* `/evidencias/`: Contiene los reportes de análisis y la evidencia extraída del servidor.
  * `11-incidente-auditado.md`: Análisis del antes y después de los registros.
  * `12-altas-bajas.md`: Rastro del ciclo de vida de los datos (INSERT/DELETE).
  * `13-manipulacion.md`: Evidencia de evasión de triggers por parte del administrador.
  * `14-limites.md`: Análisis de impacto en almacenamiento por transacciones masivas.
  * `15-cronologia.md`: Línea de tiempo completa del incidente de seguridad.
  * `bitacora-lab01.log`: Log del servidor exportado con secretos depurados.
  * `bitacora-lab01.sha256`: Sello criptográfico de integridad.

## Notas de Implementación
* **Parte C (pgaudit):** Esta sección opcional fue omitida intencionalmente. El entorno de desarrollo local opera sobre Windows, plataforma que no cuenta con un paquete precompilado oficial para la extensión, tal como lo estipulan las consideraciones de la práctica.

## Autor
* **Nombre:** [Tu Nombre o Matrícula]
* **Curso/Materia:** Administración de Bases de Datos
* **Fecha:** [Mes y Año]
