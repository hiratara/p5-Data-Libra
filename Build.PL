use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'Acme::Libra',
    license             => 'perl',
    dist_author         => 'Masahiro Honma <hiratara@cpan.org>',
    dist_version_from   => 'lib/Acme/Libra.pm',
    requires => {
        'Test::More'  => 0,
        'version'     => 0,
        'Digest::MD5' => 0,
    },
    add_to_cleanup      => [ 'Acme-Libra-*' ],
);

$builder->create_build_script();
