# Modelado Orientado a Objetos — Dragon Ball Z (Wollok)

Trabajo práctico de **Programación Orientada a Objetos** desarrollado en **Wollok** para la materia *Paradigmas de Programación* (Ingeniería en Sistemas de Información, UTN FRBA).

El proyecto modela un dominio inspirado en Dragon Ball Z aplicando buenas prácticas de diseño orientado a objetos, manejo de excepciones y pruebas unitarias automatizadas.

---

## Conceptos aplicados
* **Encapsulamiento y polimorfismo** en el modelado de personajes, estados y acciones.
* **Composición y/o herencia** para evitar repetición de lógica.
* **Manejo de excepciones** para validar reglas de negocio y casos borde.
* **Testing unitario** para verificar el comportamiento del modelo ante distintos escenarios.

---

## Estructura del proyecto
* `solucion.wlk`: implementación principal del modelo de dominio, clases/objetos y validaciones.
* `solucion_test.wtest`: suite de pruebas unitarias para validar la lógica y el lanzamiento de excepciones.

---

## Ejecución de pruebas
El proyecto está diseñado para ejecutarse con el entorno de **Wollok** (extensión oficial en VS Code o Wollok CLI):

1. Clonar el repositorio.
2. Abrir la carpeta en VS Code con la extensión **Wollok IDE** instalada.
3. Ejecutar los tests desde `solucion_test.wtest`.
