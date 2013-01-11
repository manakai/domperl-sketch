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

sub to_int16_pack ($) {
  return unpack 's', pack 'S', $_[0] % 2**16;
} # to_int16_pack

sub es_to_idl_short ($) {
  ## WebIDL <http://dev.w3.org/2006/webapi/WebIDL/#es-short>

  # 1.
  my $x = to_number $_[0];

  # XXX 2.-3.

  # 4.
  if (is_nan $x or is_p0 $x or is_n0 $x or is_pinf $x or is_ninf $x) {
    return p0;
  }

  # 3.
  $x = (sign $x) * floor abs $x;

  # 4.
  $x = $x % 2**16;

  # 5.
  if ($x >= 2**15) {
    return $x - 2**16;
  } else {
    return $x;
  }
} # es_to_idl_short

sub to_uint16 ($) {
  ## ES5 <http://es5.github.com/#x9.7>

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
  my $int16bit = $pos_int % 2**16;

  # 5.
  return $int16bit;
} # to_uint16

sub to_uint16_pack ($) {
  return unpack 'S', pack 'S', $_[0] % 2**32;
} # to_uint16_pack

sub es_to_idl_unsigned_short ($) {
  ## WebIDL <http://dev.w3.org/2006/webapi/WebIDL/#es-unsigned-short>

  # 1.
  my $x = to_number $_[0];

  # XXX

  # 4.
  $x = to_uint16 $x;

  # 5.
  return $x;
} # es_to_idl_unsigned_short

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

sub to_int32_pack ($) {
  return unpack 'l', pack 'L', $_[0] % 2**32;
} # to_int32_pack

sub es_to_idl_long ($) {
  ## WebIDL <http://dev.w3.org/2006/webapi/WebIDL/#es-long>

  # 1.
  my $x = to_number $_[0];

  # XXX 2.-3.

  # 4.
  $x = to_int32 $x;

  # 5.
  return $x;
} # es_to_idl_long

sub to_uint32 ($) {
  ## ES5 <http://es5.github.com/#x9.6>

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
  return $int32bit;
} # to_uint32

sub to_uint32_pack ($) {
  return unpack 'L', pack 'L', $_[0] % 2**32;
} # to_uint32_pack

sub es_to_idl_unsigned_long ($) {
  ## WebIDL <http://dev.w3.org/2006/webapi/WebIDL/#es-unsigned-long>

  # 1.
  my $x = to_number $_[0];

  # XXX

  # 4.
  $x = to_uint32 $x;

  # 5.
  return $x;
} # es_to_idl_unsigned_long

1;
