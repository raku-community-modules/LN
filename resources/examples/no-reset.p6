#!/usr/bin/env raku

use LN 'no-reset';

for lines() {
    .say;
    $*ARGFILES.ln.say;
}
$*ARGFILES.ln.say;
$*LN.say;
IO::CatHandle.new does IO::CatHandle::AutoLines;

