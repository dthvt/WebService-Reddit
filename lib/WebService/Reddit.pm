package WebService::Reddit;

use 5.008008;
use strict;
use warnings;

use namespace::autoclean;
use Moose;
use WebService::Reddit::API;
use WebService::Reddit::Listing;
use Carp;

# Semantic versioning rules apply.
our $VERSION = '0.01.01';

has '_api' => (
	is => 'rw',
	isa => 'WebService::Reddit::API',
	default => sub { WebService::Reddit::API->new },
);

has 'builder' => (
	is => 'ro',
	isa => 'WebService::Reddit::Builder',
	default => sub { WebService::Reddit::Builder->new },
);

sub comments {
	my ($self, $id, %args) = @_;
	
	my $data = $self->_api->comments($id, %args);
	
	return $self->builder->build(json => $data);
}

sub controversial {
	my ($self, %args) = @_;
	
	my $data = $self->_api->controversial(%args);
	
	return $self->builder->build(json => $data);
}

sub hot {
	my ($self, %args) = @_;
	
	my $data = $self->_api->hot(%args);
	
	return $self->builder->build(json => $data);
}

sub top {
	my ($self, %args) = @_;
	
	my $data = $self->_api->top(%args);
	
	return $self->builder->build(json => $data);
}
	

sub login {
	my ($self, %args) = @_;
	
	croak "username required" unless $args{username};
	croak "password required" unless $args{password};
	
}

__PACKAGE__->meta->make_immutable;
1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

WebService::Reddit - Perl extension for blah blah blah

=head1 SYNOPSIS

  use WebService::Reddit;
  blah blah blah

=head1 DESCRIPTION

Stub documentation for WebService::Reddit, created by h2xs. It looks like the
author of the extension was negligent enough to leave the stub
unedited.

Blah blah blah.

=head2 EXPORT

None by default.



=head1 SEE ALSO

Mention other useful documentation such as the documentation of
related modules or operating system documentation (such as man pages
in UNIX), or any relevant external documentation such as RFCs or
standards.

If you have a mailing list set up for your module, mention it here.

If you have a web site set up for your module, mention it here.

=head1 AUTHOR

A. U. Thor, E<lt>a.u.thor@a.galaxy.far.far.awayE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2013 by A. U. Thor

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.16.2 or,
at your option, any later version of Perl 5 you may have available.


=cut
