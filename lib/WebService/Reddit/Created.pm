package WebService::Reddit::Created;

=pod 

Implements the Reddit Created interface.

=cut

use namespace::autoclean;
use Moose::Role;
use MooseX::Types::Moose qw(:all);

has 'created' => (
	is => 'rw',
	isa => Int,
);

has 'created_utc' => (
	is => 'rw',
	isa => Int,
);

1;