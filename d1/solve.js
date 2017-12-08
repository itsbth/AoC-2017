const R = require("ramda");
const fs = require("fs");

/*
    1122 produces a sum of 3 (1 + 2) because the first digit (1) matches the second digit and the third digit (2) matches the fourth digit.
    1111 produces 4 because each digit (all 1) matches the next.
    1234 produces 0 because no digit matches the next.
    91212129 produces 9 because the only digit that matches the next one is the last digit, 9.
 */

const t = ["1122", "1111", "1234", "91212129"];

const solve = R.compose(
  R.sum, // find the sum
  R.map(R.head), // discard the second (identical) number
  R.filter(R.apply(R.equals)), // filter out non-matching number
  R.aperture(2), // convert to pairs
  R.converge(R.append, [R.head, R.identity]), // append first number
  R.map(parseInt),
  R.split(""),
  R.trim,
);

// const solve2 = R.pipe(
//   R.trim,
//   R.split(""),
//   R.map(parseInt),
//   R.addIndex(R.chain)(R.pipe()),
// );

// for (const test of t) {
//   console.log(`solve(${test}) = ${solve(test)}`);
// }

console.log(`Solution: ${solve(fs.readFileSync("input", "utf8"))}`);
