use IO::CatHandle::AutoLines;

my constant %valid-opts := set <no-reset>;

sub EXPORT (*@opts) {
    my %opts := set @opts;
    %opts ⊆ %valid-opts
        or die "Unknown option passed to LN module in file"
          ~ " {(try $*W.current_file) // '<unknown file>'}."
          ~ "Valid options are: " ~ %valid-opts.keys.join(", ");

    $*ARGFILES does IO::CatHandle::AutoLines[:reset(not %opts<no-reset>), :LN];

    Map.new: 'IO::CatHandle::AutoLines' => IO::CatHandle::AutoLines
}
