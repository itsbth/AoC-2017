use v6;

constant @input = 'input'.IO.slurp.words».Int.Array;
# constant @input = (0, 2, 7, 0);

sub redistribute-pages(@input is copy) {
  my $midx = @input.maxpairs.first.key;
  my $to-redist = @input[$midx];
  @input[$midx] = 0;
  my $each = $to-redist div +@input;
  my $rem = $to-redist mod +@input;
  @input »+=» $each;
  my @off = (($midx + 1) .. ($midx + $rem)) »mod» +@input;
  @input[@off] »+=» 1;

  @input;
}

my $seen = SetHash.new;
my $arr = @input;

until $arr.join('-') ∈ $seen {
  $seen{$arr.join('-')} = True;
  $arr = redistribute-pages($arr);
}
say "part 1: {+$seen}";

my $key = $arr.join('-');
my $iterations = 0;
repeat {
  $seen{$arr.join('-')} = True;
  $arr = redistribute-pages($arr);
  $iterations++;
} until $arr.join('-') eqv $key;

say "part 2: $iterations";
