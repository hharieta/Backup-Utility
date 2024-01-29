#!/bin/bash


server="ubuntu@ec2-18-206-154-55.compute-1.amazonaws.com" 
current_user="$USER" 
 
# Directorio de origen que deseas respaldar 
origen="$HOME/Documents/page" 
 
# Directorio de destino donde se almacenarán las copias de seguridad 
destino="/home/ubuntu/respaldo" 
 
# Nombre del archivo de copia de seguridad con marca de tiempo 
archivo_respaldo="${current_user}_$(date +\%Y\%m\%d_\%H\%M\%S).tar.gz" 
 
# Comprimir y copiar los archivos de origen al directorio de destino 
tar -czvf "$archivo_respaldo" "$origen" 
 
echo "${server}:${destino}" 
 
# Comprobar si la copia de seguridad se realizó con éxito 
if [ $? -eq 0 ]; then 
  echo -e "Backup Created Successfully: $archivo_respaldo" 
  sleep 2 
  echo -e "Sending backup to server: $server ..." 
  scp -i "$HOME/Documents/Utmp01.pem" "$archivo_respaldo" "${server}:${destino}" 
else 
  >&2 echo  "ERR: the backup was not created"
fi

