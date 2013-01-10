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
  [2**32 - 20.3 => -21],
) {
  test {
    my $c = shift;

    my $v = idl_long_to_es_long $test->[0];
    is $v, $test->[1];
    
    done $c;
  } n => 1, name => ['idl_long_to_es_long', $test->[0]];
}

run_tests;
