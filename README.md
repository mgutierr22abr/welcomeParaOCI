# Welcome kit para OCI

## Sesion 4: Despliegue de herramientas utiles

ir a consola OCI --> Cloud-Shell

### git clone https://github.com/mgutierr22abr/welcomeParaOCI.git
### cd welcomeParaOCI
Se genera directorio con el proyecto

# ./1terraform.sh
Se genera:

- 2 compartments (herramientas y sandbox)
- red herramientas
- autonomous DW usage
- cluster kubernetes con 1 nodo

# . ./2revisa.sh [auth-token si es que existe]
Si ya existe token, se pasa como parámetro, en caso contrario, se crea automáticamente.

Notar el comando va con punto espacio

Con esto:
- Se revisa que el usuario y token de acceso al OCIR esta correcto
- El cluster kubernetes esta Running y con acceso
