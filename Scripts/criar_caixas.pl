#!/usr/bin/perl -w

#Autor: Fabio S. Schmidt <fabio@bktech.com.br>
#Script para CRIAR caixas postais do Cyrus Imap

use Cyrus::IMAP::Admin;
#
                      
# PARAMETROS DE CONFIGURACAO
#
my $cyrus_server = $ARGV[2];
my $cyrus_user = "imap-admin";
my $matricula = $ARGV[1];
my $mechanism = "login";

if (!$ARGV[1]) {
    die "Uso: $0 SENHA USUARIO SERVIDOR\n";
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
    $cyrus->createmailbox("user.$matricula.Sent");
    $cyrus->createmailbox("user.$matricula.Drafts");
    $cyrus->createmailbox("user.$matricula.Trash");

    if ($cyrus->error) {
        print STDERR "Error: ", $matricula," ", $cyrus->error, "\n";
    } else {
        print "Usuario $matricula foi CRIADO com sucesso.\n";
    }
}
