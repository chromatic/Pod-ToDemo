package Pod::ToDemo;

use strict;

use vars '$VERSION';
$VERSION = '0.10';

sub write_demo
{
	my ($filename, $demo) = @_;
	my $caller_package    = (caller())[0];

	die "Usage:\n\t$0 $caller_package <filename>\n"    unless $filename;
	die "Cowardly refusing to overwrite '$filename'\n" if  -e $filename;

	open( my $out, '>', $filename ) or die "Cannot write '$filename': $!\n";
	print $out $demo;
}

1;
__END__

=head1 NAME

Pod::ToDemo - writes a demo program from a tutorial POD

=head1 SYNOPSIS

	use Pod::ToDemo;

	# write nothing unless used directly
	return 1 if defined caller();

	Pod::ToDemo::write_demo( shift( @ARGV ), "#!$^X\n" . <<'END_HERE');

	use strict;
	use warnings;

	print "Hi, here is my demo program!\n";
	END_HERE

=head1 DESCRIPTION

Pod::ToDemo allows you to write POD-only modules that serve as tutorials which
can write out demo programs if they're invoked directly.  That is, while
L<SDL::Tutorial> is a tutorial on writing beginner SDL applications with Perl,
you can invoke it as:

	$ perl -MSDL::Tutorial sdl_demo.pl

and it will write a bare-bones demo program called C<sdl_demo.pl>, based on the
tutorial.

=head1 USAGE

Call C<Pod::ToDemo::write_demo()> with two arguments.  C<$filename> is the name
of the file to write.  If there's no name, this function will C<die()> with an
error message.  If a file already exists with this name, this function will
also C<die()> with another error message.  The second argument, C<$demo>, is
the text of the demo program to write.

If you're using this in tutorial modules, as you should be, you will probably
want to protect programs that inadvertently use the tutorial from attempting to
write demo files.  That's what these two lines do:

	# write nothing unless used directly
	return 1 if defined caller();

If there's a defined caller, this module has been used from another module.
The demo file will only be written if the module has been used directly.  Note
that the returned value here will be taken as the return value of the module --
it must be true or the caller's C<use()> will fail!

=head1 AUTHOR

chromatic, E<lt>chromatic@wgz.orgE<gt>

=head1 BUGS

No known bugs.

=head1 COPYRIGHT

Copyright (c) 2003, chromatic.  All rights reserved.  This module is
distributed under the same terms as Perl itself, in the hope that it is useful
but certainly under no guarantee.
