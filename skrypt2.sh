#!/bin/bash
echo 'Witaj w programie, który tworzy pliki do .c'
echo 'Podaj ilosc folderow ile ma byc stworzonych'
read fold
cat > schem << "EOF"
#include <stdio.h>
int main (void)
{
   puts ("Hello World!");
   return 0;
}
EOF
  for ((i=1; $i<=$fold; i++)) ; do
    mkdir folder-$i
    echo "Podaj ilosc plikow w folderze numer $i"
    read plik
    cd folder-$i
      for ((j=1; $j<=$plik; j++)); do
        cp ../schem plik-$j.c
      done
    cd ..
  done
rm schem
cat > gcc << "EOF"
#!/bin/bash
echo "Podaj z którego folderu chcesz kompilowac pliki:"
read fold
echo "Podaj ile programów chcesz skompilowac:"
read plik
cd folder-$fold
if [  -e error.txr ]
  then
  rm error.txt
fi
for ((i=1; $i<=$plik; i++)); do
  if [ -e program-$i ]
    then
      echo "Plik numer $i jest już skompilowany! Czy chcesz go
kompilować ponownie? Y/N"
      read komp
      if [ $komp = y ]
        then
	gcc plik-$i -o plik-$i 2>/dev/null   
      fi
    else
      gcc plik-$i.c -o program-$i 2>/dev/null
    if [ -e program-$i ] 
      then
       echo "plik-$i zostal skompilowany"
      else
       echo "plik-$i plik sie nie skompilowal"
       echo plik-$i sie nie kompiluje >> error.txt
    fi
  fi
done
EOF
chmod 755 gcc

cat > kasuj << "EOF"
#!/bin/bash
rm -rf f* gcc kasuj
EOF
chmod 755 kasuj

