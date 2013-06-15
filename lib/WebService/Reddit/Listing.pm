package WebService::Reddit::Listing;

use namespace::autoclean;
use Moose;
use MooseX::Types::Moose qw/:all/;
use WebService::Reddit::Builder;

use Data::Dumper qw(Dumper);

has 'kind' => (
	is => 'ro',
	isa => Str,
	default => 'Listing',
);

has 'before' => (
	is => 'ro',
	isa => Maybe[Str],
);

has 'after' => (
	is => 'ro',
	isa => Maybe[Str],
);

has 'modhash' => (
	is => 'ro',
	isa => Str,
);

has 'children' => (
	is => 'rw',
	isa => ArrayRef,
	default => sub { [] },
);

__PACKAGE__->meta->make_immutable;
1;
