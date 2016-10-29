#!/usr/bin/perl -w

#Autor: Fabio S. Schmidt <fabio@bktech.com.br>
#Script para DEFINIR A QUOTA de caixas postais do Cyrus Imap

use Cyrus::IMAP::Admin;
#
                      
# PARAMETROS DE CONFIGURACAO
#
my $cyrus_server = $ARGV[2];
my $cyrus_user = "expresso-admin";
my $matricula = $ARGV[1];
my $mechanism = "login";
#DEFINE O VALOR DA QUOTA (Kbytes)
my $newquota = "30720";

if (!$ARGV[1]) {
    die "Uso: $0 SENHA USUARIO SERVIDOR\n";
} else {
    $cyrus_pass = "$ARGV[0]";
}

print "Definindo a quota do usuario : $matricula. \n";
definequota($matricula);
sub definequota {
    my ($user, $subfolder) = @_;
    my $cyrus = Cyrus::IMAP::Admin->new($cyrus_server);
    $cyrus->authenticate($mechanism,'imap','',$cyrus_user,'0','10000',$cyrus_pass);
    $cyrus->setquota("user.$matricula", 'STORAGE', $newquota);

    if ($cyrus->error) {
        print STDERR "Error: ", $matricula," ", $cyrus->error, "\n";
    } else {
        print "QUOTA para o usuario $matricula foi DEFINIDA em $newquota KB com sucesso.\n";
    }
