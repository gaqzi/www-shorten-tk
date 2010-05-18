use ExtUtils::MakeMaker;

WriteMakefile(
    NAME            => 'WWW::Shorten::TK',
    VERSION_FROM    => 'lib/WWW/Shorten/TK.pm',
    PREREQ_PM       => { WWW::Shorten => 1.97 },
    # following keywords are supported from 5.005
    ($] >= 5.005 ?
        (ABSTRACT_FROM  => 'lib/WWW/Shorten/TK.pm',
         AUTHOR         => 'Björn Andersson <ba@sanitarium.se>') : ())
);

