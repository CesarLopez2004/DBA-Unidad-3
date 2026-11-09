# LAB-02: Auditoría, Trazabilidad y Gobernanza de Datos

Este repositorio contiene el desarrollo, scripts y evidencias del Laboratorio 02. El objetivo principal es implementar mecanismos de auditoría, analizar la trazabilidad de las operaciones y establecer controles compensatorios de gobernanza de datos en MongoDB Community Edition.

## Anexo A: Despliegue del Servidor

El entorno de pruebas fue aprovisionado localmente utilizando **Docker Desktop** (con virtualización SVM habilitada en BIOS).

* **Motor de Base de Datos:** MongoDB Community Edition
* **Versión:** 7.0 (Imagen oficial `mongo:7`)
* **Comando de inicialización:**
  ```bash
  docker run --name dba-u3-mongo -p 27017:27017 -d mongo:7 --auth
