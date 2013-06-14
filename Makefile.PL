use 5.016002;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'WebService::Reddit',
    VERSION_FROM      => 'lib/WebService/Reddit.pm', # finds $VERSION
    PREREQ_PM         => {}, # e.g., Module::Name => 1.1
    ($] >= 5.005 ?     ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM  => 'lib/WebService/Reddit.pm', # retrieve abstract from module
       AUTHOR         => 'A. U. Thor <a.u.thor@a.galaxy.far.far.away>') : ()),
);