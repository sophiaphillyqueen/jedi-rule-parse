use strict;
use argola;
use chobxml02::context;
use me::keytag::root_sect;
use me::spcf::init_function;
use me::spcf::flush_function;
use me::stylish;
use me::language;

my $cntx;

my $srcroot = undef;
my $strdate = undef;
my $styledir = undef;
my $langdir = undef;
my $repetia = 0;

sub opto__src_do {
  $srcroot = &argola::getrg();
} &argola::setopt('-src',\&opto__src_do);

sub opto__styl_do {
  $styledir = &argola::getrg();
} &argola::setopt('-styl',\&opto__styl_do);

sub opto__date_do {
  $strdate = [];
  @$strdate = (&argola::getrg());
  @$strdate = (@$strdate,&argola::getrg());
  @$strdate = (@$strdate,&argola::getrg());
} &argola::setopt('-date',\&opto__date_do);

sub opto__rep_do {
  $repetia = &argola::getrg();
} &argola::setopt('-rep',\&opto__rep_do);

sub opto__lang_do {
  $langdir = &argola::getrg();
} &argola::setopt('-lang',\&opto__lang_do);



&argola::runopts();

if ( !(defined($srcroot) ) )
{
  die "\nFATAL ERROR:\n"
    . "  Please use the -src option to define the root source file.\n"
  ;
}

if ( !(defined($styledir) ) )
{
  die "\nFATAL ERROR:\n"
    . "  Please use the -styl option to define the theme directory.\n"
  ;
}

if ( !(defined($langdir) ) )
{
  die "\nFATAL ERROR:\n"
    . "  Please use the -lang option to define the language-resource directory.\n"
  ;
}

if ( !(defined($strdate) ) )
{
  die "\nFATAL ERROR:\n"
    . "  Please use the -date option to define the cycle start-date.\n"
  ;
}


$cntx = &chobxml02::context::new();
$cntx->tag('sect',&me::keytag::root_sect::tags());
$cntx->initf(\&me::spcf::init_function::ftfunc);
$cntx->flush(\&me::spcf::flush_function::ftfunc);
$cntx->parsefrom($srcroot,{
  'style' => &me::stylish::load($styledir),
  'lang' => &me::language::load($langdir),
  'reps' => $repetia,
  'date' => $strdate,
  'title' => "Untitled Document",
  'ttlopen' => ( 2 > 1 ),
});


