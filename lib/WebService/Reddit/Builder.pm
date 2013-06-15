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

use WebService::Reddit::Comment;
use WebService::Reddit::Link;
use WebService::Reddit::Listing;
use WebService::Reddit::More;

sub build {
	my ($self, %args) = @_;
	
	croak "json argument required" unless $args{json};
	
	if (ref $args{json} eq "HASH") {
		croak "json does not include kind attribute" unless $args{json}{kind};
	
		given ($args{json}{kind}) {
			when (/^Listing$/) {
				return $self->build_listing(%args);
			}
			when (/^more$/) {
				return $self->build_more(%args);
			}
			when (/^t1$/) {
				return $self->build_comment(%args);
			}
			when (/^t3$/) {
				return $self->build_link(%args);
			}
			default {
				die "Unknown kind '$_'";
			}
		}
	}
	elsif (ref $args{json} eq "ARRAY") {
		return [map { $self->build(json => $_) } @{$args{json}}];
	}
	return;
}

sub build_comment {
	my ($self, %args) = @_;
	
	my $c = WebService::Reddit::Comment->new;
	
	foreach my $name (keys %{$args{json}{data}}) {
		if ($c->can($name)) {
			
			# Have to handle bools special because on JSON encoding.
			if (JSON::is_bool($args{json}{data}{$name})) {
				$c->$name(($args{json}{data}{$name} eq JSON::true) ? 1 : 0);
			}
			elsif (defined $args{json}{data}{$name}) {
				$c->$name($args{json}{data}{$name});
			}
			else {
				print "Building comment, skipping undefined data name $name\n";
			}
		}
		else {
			print "Building comment, found unknown data name $name\n";
			#print Dumper ($args{json}{data}{$name});
		}
	}
		
	return $c;
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

sub build_more {
	my ($self, %args) = @_;
	
	my $o = WebService::Reddit::More->new;
	
	foreach my $name (keys %{$args{json}{data}}) {
		if ($o->can($name)) {
			
			# Have to handle bools special because on JSON encoding.
			if (JSON::is_bool($args{json}{data}{$name})) {
				$o->$name(($args{json}{data}{$name} eq JSON::true) ? 1 : 0);
			}
			elsif (defined $args{json}{data}{$name}) {
				$o->$name($args{json}{data}{$name});
			}
			else {
				print "Building more, skipping undefined data name $name\n";
			}
		}
		else {
			print "Building more, found unknown data name $name\n";
			#print Dumper ($args{json}{data}{$name});
		}
	}
	return $o;
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