use RakudoPrereq v2017.05.270.g.5227828.a.8,
    'LN module requires Rakudo v2017.06 or newer';
use MONKEY-GUTS;

my constant %valid-opts := set <reset role>;
role IO::CatHandle::AutoLines { … }

sub EXPORT (*@opts) {
    my %opts := set @opts;
    %opts ⊆ %valid-opts or
        die "Unknown option passed to LN module in file"
          ~ " {(try $*W.current_file) // '<unknown file>'}."
          ~ "Valid options are: " ~ %valid-opts.keys.join(", ");

    unless %opts<role> {
        $*ARGFILES does IO::CatHandle::AutoLines[:reset(%opts<reset>)];
        PROCESS::<$LN> := Proxy.new:
            :FETCH{ $*ARGFILES.ln }, :STORE(-> $, $ln { $*ARGFILES.ln = $ln });
    }

    Map.new: 'IO::CatHandle::AutoLines' => IO::CatHandle::AutoLines;
}

my role IO::CatHandle::AutoLines[Bool:D :$reset = True] {
    has Int:D $!ln = 0;
    has &!os-store;

    submethod TWEAK {
        return unless $reset;

        sub reset (|c) {
            dd c;
            $!ln = +?c[1]; nextsame
        }
        my &old-os := nqp::getattr(self, IO::CatHandle, '&!on-switch');
        nqp::bindattr(self, IO::CatHandle, '&!on-switch', Proxy.new:
          :FETCH{ &!os-store },
          :STORE(-> $, &code {
            &!os-store := do if &code {
              $_ = &code.count;
              when 2|Inf { -> \a, \b { reset a, b; code a, b } }
              when 1     { -> \a     { reset a;    code a    } }
              when 0     { ->        { reset;      code      } }
              die "Don't know how to handle on-switch of count $_."
                        ~ " Does IO::CatHandle even support that?"
            }
            else { { reset } }
          }));

        self.on-switch = $_ with &old-os;
    }
    method get { $!ln++; nextsame }
    method lines {
        Seq.new: my class :: does Iterator {
            has $!iter;
            has $!al;
            method !SET-SELF($!iter, $!al) { self }
            method new(\iter, \al) { self.bless!SET-SELF(iter, al) }
            method pull-one {
                $!al.ln++;
                $!iter.pull-one
            }
        }.new: callsame.iterator, self
    }
    method ln is rw {
        Proxy.new:
            :FETCH{ $!ln<> },
            :STORE(-> $, $!ln { $!ln }
        );
    }
}
