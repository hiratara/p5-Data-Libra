package Data::Libra;

use strict;
use warnings;
use version; our $VERSION = qv('0.0.1');
use Digest::MD5;


sub new{
    my $class = shift;
    bless {
            salt   => `hostname`, 
            values => {
                    'VALUE'  => [0, 100], 
            },
            @_  # override default values
          }, $class;
}


sub scan{
    my $self = shift;
    my ($word) = @_;
    my %ret = ();
    foreach my $k(sort keys %{ $self->{values} }){
        my ($min, $max) = @{ $self->{values}{$k} };
        my $range = $max - $min + 1;
        my $md5 = Digest::MD5::md5($k . $self->{salt} . $word);
        $ret{$k} = unpack('J', $md5) % $range + $min;
    }
    return \%ret;
}


1;
__END__

=head1 NAME

Data::Libra - Generating unique and random values from a string.

=head1 SYNOPSIS

    use Data::Libra;

    # using default Libra
    my $libra = new Data::Libra();

    # scan your string
    my $values = $libra->scan('a string');
    print "VALUE: $values->{VALUE}\n"; # a random value from 0 to 100

I<or>

    use Data::Libra;

    # create your Libra!
    my $love_fortune = new Data::Libra(
        salt   => 'necessary to cook well:-p',
        values => {COMPATIBILITY => [0, 100]},
    );

    # calculate your love compatibility number.
    my $result = $love_fortune->scan('Your Name' . 'GirlFriend\'s Name');
    print "$result->{COMPATIBILITY}%\n";

=head1 DESCRIPTION

Data::Libra generate random values from a string. If you scan the same strings, you will get the same values. It works like "Barcode Battler" or "Monster Rancher(Monster Farm)".

=head2 Methods

=over

=item my $libra = new Data::Libra( ... );

Constructor of Data::Libra. All parameters have default values.

=over 2

=item salt => $salt (DEFAULT: `hostname`)

set $salt that is used by random values generator. If a different salt is used, different values will be generated. 

=item values => {KEY => [$min, $max], ...} (DEFAULT: {VALUE => [0, 100]}

set items that you want to get from scan() method. KEY will be contained in the result of scan(). The generated integer corresponding to KEY becomes within the range from $min to $max. 

=back

=item my $ref_values = $libra->scan($some_strings);

generate random values from $some_strings.

For example, if you set values param like this:

  my $libra = new Data::Libra(
      values => {KEY1 => [100, 1000], KEY2 => [1, 100]}
  );

The returned value is a hash reference like this:

  {
    KEY1 => 688,
    KEY2 => 36,
  }

=back

"Libra" is a name of the magic in Final Fantasy by which scan status of monsters.

=head1 BUGS AND LIMITATIONS

No bugs have been reported.

=head1 AUTHOR

Masahiro Honma  C<< <hiratara@cpan.org> >>

=head1 SEE ALSO

Digest::MD5

=head1 LICENCE AND COPYRIGHT

Copyright (c) 2008, Masahiro Honma C<< <hiratara@cpan.org> >>. All rights reserved.

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself. See L<perlartistic>.


=head1 DISCLAIMER OF WARRANTY

BECAUSE THIS SOFTWARE IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY
FOR THE SOFTWARE, TO THE EXTENT PERMITTED BY APPLICABLE LAW. EXCEPT WHEN
OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES
PROVIDE THE SOFTWARE "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER
EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE
ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE SOFTWARE IS WITH
YOU. SHOULD THE SOFTWARE PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL
NECESSARY SERVICING, REPAIR, OR CORRECTION.

IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY AND/OR
REDISTRIBUTE THE SOFTWARE AS PERMITTED BY THE ABOVE LICENCE, BE
LIABLE TO YOU FOR DAMAGES, INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL,
OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OR INABILITY TO USE
THE SOFTWARE (INCLUDING BUT NOT LIMITED TO LOSS OF DATA OR DATA BEING
RENDERED INACCURATE OR LOSSES SUSTAINED BY YOU OR THIRD PARTIES OR A
FAILURE OF THE SOFTWARE TO OPERATE WITH ANY OTHER SOFTWARE), EVEN IF
SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF
SUCH DAMAGES.
