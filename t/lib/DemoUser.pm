package DemoUser;

use Pod::ToDemo;

return 1 if defined caller();

Pod::ToDemo::write_file( 'foo', 'here is some text' );
