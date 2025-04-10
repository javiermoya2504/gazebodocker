# 🤖 Simulación de TurtleBot 3 en Gazebo con Docker

Este proyecto ejecuta una simulación del robot **TurtleBot 3** en **Gazebo** utilizando **ROS 2 Humble** dentro de un contenedor Docker. El objetivo es cumplir con los lineamientos académicos de simulación robótica.

---

## 🎯 Objetivos

1. Ejecutar una simulación funcional de un sistema robótico en Gazebo.
2. Documentar el procedimiento completo para la instalación y ejecución.
3. Preparar el entorno para ser presentado fácilmente en una exposición.

---

## 📦 Alcance

- Uso de Gazebo e Ignition con ROS 2 Humble.
- Todo en entorno contenido gracias a Docker.
- Visualización gráfica desde el contenedor hacia el host.
- Configurado y probado en Ubuntu Desktop o en máquina virtual.

---

## 🧱 Requisitos

- Docker y Docker Compose instalados.
- Linux con servidor gráfico **Xorg** (no Wayland).
- Comando `xhost` habilitado para permitir acceso gráfico.
- Conexión a internet para descargar las dependencias.

---

## 🚀 Pasos para ejecutar la simulación

```bash
# 1️⃣ Clonar el repositorio
git clone https://github.com/javiermoya2504/gazebodocker.git

# 2️⃣ Dar permisos al contenedor para usar la interfaz gráfica
xhost +local:docker

# 3️⃣ Construir la imagen con Docker Compose
docker-compose build

# 4️⃣ Levantar el contenedor
docker-compose up -d

# 5️⃣ Verificar el nombre o ID del contenedor
docker ps

# 6️⃣ Entrar al contenedor
docker exec -it <nombre_o_id_del_contenedor> bash
# Reemplaza <nombre_o_id_del_contenedor> por el nombre real

# 7️⃣ Lanzar la simulación desde dentro del contenedor
ign gazebo
