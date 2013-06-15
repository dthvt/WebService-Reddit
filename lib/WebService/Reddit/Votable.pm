package WebService::Reddit::Votable;

=pod 

Implements the Reddit Votable interface.

=cut

use namespace::autoclean;
use Moose::Role;
use MooseX::Types::Moose qw(:all);

has 'ups' => (
	is => 'rw',
	isa => Int,
);

has 'downs' => (
	is => 'rw',
	isa => Int,
);

has 'likes' => (
	is => 'rw',
	isa => Bool,
);

# Can't immutable Roles.
#__PACKAGE__->meta->make_immutable;
1;