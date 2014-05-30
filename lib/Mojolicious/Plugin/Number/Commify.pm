package Mojolicious::Plugin::Number::Commify;
use Mojo::Base 'Mojolicious::Plugin';

our $VERSION = 0.011;

sub register {
  my ($self, $app, $cfg) = @_;
  $app->helper(commify => sub {
    my ($self, $number) = @_;
    $number =~ s/(
      ^[-+]?  # beginning of number.
      \d+?    # first digits before first comma
      (?=     # followed by, (but not included in the match) :
        (?>(?:\d{3})+) # some positive multiple of three digits.
        (?!\d)         # an *exact* multiple, not x * 3 + 1 or whatever.
      )
      |       # or:
      \G\d{3} # after the last group, get three digits
      (?=\d)  # but they have to have more digits after them.
    )/$1,/xg;
    $number;
  });
}

1;
__END__

=head1 NAME

Mojolicious::Plugin::Number::Commify - Numbers 1,000,000 times more readable

=head1 SYNOPSIS

  # Mojolicious
  $self->plugin('Number::Commify');

  # Mojolicious::Lite
  plugin 'Number::Commify';

=head1 DESCRIPTION

Mojolicious::Plugin::Number::Commify is a L<Mojolicious> plugin for putting
commas into big numbers.  Sometimes this is 1,000,000 times better than letting
the reader try to parse it.

=head1 USAGE

=head1 METHODS

L<Mojolicious::Plugin::Number::Commify> inherits all methods from
L<Mojolicious::Plugin>.

=head2 register

  $plugin->register(Mojolicious->new);

Register plugin in L<Mojolicious> application.

=head1 RATIONALE

It's often useful to have access to a commify function in views, so an easily
accessible helper is in order.

=head1 COPYRIGHT AND LICENSE

Copyright (C) Benjamin Goldberg, Nic Sandfield

This program is free software, you can redistribute it and/or modify it under
the terms of the Artistic License version 2.0.

=head1 SEE ALSO

L<perlfaq5>, L<Mojolicious::Guides>.