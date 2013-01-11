use strict;
use warnings;
use Path::Class;
use lib file (__FILE__)->dir->parent->subdir ('lib')->stringify;
use lib glob file (__FILE__)->dir->parent->subdir ('t_deps', 'modules', '*', 'lib')->stringify;
use Test::More;
use Test::X1;
BEGIN { require 'datatypes.pl' };

test {
  my $c = shift;
  ok is_nan nan;
  done $c;
} n => 1, name => 'nan';

test {
  my $c = shift;
  ok is_pinf pinf;
  ok not is_pinf ninf;
  done $c;
} n => 2, name => '+inf';

test {
  my $c = shift;
  ok is_ninf ninf;
  ok not is_ninf pinf;
  done $c;
} n => 2, name => '-inf';

test {
  my $c = shift;
  ok is_p0 p0;
  ok not is_p0 n0;
  done $c;
} n => 2, name => '+0';

test {
  my $c = shift;
  ok is_n0 n0;
  ok not is_n0 p0;
  done $c;
} n => 2, name => '-0';

for my $test (
  [12 => 12],
  [12.5 => 12],
  [2**15-1 => 2**15-1],
  [2**15 => -2**15],
  [-1 => -1],
  [-10.5 => -10],
  [-20.3 => -20],
  [2**16-1 => -1],
  [2**16 => 0],
  [2**16 + 5 => 5],
  [2**16 + 2**15 - 1 => 2**15 - 1],
  [2**16 + 2**16 + 2**15 => -2**15],
  [2**16 - 20.0003 => -21],
  [2**16 - 20.3 => -21],
  [2**16 - 20.9993 => -21],
  [nan, p0],
  [pinf, p0],
  [ninf, p0],
  [p0, p0],
  [n0, p0],
) {
  test {
    my $c = shift;
    my $v = to_int16_pack $test->[0];
    is $v, $test->[1];
    done $c;
  } n => 1, name => ['to_int16_pack', $test->[0]];

  test {
    my $c = shift;
    my $v = es_to_idl_short $test->[0];
    is $v, $test->[1];
    done $c;
  } n => 1, name => ['es_to_idl_short', $test->[0]];
}

for my $test (
  [12 => 12],
  [12.5 => 12],
  [2**15-1 => 2**15-1],
  [2**15 => 2**15],
  [-1 => 2**16-1],
  [-10.5 => 2**16-10],
  [-20.3 => 2**16-20],
  [2**16-1 => 2**16-1],
  [2**16 => 0],
  [2**16 + 5 => 5],
  [2**16 + 2**15 - 1 => 2**15 - 1],
  [2**16 + 2**16 + 2**15 => 2**15],
  [2**16 - 20.0003 => 2**16-21],
  [2**16 - 20.3 => 2**16-21],
  [2**16 - 20.9993 => 2**16-21],
  [nan, p0],
  [pinf, p0],
  [ninf, p0],
  [p0, p0],
  [n0, p0],
) {
  test {
    my $c = shift;
    my $v = to_uint16 $test->[0];
    is $v, $test->[1];
    done $c;
  } n => 1, name => ['ToUInt16(x)', $test->[0]];

  test {
    my $c = shift;
    my $v = to_uint16_pack $test->[0];
    is $v, $test->[1];
    done $c;
  } n => 1, name => ['to_uint16_pack', $test->[0]];

  test {
    my $c = shift;
    my $v = es_to_idl_unsigned_short $test->[0];
    is $v, $test->[1];
    done $c;
  } n => 1, name => ['es_to_idl_unsigned_short', $test->[0]];
}

for my $test (
  [10 => 10],
  [10.1 => 10],
  [10.2 => 10],
  [10.99 => 10],
  [0 => 0],
  [-0.5 => -1],
  [-1 => -1],
  [-120.005 => -121],
  [-120.1 => -121],
  [-120.5 => -121],
  [-120.9 => -121],
  [-120.99 => -121],
) {
  test {
    my $c = shift;
    my $v = floor $test->[0];
    is $v, $test->[1];
    done $c;
  } n => 1, name => ['floor', $test->[0]];
}

for my $test (
  [12 => 12],
  [12.5 => 12],
  [2**31-1 => 2**31-1],
  [2**31 => -2**31],
  [-1 => -1],
  [-10.5 => -10],
  [-20.3 => -20],
  [2**32-1 => -1],
  [2**32 => 0],
  [2**32 + 5 => 5],
  [2**32 + 2**31 - 1 => 2**31 - 1],
  [2**32 + 2**32 + 2**31 => -2**31],
  [2**32 - 20.0003 => -21],
  [2**32 - 20.3 => -21],
  [2**32 - 20.9993 => -21],
  [nan, p0],
  [pinf, p0],
  [ninf, p0],
  [p0, p0],
  [n0, p0],
) {
  test {
    my $c = shift;
    my $v = to_int32 $test->[0];
    is $v, $test->[1];
    done $c;
  } n => 1, name => ['ToInt32(x)', $test->[0]];

  test {
    my $c = shift;
    my $v = to_int32_pack $test->[0];
    is $v, $test->[1];
    done $c;
  } n => 1, name => ['to_int32_pack', $test->[0]];

  test {
    my $c = shift;
    my $v = es_to_idl_long $test->[0];
    is $v, $test->[1];
    done $c;
  } n => 1, name => ['es_to_idl_long', $test->[0]];
}

for my $test (
  [12 => 12],
  [12.5 => 12],
  [2**31-1 => 2**31-1],
  [2**31 => 2**31],
  [-1 => 2**32-1],
  [-10.5 => 2**32-10],
  [-20.3 => 2**32-20],
  [2**32-1 => 2**32-1],
  [2**32 => 0],
  [2**32 + 5 => 5],
  [2**32 + 2**31 - 1 => 2**31 - 1],
  [2**32 + 2**32 + 2**31 => 2**31],
  [2**32 - 20.0003 => 2**32-21],
  [2**32 - 20.3 => 2**32-21],
  [2**32 - 20.9993 => 2**32-21],
  [nan, p0],
  [pinf, p0],
  [ninf, p0],
  [p0, p0],
  [n0, p0],
) {
  test {
    my $c = shift;
    my $v = to_uint32 $test->[0];
    is $v, $test->[1];
    done $c;
  } n => 1, name => ['ToUInt32(x)', $test->[0]];

  test {
    my $c = shift;
    my $v = to_uint32_pack $test->[0];
    is $v, $test->[1];
    done $c;
  } n => 1, name => ['to_uint32_pack', $test->[0]];

  test {
    my $c = shift;
    my $v = es_to_idl_unsigned_long $test->[0];
    is $v, $test->[1];
    done $c;
  } n => 1, name => ['es_to_idl_unsigned_long', $test->[0]];
}

run_tests;
