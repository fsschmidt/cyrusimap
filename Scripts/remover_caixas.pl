#!/usr/bin/perl -w

#Autor: Fabio S. Schmidt <fabio.schmidt@4linux.com.br>
#Script para remover caixas postais do Cyrus Imap

use Cyrus::IMAP::Admin;
#
                      
# PARAMETROS DE CONFIGURACAO
#
my $cyrus_server = $ARGV[2];
my $cyrus_user = "admin";
my $matricula = $ARGV[1];
my $mechanism = "login";

if (!$ARGV[1]) {
    die "Usage: $0 SENHA MAILBOX SERVIDOR\n";
} else {
    $cyrus_pass = "$ARGV[0]";
}

print "Removendo usuario : $matricula. \n";
removeusuario($matricula);
sub removeusuario {
    my ($user, $subfolder) = @_;
    my $cyrus = Cyrus::IMAP::Admin->new($cyrus_server);
    $cyrus->authenticate($mechanism,'imap','',$cyrus_user,'0','10000',$cyrus_pass);
    $cyrus->deletemailbox("user.$matricula");

    if ($cyrus->error) {
        print STDERR "Error: ", $matricula," ", $cyrus->error, "\n";
    } else {
        print "Usuario $matricula foi removido com sucesso.\n";
    }
}
