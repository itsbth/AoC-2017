use v6;

enum Direction <N E S W>;

class Turtle {
  my Direction $.dir = E;
  my Int $.x = 0;
  my Int $.y = 0;

  method pos() {
    return ($.x + 0, $.y + 0);
  }

  method advance() {
    given $.dir {
      when N {
        $.y -= 1;
      }
      when S {
        $.y += 1;
      }
      when W {
        $.x -= 1;
      }
      when E {
        $.x += 1;
      }
    }
    return $.pos;
  }

  method cw() {
    my %rot = N => E, E => S, S => W, W => N;
    $.dir = %rot{$.dir};
  }
  method ccw() {
    $.cw; $.cw; $.cw; # what?
  }
}

my $target = 'input'.IO.slurp.Int;

sub spiral() { 
  my $turtle = Turtle.new(dir => E);
  my $l = 1;
  take $turtle.pos;
  loop {
    for ^$l {
      take $turtle.advance;
    }
    $turtle.ccw;
    for ^$l {
      take $turtle.advance;
    }
    $turtle.ccw;
    $l += 1;
  }
}

# my @a;

# try {
#   my $i = 1;
#   for gather spiral() -> ($x, $y) {
#     @a[$x + 10][$y + 10] = $i++;
#   }
#   CATCH {
#     for ^20 -> $x {
#       say @a[$x].join("\t");
#     }
#   }
# }
say (gather spiral())[368078 - 1]».abs.sum; exit;

my %board is default(0);

sub neighbours($x, $y) {
  return [+] do for (-1 .. 1) -> $sx {
    do for (-1 .. 1) -> $sy {
      %board{$($x + $sx, $y + $sy)}
    }
  }.flat;
}

sub dump(%board) {
  for ^10 -> $y {
    my @line;
    for ^10 -> $x {
      @line.push(%board{$($x - 5, $y - 5)});
    }
    say @line.join("\t");
  }
}

%board{$(0, 0)} = 1;

for gather spiral() -> ($x, $y) {
  %board{$($x, $y)} = neighbours($x, $y);
  if %board{$($x, $y)} > 368078 {
    dump(%board);
    say %board{$($x, $y)};
    exit;
  }
}
