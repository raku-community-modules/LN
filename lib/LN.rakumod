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

=begin pod

=head1 NAME

LN - Get $*ARGFILES with line numbers via $*LN

=head1 SYNOPSIS

=begin code :lang<bash>

perl  -wlnE   'say "$.:$_"; close ARGV if eof' foo bar # Perl
raku -MLN -ne 'say "$*LN:$_"'                  foo bar # Raku

=end code

=begin code :lang<bash>

$ echo -e "a\nb\nc" > foo
$ echo -e "d\ne"    > bar

$ raku -MLN -ne 'say "$*LN:$_"' foo bar
1:a
2:b
3:c
1:d
2:e

$ raku -ne 'use LN "no-reset"; say "$*LN:$_"' foo bar
1:a
2:b
3:c
4:d
5:e

=end code

=head1 DESCRIPTION

Mixes in
L<C<IO::CatHandle::AutoLines>|https://raku.land/zef:raku-community-modules/IO::CatHandle::AutoLines)>
into L<C<$*ARGFILES>|https://docs.perl6.org/language/variables#index-entry-%24%2AARGFILES>
which provides an C<.ln> method containing current line number of the
current handle (or total line number if C<'no-reset'> option was passed
to C<use>). For ease of access to that method C<$*LN> dynamic variable
containing its value is available.

=head1 EXPORTED TERMS

=head2 $*LN

Contains same value as L<C<$*ARGFILES.ln>https://raku.land/zef:raku-community-modules/IO::CatHandle::AutoLines#synopsis>|
which is a method exported by
L<C<IO::CatHandle::AutoLines>|https://raku.land/zef:raku-community-modules/IO::CatHandle::AutoLines>
that gives the current line number of the handle.

By default, the line number will get reset on each new file in
C<$*ARGFILES>.  If you wish it to I<not> reset, pass C<"no-reset">
positional argument to the C<use> line:

=begin code :lang<raku>

use LN 'no-reset';

=head1 EXPORTED TYPES

=head2 role IO::CatHandle::AutoLines

Exports L<C<IO::CatHandle::AutoLines>|https://raku.land/zef:raku-community-modules/IO::CatHandle::AutoLines>
role, for you to use, if needed.

=end code

=head1 AUTHOR

Zoffix Znet

=head1 COPYRIGHT AND LICENSE

Copyright 2017 Zoffix Znet

Copyright 2018 - 2022 Raku Community

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod

# vim: expandtab shiftwidth=4
