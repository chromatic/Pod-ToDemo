#!/usr/bin/perl -w

BEGIN
{
	chdir 't' if -d 't';
	use lib '../lib', '../blib/lib', 'lib';
}

use strict;

use Test::More tests => 7;
use Test::Exception;

BEGIN
{
	1 while unlink( 'foo', 'bar' );
}

my $module = 'Pod::ToDemo';
use_ok( $module ) or exit;

throws_ok { Pod::ToDemo::write_demo() } qr/^Usage:/,
	'write_demo() should die with Usage error without a filename';

throws_ok { Pod::ToDemo::write_demo( 'base.t' ) }
	qr/Cowardly refusing to overwrite 'base.t'/,
	'... or with overwriting error if destination file exists';

Pod::ToDemo::write_demo( 'bar', 'here is more text' );
ok( -e 'bar', '... and should write file if everything is sane' );

open( my $file, 'bar' ) or die "Cannot read demo file: $!\n";
my $text = do { local $/; <$file> };
is( $text, 'here is more text', '... writing demo file accurately' );

use_ok( 'DemoUser' );
ok( ! -e 'foo',
	'defined caller() check should protect against accidental usage' );
