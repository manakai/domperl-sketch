use strict;
use warnings;

sub to_number ($) {
  return 0+$_[0];
} # to_number

sub nan () { 0+"nan" }
sub pinf () { 0+"inf" }
sub ninf () { 0+"-inf" }
sub p0 () { 1/"inf" }
sub n0 () { 1/"-inf" }

sub is_nan ($) { $_[0] eq 'nan' }
sub is_p0 ($) { $_[0] eq '0' }
sub is_n0 ($) { $_[0] eq '-0' }
sub is_pinf ($) { $_[0] eq 'inf' }
sub is_ninf ($) { $_[0] eq '-inf' }

sub sign ($) {
  ## ES5 <http://es5.github.com/#sign>
  return $_[0] > 0 ? +1 : $_[0] < 0 ? -1 : 0;
} # sign

sub floor ($) {
  ## cf. ES5 <http://es5.github.com/#floor>

  if (sign $_[0] > 0 or $_[0] == int $_[0]) {
    return int $_[0];
  } else {
    return -int (-$_[0] + 1);
  }
} # floor

sub to_int32 ($) {
  ## ES5 <http://es5.github.com/#x9.5>

  # 1.
  my $number = to_number $_[0];

  # 2.
  if (is_nan $number or is_p0 $number or is_n0 $number or
      is_pinf $number or is_ninf $number) {
    return p0;
  }

  # 3.
  my $pos_int = (sign $number) * floor abs $number;

  # 4.
  my $int32bit = $pos_int % 2**32;

  # 5.
  if ($int32bit >= 2**31) {
    return $int32bit - 2**32;
  } else {
    return $int32bit;
  }
} # to_int32

sub idl_long_to_es_long ($) {
  ## WebIDL <http://dev.w3.org/2006/webapi/WebIDL/#es-long>

  # 1.
  my $x = to_number $_[0];

  # XXX 2.-3.

  # 4.
  $x = to_int32 $x;

  # 5.
  return $x;
} # idl_long_to_es_long

1;
