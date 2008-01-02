use lib qw(lib);
use Module::Build::Compat;
Module::Build::Compat->run_build_pl(args => \@ARGV);
Module::Build::Compat->write_makefile(build_class => 'Module::Build');
__END__

use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'Acme::Libra',
    AUTHOR              => 'Masahiro Honma <hira.tara@gmail.com>',
    VERSION_FROM        => 'lib/Acme/Libra.pm',
    ABSTRACT_FROM       => 'lib/Acme/Libra.pm',
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More'  => 0,
        'version'     => 0,
        'Digest::MD5' => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Acme-Libra-*' },
);
