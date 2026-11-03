#!/bin/bash
# Pruebas automaticas del sitio de Lunaria

errores=0

revisar() {
  if eval "$2"; then
    echo "PASA: $1"
  else
    echo "FALLA: $1"
    errores=$((errores + 1))
  fi
}

revisar "Existe el archivo index.html" "test -f index.html"
revisar "La pagina tiene un <title>" "grep -q '<title>' index.html"
revisar "La pagina menciona Lunaria" "grep -q 'Lunaria' index.html"
revisar "No quedan marcas de conflicto" "! grep -qE '^(<<<<<<<|=======|>>>>>>>)' index.html"
revisar "No hay llaves secretas en el codigo" "! grep -rqE 
'lun_live_[A-Za-z0-9]{8,}|AKIA[0-9A-Z]{16}' --exclude=pruebas.sh --exclude-dir=.git ." 

if [ $errores -gt 0 ]; then
  echo "Fallaron $errores prueba(s). Revisa los mensajes de arriba."
  exit 1
fi

echo "Todas las pruebas pasaron. Lunaria esta lista."