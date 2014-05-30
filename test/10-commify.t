use Mojo::Base -strict;
use Test::More;

use Mojolicious;
use Mojolicious::Plugin::Number::Commify;

my $app = Mojolicious->new->secrets(['x']);
my $plugin = Mojolicious::Plugin::Number::Commify->new;

# English
$plugin->register($app => {});

is $app->commify(0), '0', 'no comma';
is $app->commify(123), '123', 'no comma';
is $app->commify(1234), '1,234', 'first comma';

# some non-English, but not Indian, etc
$plugin->register($app => {separator => '.'});

is $app->commify(0), '0', 'no separator';
is $app->commify(123), '123', 'no separator';
isnt $app->commify(1234), '1,234', 'no comma';
is $app->commify(1234), '1.234', 'first separator';

done_testing();
