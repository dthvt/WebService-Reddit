package WebService::Reddit::Builder;

=pod 

Responsible for converting JSON responses into Perl objects.

=cut

use namespace::autoclean;
use Moose;
use MooseX::Types::Moose qw(:all);
use Carp;
use feature 'switch';

use Data::Dumper qw(Dumper);

use WebService::Reddit::Listing;
use WebService::Reddit::Link;

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
	my ($self, %args) = @_;
	
	my $l = WebService::Reddit::Link->new;

	foreach my $name (keys %{$args{json}{data}}) {
		if ($l->can($name)) {
			
			# Have to handle bools special because on JSON encoding.
			if (JSON::is_bool($args{json}{data}{$name})) {
				$l->$name(($args{json}{data}{$name} eq JSON::true) ? 1 : 0);
			}
			elsif (defined $args{json}{data}{$name}) {
				$l->$name($args{json}{data}{$name});
			}
			else {
				print "Building link, skipping undefined data name $name\n";
			}
		}
		else {
			print "Building link, found unknown data name $name\n";
			#print Dumper ($args{json}{data}{$name});
		}
	}
	
	return $l;
}

__PACKAGE__->meta->make_immutable;
1;