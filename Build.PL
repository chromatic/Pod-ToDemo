use Module::Build;

my $build = Module::Build->new(
	module_name => 'Pod::ToDemo',
	license     => 'perl',
	requires    => {
		Test::Exception  => '',
		Test::Simple     => '0.47',
	},
	dist_version_from => 'lib/Pod/ToDemo.pm',
);

$build->create_build_script;
