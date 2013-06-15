package WebService::Reddit::More;

use namespace::autoclean;
use Moose;
use MooseX::Types::Moose qw(:all);

use WebService::Reddit::Thing;

extends 'WebService::Reddit::Thing';

has '+kind' => (
	default => 'more',
);

has 'parent_id' => (
	is => 'rw',
	isa => Str,
);

has 'count' => (
	is => 'rw',
	isa => Int,
);

has 'children' => (
	is => 'rw',
	isa => ArrayRef,
	default => sub { [] },
);


__PACKAGE__->meta->make_immutable;
1;
