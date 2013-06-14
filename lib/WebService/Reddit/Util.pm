package WebService::Reddit::Util;

use Exporter;

use constant API_BASE => 'http://www.reddit.com';


our @ISA = qw(Exporter);
our %EXPORT_TAGS = ( 'all' => [ qw(
	API_BASE
) ] );
our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );
our @EXPORT = qw();

1;