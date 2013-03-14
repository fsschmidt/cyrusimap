#!/bin/bash
# APLICAR PERMISSAO PARA O USUARIO ADMIN NAS CAIXAS POSTAIS DO CYRUS IMAP
echo "Aplicando permissoes para o usuario admin nas caixas postais do CYRUS IMAP..."
for i in `cat aplicar_permissao.txt`
	do perl permissao.pl SENHA $i SERVIDOR
done
