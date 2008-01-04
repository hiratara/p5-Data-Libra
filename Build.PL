use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'Data::Libra',
    license             => 'perl',
    dist_author         => 'Masahiro Honma <hiratara@cpan.org>',
    dist_version_from   => 'lib/Data/Libra.pm',
    requires => {
        'Test::More'  => 0,
        'version'     => 0,
        'Digest::MD5' => 0,
    },
    add_to_cleanup      => [ 'Data-Libra-*' ],
);

$builder->create_build_script();
