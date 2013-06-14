package WebService::Reddit::API;

use namespace::autoclean;
use Moose;
use LWP::UserAgent;
use JSON;
use HTTP::Cookies;
use HTTP::Request;

my $base = 'http://www.reddit.com';
my %api = (
	CLEAR_SESSIONS => ['GET', '/api/clear_sessions'],
	
	TOP => ['GET', '/top.json'],
	
);
	

has '_ua' => (
	is => 'rw',
	isa => 'LWP::UserAgent',
	default => sub { LWP::UserAgent->new },
	handles => {
		post => 'post',
		get => 'get',
		cookie_jar => 'cookie_jar',
	}
);



sub clear_sessions {
	my ($self, %args) = @_;
	
}

sub top {
	my ($self, %args) = @_;
	
	my $query = join('&', map { "$_" . "=" . $args{$_} } keys %args);
	
	my $target = $base . $api{TOP}[1] . "?" . $query;
	
	print "API request: $target\n";
	
	my $response = $self->_ua->request(HTTP::Request->new($api{TOP}[0] => $target));
	
	my $data = decode_json($response->content);
	
	return $data;
}
	
	
__PACKAGE__->meta->make_immutable;
1;	