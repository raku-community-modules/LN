use Test; # -*- mode: perl6 -*-

use-ok "LN 'no-reset'";

throws-like {
    EVAL ( " use LN <resetdasdsa>;" );
}, X::AdHoc, message => /"Unknown"/, "Arbitrary options throw";

done-testing;
