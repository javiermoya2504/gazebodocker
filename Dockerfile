# Imagen base de ROS 2 Humble
FROM ros:humble

# Evita prompts interactivos durante instalaciones
ENV DEBIAN_FRONTEND=noninteractive

# --- Sección 1: ROS 2 Workspace ---

# Establece el directorio de trabajo donde irá el código fuente
WORKDIR /ros2_humble_ws/src

# Instala los paquetes de ejemplo de ROS 2 (en C++ y Python)
RUN apt-get update && apt-get install -y \
      ros-${ROS_DISTRO}-demo-nodes-cpp \
      ros-${ROS_DISTRO}-demo-nodes-py && \
    rm -rf /var/lib/apt/lists/*

# --- Sección 2: Instalación de Gazebo Fortress y dependencias gráficas ---

# Cambia al directorio /root
WORKDIR /root

# Instala paquetes necesarios para Gazebo y visualización gráfica
RUN apt-get update && apt-get install -y \ 
    lsb-release \           # Información del sistema
    wget \                  # Descargas
    gnupg \                 # Llaves GPG
    x11-apps \              # Herramientas para entorno gráfico X11
    libxext-dev \           # Dependencias para renderizado
    libxrender-dev \ 
    libxtst-dev             # Simulación de eventos de teclado/mouse

# Instala el paquete ros-gz para integración entre ROS y Gazebo
RUN sudo apt-get install -y ros-${ROS_DISTRO}-ros-gz

# --- Herramientas adicionales ---

RUN apt install -y vim     # Editor de texto
RUN apt install -y htop    # Monitor de procesos
RUN apt install -y nvtop   # Monitor de GPU (útil si usas GPU con Docker)

# --- Configuración del entorno ---

# Fuente los entornos de ROS y del workspace al iniciar bash
RUN echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> ~/.bashrc
RUN echo "source /ros2_humble_ws/install/setup.bash" >> ~/.bashrc

# Establece el path para buscar modelos en Gazebo
RUN echo "export GZ_SIM_RESOURCE_PATH=${GZ_SIM_RESOURCE_PATH}:/ros2_humble_ws/src/" >> ~/.bashrc

# Crea un alias útil para volver a cargar la configuración
RUN echo "alias sb='source ~/.bashrc'" >> ~/.bashrc

# Comando por defecto al iniciar el contenedor
CMD [ "/ros2_humble_ws/src/init.sh" ]
