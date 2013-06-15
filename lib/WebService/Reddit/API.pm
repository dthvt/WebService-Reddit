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
	my ($self, $api_tag, %args) = @_;
	
	my $query = join('&', map { $_ . "=" . $args{$_} } keys %args);
	
	my $target = $base . $api{$api_tag} . "?" . $query;
	
	print "API GET request: $target\n";
	
	my $response = $self->_ua->request(
		HTTP::Request->new('GET' => $target)
	);
	
	my $data = decode_json($response->content);
	
	return $data;
}

sub top {
	my ($self, %args) = @_;
	return $self->GET('TOP', %args);
}
	
	
__PACKAGE__->meta->make_immutable;
1;	