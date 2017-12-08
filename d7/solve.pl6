use v6;

class Program {
  has Str $.name;
  has Int $.weight is rw;
  has Program $.parent is rw;
  has Program @.children;

  method total-weight() {
    @.children».total-weight.sum + $.weight;
  }

  method valid() {
    if @.children.elems < 2 {
      return True;
    }
    return [==] @.children».total-weight;
  }
}

my %all;

sub get-program(Str $name) is rw {
  if not %all{$name}:exists {
    %all{$name} = Program.new(:$name);
  }
  return %all{$name};
}

for 'input'.IO.lines {
  when / ^ (\w+) " (" (\d+) ")" [ " -> " (\w+)+ % ", " ]? $ / {
    my $prog = get-program($0.Str);
    $prog.weight = $1.Int;
    for $2 {
      get-program($_.Str).parent = $prog;
    }
    $prog.children = $2.map: { get-program(.Str) };
  }
  die $_;
};

say "digraph \{";
for %all.kv -> $k, $v {
  say "{$v.name} [label=\"{$v.name} ({$v.weight} / {$v.total-weight})\"][fontcolor=\"{$v.valid ?? "green" !! "red"}\"];";
  say "{$v.parent.name} -> {$v.name};" if $v.parent;
}
say "}";

