package WebService::Reddit::Thing;

=pod

Base class for most Reddit objects.

=cut

use namespace::autoclean;
use Moose;
use MooseX::Types::Moose qw(:all);

has 'id' => (
	is => 'rw',
	isa => Str,
);

has 'name' => (
	is => 'rw',
	isa => Str,
);

has 'kind' => (
	is => 'rw',
	isa => Str,
);

# Used to store a reference to the WebService::Reddit object that owns this Thing.
has '_session' => (
	is => 'rw',
	isa => Maybe[Ref],
);

__PACKAGE__->meta->make_immutable;
1;
