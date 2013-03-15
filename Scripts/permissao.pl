#!/usr/bin/perl -w

#Autor: Fabio S. Schmidt <fabio.schmidt@4linux.com.br>
#Revisao em: 14/03/2013
#Script para aplicar permissao em caixas postais do Cyrus Imap

use Cyrus::IMAP::Admin;
#
                      
# PARAMETROS DE CONFIGURACAO
#
my $cyrus_server = $ARGV[2];
my $cyrus_user = "admin";
my $matricula = $ARGV[1];
my $mechanism = "login";

if (!$ARGV[1]) {
    die "Uso: $0 SENHA MAILBOX SERVIDOR\n";
} else {
    $cyrus_pass = "$ARGV[0]";
}

print "Aplicando permissao ALL para o usuario $cyrus_user na caixa : $matricula. \n";
aplicapermissao($matricula);
sub aplicapermissao {
    my ($user, $subfolder) = @_;
    my $cyrus = Cyrus::IMAP::Admin->new($cyrus_server);
    $cyrus->authenticate($mechanism,'imap','',$cyrus_user,'0','10000',$cyrus_pass);
    $cyrus->setaclmailbox("user.$matricula", 'admin', 'all');

    if ($cyrus->error) {
        print STDERR "Error: ", $matricula," ", $cyrus->error, "\n";
    } else {
        print "Permissao concedida para o usuario $matricula.\n";
    }
}
