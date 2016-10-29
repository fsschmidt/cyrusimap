#!/usr/bin/perl -w

#Autor: Fabio S. Schmidt <fabio@bktech.com.br>
#Script para CRIAR caixas postais do Cyrus Imap
#definindo permissao na caixa criada para o admin
#definindo a quota

use Cyrus::IMAP::Admin;
#
                      
# PARAMETROS DE CONFIGURACAO
#
my $cyrus_server = $ARGV[2];
my $cyrus_user = "imap-admin";
my $matricula = $ARGV[1];
my $mechanism = "login";
#DEFINE O VALOR DA QUOTA (Kbytes)
my $newquota = "30720";

if (!$ARGV[1]) {
    die "Usage: $0 SENHA USUARIO SERVIDOR\n";
} else {
    $cyrus_pass = "$ARGV[0]";
}

print "Inserindo usuario : $matricula. \n";
insereusuario($matricula);
sub insereusuario {
    my ($user, $subfolder) = @_;
    my $cyrus = Cyrus::IMAP::Admin->new($cyrus_server);
    $cyrus->authenticate($mechanism,'imap','',$cyrus_user,'0','10000',$cyrus_pass);
    $cyrus->createmailbox("user.$matricula");
#Define a quota com o valor de newquota
    $cyrus->setquota("user.$matricula", 'STORAGE', $newquota);
#Define a permissao para o usuario admin
    $cyrus->setaclmailbox("user.$matricula", 'expresso-admin', 'all');
#Criando as pastas basicas, enviados, lixeira e rascunhos
    $cyrus->createmailbox("user.$matricula.Sent");
    $cyrus->createmailbox("user.$matricula.Drafts");
    $cyrus->createmailbox("user.$matricula.Trash");

    if ($cyrus->error) {
        print STDERR "Error: ", $matricula," ", $cyrus->error, "\n";
    } else {
        print "Usuario $matricula foi CRIADO com sucesso.\n";
        print "QUOTA para o usuario foi DEFINIDA em $newquota KB com sucesso.\n";
    }
}
