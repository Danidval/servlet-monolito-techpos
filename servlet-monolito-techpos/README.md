# 🔧 TechPOS - Sistema de Gestión de Reparaciones Técnicas

## 📌 Descripción

TechPOS es una aplicación web monolítica desarrollada en **Java con Servlets y JSP** para la gestión de un taller de reparaciones técnicas.

Este módulo incluye:

- Sistema completo de **autenticación** (Login / Logout)
- Dashboard protegido según rol de usuario
- Conexión segura a base de datos MySQL
- Interfaz moderna y responsive

Proyecto desarrollado como evidencia para el **SENA** (Evidencia GA7-220501096-AA2-EV02 / AA3-EV01).

---

## 🛠️ Tecnologías utilizadas

- **Java 21**
- **Jakarta Servlet 6.0**
- **JSP (JavaServer Pages)**
- **MySQL 8.0**
- **Maven** (gestión de dependencias)
- **Tomcat 10+**
- **HTML5 + CSS3** (diseño responsive)

---

## 📁 Estructura del proyecto

```bash
servlet-monolito-techpos/
├── src/main/java/
│   ├── datos/
│   │   └── Conexion.java
│   ├── dominio/
│   │   └── Usuario.java
│   └── servlet/
│       ├── LoginServlet.java
│       └── LogoutServlet.java
├── src/main/webapp/
│   ├── index.jsp
│   ├── login.jsp
│   └── WEB-INF/
│       └── web.xml
├── pom.xml
├── .gitignore
└── techposv1.sql          # Script de creación de la base de datos
```

---

## ⚙️ Requisitos previos

- JDK 21 o superior
- MySQL Server 8.0 o superior
- Apache Tomcat 10+
- Maven (recomendado)
- IntelliJ IDEA o Eclipse (recomendado)

---

## 🗄️ Configuración de la base de datos

1. Crea la base de datos:

   ```sql
   CREATE DATABASE IF NOT EXISTS techposv1;
   ```

2. Ejecuta el script `techposv1.sql` (incluido en la raíz del proyecto).

3. Verifica las credenciales de conexión en `src/main/java/datos/Conexion.java`:

   ```java
   private static final String USUARIO = "root";
   private static final String CONTRASENA = "3333";   // ← Cambia según tu configuración
   ```

---

## 🚀 Cómo ejecutar el proyecto

1. Clonar o descargar el proyecto.
2. Abrir el proyecto en IntelliJ IDEA (recomendado) como proyecto Maven.
3. Configurar Tomcat 10+:
   - Ve a **Run → Edit Configurations**
   - Agrega un nuevo **Tomcat Server → Local**
   - En **Deployment**, agrega el artefacto `TechPOSv1:war exploded`
4. Ejecutar el servidor Tomcat.
5. Abre tu navegador y accede a:

   ```
   http://localhost:8080/servlet_monolito_techpos_war_exploded/login.jsp
   ```

---

## 🔑 Credenciales de prueba

| Rol | Usuario | Contraseña |
|---|---|---|
| Administrador | admin | 123 |
| Recepcionista | laura | 123 |

> **Nota:** Las contraseñas están en texto plano (solo para fines educativos).

---

## 🔐 Funcionalidades implementadas

- ✅ Formulario de login con validación de campos
- ✅ Autenticación segura contra base de datos MySQL
- ✅ Gestión de sesiones con `HttpSession`
- ✅ Protección de rutas (`index.jsp` requiere login)
- ✅ Cierre de sesión seguro (`LogoutServlet`)
- ✅ Dashboard responsive con información del usuario
- ✅ Roles de usuario (Administrador, Recepcionista, etc.)
- ✅ Mensajes de error claros
- ✅ Diseño moderno y adaptable (mobile-friendly)

---

## 📸 Capturas (próximamente)

- Pantalla de login
- Dashboard principal

---

## 👨‍💻 Autor

**Danid Esneider Vallejos Almeida**  
Tecnólogo en Análisis y Desarrollo de Software  
Servicio Nacional de Aprendizaje — SENA

---

## 📎 Evidencia académica

Código fuente entregado para las evidencias:

- `GA7-220501096-AA2-EV02`
- `AA3-EV01`

**Repositorio:** [https://github.com/Danidval/servlet-monolito-techpos](https://github.com/Danidval/servlet-monolito-techpos)
