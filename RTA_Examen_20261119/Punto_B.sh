#!/bin/bash
# PUNTO B - Bash Scripting
# Cornejo
# ACA TENES Q EDITAR <tu-usuario> con tu user del sistema

USUARIO_ALUMNO="cornejo"
SCRIPT="CornejoAltaUser-Groups.sh"
DESTINO="/usr/local/bin/$SCRIPT"

# si no esta en /usr/local/bin lo copio
if [[ ! -f "$DESTINO" ]]; then
  # busco en varios lados
  for dir in "." "$HOME" "/vagrant/scripts"; do
    if [[ -f "$dir/$SCRIPT" ]]; then
      sudo cp "$dir/$SCRIPT" "$DESTINO"
      sudo chmod +x "$DESTINO"
      break
    fi
  done
fi

if [[ ! -f "$DESTINO" ]]; then
  echo "no encontre $SCRIPT, copialo a $DESTINO y corre de nuevo"
  exit 1
fi

# ejecuto la creacion de usuarios
$DESTINO "$USUARIO_ALUMNO" "$HOME/UTN-FRA_SO_Examenes/202406/bash_script/Lista_Usuarios.txt"

# verifico
echo ""
grep -i 2P /etc/passwd
grep -iE "2P_GDesa|2P_GTest|2PSupervisores" /etc/group
ls -l /work/

echo "termine punto B"
