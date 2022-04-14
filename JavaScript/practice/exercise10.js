/* 1. 등차수열의 항 찾기 */

// user code
/*
function answer(a, d, n) {
  let index = -1;
  let s = 0;
  for (i = 1; s < n; i++) {
    if (i == 1) {
      s += a;
    } else {
      s += d;
    }
    if (s == n) index = i;
  }
  return index;
}
*/
/*
function answer(a, d, n) {
  let index = -1;
  let num;

  for (let i = 1; ; i++) {
    num = a + d * (i-1);
    if (num > n) {
      index = -1;
      break;
    }
    if (num == n) {
      index = i;
      break;
    }
  }
  return index;
}
*/
/*
function answer(a, d, n) {
  let index = -1;

  if ((n - a) % d == 0) {
    index = (n - a) / d + 1;
  } else index = -1;

  return index;
}

// main code
let input = [
  // TC: 1
  [1, 2, 7],
  // TC: 2
  [2, 3, 10],
  // TC: 3
  [3, 5, 23],
];

for (let i = 0; i < input.length; i++) {
  console.log(`#${i + 1} ${answer(input[i][0], input[i][1], input[i][2])}`);
}
*/
/* 2. 잃어버린 카드 찾기 */

// user code
/* 
function answer(a, b, c) {
  let number = 0;

  // sort
  num = [a, b, c];
  num.sort((x, y) => x - y);

  let d;
  if (num[2] - num[1] < num[1] - num[0]) {
    d = num[2] - num[1];
    number = num[0] + d;
  } else {
    d = num[1] - num[0];
    number = num[1] + d;
  }
  return number;
}
*/
/*
function answer(a, b, c) {
  let number = 0;

  // sort
  num = [a, b, c];
  num.sort((x, y) => x - y);

  let d = 0;
  for (let i = 1; i < num.length; i++) {
    d += num[i] - num[i-1];
  }
  d /= num.length;

  let index = num[2] - num[1] > num[1] - num[0] ? 2 : 1;
  number = num[0] + d * index;

  return number;
}
// main code
let input = [
  // TC: 1
  [1, 7, 10],

  // TC: 2
  [3, 8, 18],

  // TC: 3
  [2, 5, 11],
];

for (let i = 0; i < input.length; i++) {
  console.log(`#${i + 1} ${answer(input[i][0], input[i][1], input[i][2])}`);
}
*/