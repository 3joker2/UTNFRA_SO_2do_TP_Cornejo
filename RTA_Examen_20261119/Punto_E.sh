#!/bin/bash
# PUNTO E - Git
# Cornejo
# Antes de ejecutar crea el repo en GitHub!

FECHA=20261119
REPO="$HOME/UTNFRA_SO_2do_TP_Cornejo"

if [[ ! -d "$REPO" ]]; then
  echo "primero crea el repo en github y clonalo:"
  echo "git clone https://github.com/3joker2/UTNFRA_SO_2do_TP_Cornejo.git"
  exit 1
fi

cd "$REPO" || exit 1

# copio los archivos
cp -r "$HOME/UTN-FRA_SO_Examenes/202406" ./
cp -r "$HOME/RTA_Examen_${FECHA}" ./

# historial
history -a
cp "$HOME/.bash_history" ./

# commit y push
git add .
git commit -m "TP2 parcial - Cornejo"
git push origin main

echo "punto E listo"
