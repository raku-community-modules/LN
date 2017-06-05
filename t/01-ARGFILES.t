use lib <lib>;
use Testo;
use Temp::Path;

plan 9;

is-run ｢use lib <lib>; use LN; print $*ARGFILES.ln｣, 
