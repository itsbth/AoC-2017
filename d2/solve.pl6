my $contents = 'input'.IO.lines;

my $sheet = $contents.map({ .split(/\t+/)>>.Int });

my $result = $sheet.map({
  [/](
    .combinations(2)
    .map({
      (.max, .min)
    })
    .grep({
      .first %% .tail
    })
    .first
  )
}).sum;

say $result;
