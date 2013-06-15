package WebService::Reddit::Comment;

=pod

Reddit Comment object.

=cut

use namespace::autoclean;
use Moose;
use MooseX::Types::Moose qw(:all);

use WebService::Reddit::Thing;
use WebService::Reddit::Created;
use WebService::Reddit::Votable;

extends 'WebService::Reddit::Thing';
with 'WebService::Reddit::Created', 'WebService::Reddit::Votable';

has '+kind' => (
	default => 't1',
);

has 'approved_by' => (
	is => 'rw',
	isa => Str,
);

has 'author' => (
	is => 'rw',
	isa => Str,
);

has 'author_flair_css_class' => (
	is => 'rw',
	isa => Str,
);

has 'author_flair_text' => (
	is => 'rw',
	isa => Str,
);

has 'banned_by' => (
	is => 'rw',
	isa => Str,
);

has 'body' => (
	is => 'rw',
	isa => Str,
);

has 'body_html' => (
	is => 'rw',
	isa => Str,
);

has 'edited' => (
	is => 'rw',
	isa => Int,
);

has 'gilded' => (
	is => 'rw',
	isa => Str,
);

has 'link_id' => (
	is => 'rw',
	isa => Str,
);

has 'link_title' => (
	is => 'rw',
	isa => Str,
);

has 'num_reports' => (
	is => 'rw',
	isa => Str,
);

has 'parent_id' => (
	is => 'rw',
	isa => Str,
);

has 'score_hidden' => (
	is => 'rw',
	isa => Bool,
);

has 'subreddit' => (
	is => 'rw',
	isa => Str,
);

has 'subreddit_id' => (
	is => 'rw',
	isa => Str,
);

has 'distinguished' => (
	is => 'rw',
	isa => Str,
);

__PACKAGE__->meta->make_immutable;
1;
