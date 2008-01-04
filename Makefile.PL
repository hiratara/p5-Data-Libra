use lib qw(lib);
use Module::Build::Compat;
Module::Build::Compat->run_build_pl(args => \@ARGV);
Module::Build::Compat->write_makefile(build_class => 'Module::Build');
__END__

use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'Data::Libra',
    AUTHOR              => 'Masahiro Honma <hiratara@cpan.org>',
    VERSION_FROM        => 'lib/Data/Libra.pm',
    ABSTRACT_FROM       => 'lib/Data/Libra.pm',
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More'  => 0,
        'version'     => 0,
        'Digest::MD5' => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Data-Libra-*' },
);
