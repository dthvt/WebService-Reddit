package WebService::Reddit::Builder;

=pod 

Responsible for converting JSON responses into Perl objects.

=cut

use namespace::autoclean;
use Moose;
use MooseX::Types::Moose qw(:all);
use Carp;
use feature 'switch';

sub build {
	my ($self, %args) = @_;
	
	croak "json argument required" unless $args{json};
	
	croak "json does not include kind attribute" unless $args{json}{kind};
	
	given ($args{json}{kind}) {
		when (/^Listing$/) {
			return $self->build_listing(%args);
		}
		when (/^t3$/) {
			return $self->build_link(%args);
		}
		default {
			die "Unknown kind '$_'";
		}
	}
	return;
}

sub build_listing {
	my ($self, %args) = @_;
	
	my $l = WebService::Reddit::Listing->new(
		before => $args{json}{data}{before},
		after => $args{json}{data}{after},
		modhash => $args{json}{data}{modhash},
	);	

	# Process $args->{data}{children}
	foreach (@{$args{json}{data}{children}}) {
		print "Child kind ", $_->{kind}, "\n";
		my $o = $self->build(json => $_);
		push @{$l->children}, $o;
	}
	
	return $l;
}

sub build_link {
	return "blah";
}

__PACKAGE__->meta->make_immutable;
1;