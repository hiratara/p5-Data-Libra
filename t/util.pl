use strict;
use warnings;

#===============================================================================
# Sub routines
#===============================================================================
#----------------------------------------------
# has_same_keys($ref_hash1, $ref_hash2) or die;
# check $ref_hash1 and $ref_hash2 have same keys or not
#----------------------------------------------
sub has_same_keys($$){
    my ($ref_hash1, $ref_hash2) = @_;
    my %keys1 = map {$_ => 1} keys %$ref_hash1;
    foreach(keys %$ref_hash2){
	if($keys1{$_}){
	    delete $keys1{$_};
	}else{
	    return 0;
	}
    }
    return %keys1 ? 0 : 1;
}


#----------------------------------------------
# my $dist = distance($ref_hash1, $ref_hash2);
# (square) distance of two hashes.
#----------------------------------------------
sub distance($$){
    my ($ref_hash1, $ref_hash2) = @_;
    my $ret = 0;
    foreach(keys %$ref_hash1){
	$ret += ($ref_hash1->{$_} - $ref_hash2->{$_}) ** 2;
    }
    return $ret;
}

1;
__END__
