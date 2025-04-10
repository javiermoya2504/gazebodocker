FROM ros:humble

# Evita prompts durante instalaciones
ENV DEBIAN_FRONTEND=noninteractive

# --- ROS 2 Workspace ---

# Establece el directorio de trabajo para el código fuente
WORKDIR /ros2_humble_ws/src

# Instala nodos de ejemplo en C++ y Python de ROS 2
RUN apt-get update && apt-get install -y \
    ros-${ROS_DISTRO}-demo-nodes-cpp \
    ros-${ROS_DISTRO}-demo-nodes-py && \
    rm -rf /var/lib/apt/lists/*

# --- Instalación de Gazebo Fortress y dependencias gráficas ---

# Cambia al directorio /root
WORKDIR /root

# Instala utilidades básicas del sistema y dependencias de entorno gráfico
RUN apt-get update && apt-get install -y \
    lsb-release \
    wget \
    gnupg \
    x11-apps \
    libxext-dev \
    libxrender-dev \
    libxtst-dev

# Instala el paquete de integración entre ROS y Gazebo
RUN apt-get install -y ros-${ROS_DISTRO}-ros-gz

# --- Herramientas útiles ---
RUN apt install -y vim     # Editor de texto
RUN apt install -y htop    # Monitor de procesos
RUN apt install -y nvtop   # Monitor de GPU

# --- Configuración del entorno ---

# Agrega los entornos de ROS y del workspace al bashrc
RUN echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> ~/.bashrc
RUN echo "source /ros2_humble_ws/install/setup.bash" >> ~/.bashrc

# Establece el path para buscar modelos en Gazebo
RUN echo "export GZ_SIM_RESOURCE_PATH=${GZ_SIM_RESOURCE_PATH}:/ros2_humble_ws/src/" >> ~/.bashrc

# Crea un alias para recargar bashrc fácilmente
RUN echo "alias sb='source ~/.bashrc'" >> ~/.bashrc

# Comando por defecto al iniciar el contenedor
CMD [ "/ros2_humble_ws/src/init.sh" ]
