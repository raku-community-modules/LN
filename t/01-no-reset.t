use lib <lib>; # -*- perl6-mode 
use Testo;
use Temp::Path;

plan 1;

my @FILES = make-temp-path :content("a\nb\n"    ),
            make-temp-path :content("c\nd\ne\nf"),
            make-temp-path :content("g\nh\ni"   );

my $executable-path = "resources/examples/no-reset.p6".IO.e
                      ?? "resources/examples/no-reset.p6"
                      !! "../resources/examples/no-reset.p6";

is-run $*EXECUTABLE, :args[
    '-Ilib', $executable-path, |@FILES
], :out("a\n1\nb\n2\nc\n3\nd\n4\ne\n5\nf\n6\ng\n7\nh\n8\ni\n9\n0\n0\n"),
   'reset on use line';

