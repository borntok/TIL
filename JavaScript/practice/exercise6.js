/*** 1. 대소비교 ***/
/*
// user code
function answer(x, y) {
  let result = "";
  if (x > y) {
    result = ">";
  } else if (x < y) {
    result = "<";
  } else {
    result = "=";
  }

  return result;
}

// main code 
let input = [
  // TC: 1
  [3, 5],
  // TC: 2
  [7, 4],
  // TC: 3
  [2, 2],
];

for (let i = 0; i < input.length; i++) {
  console.log(`#${i + 1} ${answer(input[i][0], input[i][1])}`);
}
*/

/*** 2. 나누기와 대소비교 ***/
/*
// user code
function answer(a, b, c, d) {
  let result;
  if (a/b > c/d) {
    result = 1;
  } else if (a/b < c/d) {
    result = -1;
  } else {
    result = 0;
  }
  return result;
}

// main code
let input = [
  // TC: 1
  [14, 2, 6, 6],
  // TC: 2
  [6, 7, 8, 9],
  // TC: 3
  [18, 2, 36, 4],
];

for (let i = 0; i < input.length; i++) {
  console.log(
    `#${i + 1} ${answer(input[i][0], input[i][1], input[i][2], input[i][3])}`
  );
}
*/

/*** 3. 윤년 판별기 ***/
/*
// user code
function answer(year) {
  let result;
  if (year % 4 == 0 && year % 100 != 0 || year % 400 == 0) {
    result = true;
  } else {
    result = false;
  }
  return result;
}

// main code 
let input = [
  // TC: 1
  4,
  // TC: 2
  100,
  // TC: 3
  124,
  // TC: 4
  247,
  // TC: 5
  400,
];
for (let i = 0; i < input.length; i++) {
  console.log(`#${i + 1} ${answer(input[i])}`);
}
*/

/*** 4. ATM 기기 ***/
/*
// user code
function answer(withdraw, total) {
  let result;
  if (withdraw % 5 == 0 && withdraw <= (total - 0.5)) {
    result = total - withdraw - 0.5;
  } else {
    result = total;
  }

  return result;
}

// main code
let input = [
  // TC: 1
  [40, 130.0],
  // TC: 2
  [33, 130.0],
  // TC: 3
  [300, 300.0],
];
for (let i = 0; i < input.length; i++) {
  console.log(`#${i + 1} ${answer(input[i][0], input[i][1])}`);
}
*/

/*** 5. 네번째 좌표 ***/
/*
// user code
function answer(x_arr, y_arr) {
  let result = [];
  if (x_arr[0] == x_arr[1]) {
    result.push(x_arr[2]);
  } else if (x_arr[0] == x_arr[2]) {
    result.push(x_arr[1]);
  } else if (x_arr[1] == x_arr[2]) {
    result.push(x_arr[0]);
  }

  if (y_arr[0] == y_arr[1]) {
    result.push(y_arr[2]);
  } else if (y_arr[0] == y_arr[2]) {
    result.push(y_arr[1]);
  } else if (y_arr[1] == y_arr[2]) {
    result.push(y_arr[0]);
  }
  return result;
}

// main code 
let input = [
  // TC: 1
  [
    [5, 5, 8],
    [5, 8, 5],
  ],
  // TC: 2
  [
    [3, 1, 1],
    [2, 1, 2],
  ],
  // TC: 3
  [
    [7, 7, 3],
    [4, 1, 1],
  ],
];
for (let i = 0; i < input.length; i++) {
  process.stdout.write(`#${i + 1}`);
  console.log(answer(input[i][0], input[i][1]));
}
*/