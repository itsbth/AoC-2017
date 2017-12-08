use v6;

grammar code {
  rule TOP { <instr>* }
  token register { <[a..z]>+ }
  token cmp { "<=" || ">=" || "==" || "!=" || "<" || ">" }
  token number { "-"? <[0..9]>+ }
  token op { "inc" || "dec" }
  rule instr { <dest=register> <op> <mod=number> "if" <creg=register> <cmp> <cnum=number> }
}

my %cmp =
  "<=" => &[<=],
  ">=" => &[>=],
  "==" => &[==],
  "!=" => &[!=],
  "<" => &[<],
  ">" => &[>];

my $in = 'input'.IO.slurp;
# my $in = "b inc 5 if a > 1
# a inc 1 if b < 5
# c dec -10 if a >= 1
# c inc -20 if c == 10";

my $code = code.parse: $in;
my %registers is default(0);
my $max = -1;

for $code<instr> -> $instr {
  my $mod = $instr<op> eq "inc" ?? +$instr<mod> !! -$instr<mod>;
  %registers{$instr<dest>} += $mod if %cmp{$instr<cmp>}(%registers{$instr<creg>}, +$instr<cnum>);
  $max = ($max, %registers.values.max).max;
}

say %registers.values.max;
say $max;
