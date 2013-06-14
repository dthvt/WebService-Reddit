package WebService::Reddit::Link;

use namespace::autoclean;
use Moose;
use MooseX::Types::Moose qw(:all);

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

has 'clicked' => (
	is => 'rw',
	isa => Bool,
);

has 'domain' => (
	is => 'rw',
	isa => Str,
);

has 'hidden' => (
	is => 'rw',
	isa => Bool,
);

has 'is_self' => (
	is => 'rw',
	isa => Bool,
);

has 'likes' => (
	is => 'rw',
	isa => Bool,
);

has 'link_flair_css_class' => (
	is => 'rw',
	isa => Str,
);

has 'link_flair_text' => (
	is => 'rw',
	isa => Str,
);

has 'media' => (
	is => 'rw',
	isa => Ref,
);

has 'media_embed' => (
	is => 'rw',
	isa => Ref,
);

has 'num_comments' => (
	is => 'rw',
	isa => Int,
);

has 'over_18' => (
	is => 'rw',
	isa => Bool,
);

has 'permalink' => (
	is => 'rw',
	isa => Str,
);

has 'saved' => (
	is => 'rw',
	isa => Bool,
);

has 'score' => (
	is => 'rw',
	isa => Int,
);

has 'selftext' => (
	is => 'rw',
	isa => Str,
);

has 'selftext_html' => (
	is => 'rw',
	isa => Str,
);

has 'subreddit' => (
	is => 'rw',
	isa => Str,
);

has 'subreddit_id' => (
	is => 'rw',
	isa => Str,
);

has 'thumbnail' => (
	is => 'rw',
	isa => Str,
);

has 'title' => (
	is => 'rw',
	isa => Str,
);

has 'url' => (
	is => 'rw',
	isa => Str,
);

has 'edited' => (
	is => 'rw',
	isa => Int,
);

has 'distinguised' => (
	is => 'rw',
	isa => Str,
);

sub BUILD {
	my ($self, $args) = @_;
	
}

__PACKAGE__->meta->make_immutable;
1;
