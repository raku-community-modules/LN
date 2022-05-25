[![Actions Status](https://github.com/raku-community-modules/LN/actions/workflows/test.yml/badge.svg)](https://github.com/raku-community-modules/LN/actions)

NAME
====

LN - Get $*ARGFILES with line numbers via $*LN

SYNOPSIS
========

```bash
perl  -wlnE   'say "$.:$_"; close ARGV if eof' foo bar # Perl
raku -MLN -ne 'say "$*LN:$_"'                  foo bar # Raku
```

```bash
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
```

DESCRIPTION
===========

Mixes in [`IO::CatHandle::AutoLines`](https://raku.land/zef:raku-community-modules/IO::CatHandle::AutoLines)) into [`$*ARGFILES`](https://docs.perl6.org/language/variables#index-entry-%24%2AARGFILES) which provides an `.ln` method containing current line number of the current handle (or total line number if `'no-reset'` option was passed to `use`). For ease of access to that method `$*LN` dynamic variable containing its value is available.

EXPORTED TERMS
==============

$*LN
----

Contains same value as [`$*ARGFILES.ln`https://raku.land/zef:raku-community-modules/IO::CatHandle::AutoLines#synopsis](`$*ARGFILES.ln`https://raku.land/zef:raku-community-modules/IO::CatHandle::AutoLines#synopsis)| which is a method exported by [`IO::CatHandle::AutoLines`](https://raku.land/zef:raku-community-modules/IO::CatHandle::AutoLines) that gives the current line number of the handle.

By default, the line number will get reset on each new file in `$*ARGFILES`. If you wish it to *not* reset, pass `"no-reset"` positional argument to the `use` line:

```raku
use LN 'no-reset';

=head1 EXPORTED TYPES

=head2 role IO::CatHandle::AutoLines

Exports L<C<IO::CatHandle::AutoLines>|https://raku.land/zef:raku-community-modules/IO::CatHandle::AutoLines>
role, for you to use, if needed.
```

AUTHOR
======

Zoffix Znet

COPYRIGHT AND LICENSE
=====================

Copyright 2017 Zoffix Znet

Copyright 2018 - 2022 Raku Community

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

