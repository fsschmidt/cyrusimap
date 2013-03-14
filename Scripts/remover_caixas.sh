#!/bin/bash
# EXCLUIR CAIXAS POSTAIS DO CYRUS IMAP
echo "Excluindo caixas postais do CYRUS IMAP..."
for i in `cat remover_caixas.txt`
	do perl remover_caixas.pl SENHA $i SERVIDOR
done
