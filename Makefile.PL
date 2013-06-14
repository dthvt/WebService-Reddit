use 5.008008;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'WebService::Reddit',
    VERSION_FROM      => 'lib/WebService/Reddit.pm', # finds $VERSION
    PREREQ_PM         => {
		Moose =>  2.0604,
		namespace::autoclean => 0.13,
	}, # e.g., Module::Name => 1.1
    ($] >= 5.005 ?     ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM  => 'lib/WebService/Reddit.pm', # retrieve abstract from module
       AUTHOR         => 'Daniel Hagan <daniel@kickidle.com>') : ()),
);
