#!/bin/bash
# CRIAR CAIXAS POSTAIS DO CYRUS IMAP
SERVIDOR=IP_DO_SERVIDOR

echo "Criando caixas postais do CYRUS IMAP..."
for i in `cat criar_caixas.txt`
  do perl criar_caixas.pl SENHA $i $SERVIDOR
done
