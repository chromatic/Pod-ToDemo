use Module::Build;

use strict;

my $build = Module::Build->new(
	module_name => 'Pod::ToDemo',
	license     => 'perl',
	sign        => 1,
	requires    =>
	{
		'Test::Exception'  => '',
		'Test::Simple'     => '0.47',
	},
	dist_version_from  => 'lib/Pod/ToDemo.pm',
	create_makefile_pl => 'traditional',
);

$build->create_build_script;
