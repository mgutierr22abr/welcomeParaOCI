# Welcome kit para OCI

## Sesion 4: Despliegue de herramientas utiles

## Infraestructura Base
ir a consola OCI --> Cloud-Shell

### git clone https://github.com/mgutierr22abr/welcomeParaOCI.git
### cd welcomeParaOCI
Se genera directorio con el proyecto

### ./1terraform.sh
Se genera:

- 2 compartments (herramientas y sandbox)
- red herramientas
- autonomous DW usage
- cluster kubernetes con 1 nodo

### . ./2revisa.sh [auth-token si es que existe]
Si ya existe token, se pasa como parámetro, en caso contrario, se crea automáticamente.

Notar el comando va con punto espacio

Con esto:
- Se revisa que el usuario y token de acceso al OCIR esta correcto
- El cluster kubernetes esta Running y con acceso

### ./3prepara.sh
- Se genera el dynamic-group (máquina de kubernetes)
- Se genera política de acceso para el grupo
- Se genera archivo ejemplo crontab

## Ejemplos

## OKIT
Herramienta de Diseño

- https://github.com/oracle/oci-designer-toolkit.git

### cd OKIT
### ./genera.sh

- Se crea imagen docker
- Se hace push al repositorio
- Se despliega el pod

## Usage Reports
Graficos personalizados de consumo OCI

- https://github.com/oracle/oci-python-sdk/blob/master/examples/usage_reports_to_adw

### cd UsageReports
### ./genera.sh

- Se crea imagen docker
- Se hace push al repositorio
- Se despliega el pod
- Se carga datos a ADW

## Agenda
Agenda de encendido/apagado de recursos (instancias, dbnodes, autonomous)

### cd Agenda
### ./genera.sh

- Se crea imagen docker
- Se hace push al repositorio
- Se despliega el pod
