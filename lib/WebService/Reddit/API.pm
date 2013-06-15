package WebService::Reddit::API;

use namespace::autoclean;
use Moose;
use LWP::UserAgent;
use JSON;
use HTTP::Cookies;
use HTTP::Request;

my $base = 'http://www.reddit.com';
my %api = (
	CLEAR_SESSIONS => '/api/clear_sessions',
	
	COMMENTS => '/comments/%s.json',
	CONTROVERSIAL => '/controversial.json',
	HOT => '/hot.json',
	NEW => '/new.json',
	RANDOM => '/random.json',
	TOP => '/top.json',
	
);
	

has '_ua' => (
	is => 'rw',
	isa => 'LWP::UserAgent',
	default => sub { LWP::UserAgent->new },
	handles => {
		#post => 'post',
		#get => 'get',
		cookie_jar => 'cookie_jar',
	}
);

#
# GET
#
# Takes an %api identifier and args, builds a query string, performs a GET,
# then decodes the response as JSON and returns the resulting perl structure.
#
sub GET {
	my ($self, $api_tag, $api_args, %args) = @_;
	
	my $query = join('&', map { $_ . "=" . $args{$_} } keys %args);
	
	my $target = $base . (sprintf $api{$api_tag}, @$api_args) . "?" . $query;
	
	print "API GET request: $target\n";
	
	my $response = $self->_ua->request(
		HTTP::Request->new('GET' => $target)
	);
	
	my $data = decode_json($response->content);
	
	return $data;
}

# GET methods with zero API arguments - added via introspection
foreach my $fn_name (qw(
	controversial 
	hot
	top
)) {
	my $m = Class::MOP::Method->wrap(
			sub{
				my ($self, %args) = @_;
				return $self->GET(uc($fn_name), [], %args);
			},
			name => $fn_name,
			package_name => __PACKAGE__,
			associated_metaclass => __PACKAGE__->meta,
	);
	__PACKAGE__->meta->add_method($fn_name, $m);
}

# GET methods with one API argument - added via introspection
foreach my $fn_name (qw(
	comments
)) {
	my $m = Class::MOP::Method->wrap(
			sub{
				my ($self, $a, %args) = @_;
				return $self->GET(uc($fn_name), [$a], %args);
			},
			name => $fn_name,
			package_name => __PACKAGE__,
			associated_metaclass => __PACKAGE__->meta,
	);
	__PACKAGE__->meta->add_method($fn_name, $m);
}

__PACKAGE__->meta->make_immutable;
1;	