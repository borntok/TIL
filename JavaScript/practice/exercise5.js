/*** 1. 별별별 ***/
/*
// user code
function answer(num) {
  let result = "";
  for (i = 0; i < num; i++) {
    result += "*"
  }
  return result;
}

// main code 
let input = [
  // TC: 1
  5,
  // TC: 2
  7,
  // TC: 3
  12,
];

for (let i = 0; i < input.length; i++) {
  console.log(`#${i + 1} ${answer(input[i])}`);
}
*/

/*** 2. 두 수 사이 숫자 ***/
/*
// user code
function answer(x, y) {
  let result = [];
  if (x > y) {
    for (i = y; i < x+1; i++) {
      result.push(i);
    }
  } else {
    for (i = x; i < y+1; i++) {
      result.push(i)
    }
  }

  return result;
}

// main code
let input = [
  // TC: 1
  [3, 7],
  // TC: 2
  [8, 3],
  // TC: 3
  [12, 10],
];
for (let i = 0; i < input.length; i++) {
  process.stdout.write(`#${i + 1} `);
  console.log(answer(input[i][0], input[i][1]));
}
*/

/*** 3. 반 평균 ***/
/*
// user code
function answer(score) {
  let average = 0;
  for (s of score) {
    average += s;
  }
  average = (average / score.length).toFixed(2);
  return average;
}

// main code
let input = [
  // TC: 1
  [80, 95, 65, 70, 100],
  // TC: 2
  [82, 77, 51, 64, 73, 90, 80],
  // TC: 3
  [100, 71, 59, 88, 72, 75, 91, 93],
];

for (let i = 0; i < input.length; i++) {
  console.log(`#${i + 1} ${answer(input[i])}`);
}
*/

/*** 4. 헨드폰 판매 ***/

// user code 
/*
function answer(employee) {
  let employee_id;
  let score = Math.max(...employee);
  employee_id = employee.indexOf(score)+1;
  return employee_id;
}

function answer(employee) {
  let employee_id;
  let x = 0;
  for (i = 0; i < employee.length; i++) {
    if (x < employee[i]) {
      x = employee[i];
    }
  }
  employee_id = employee.indexOf(x)+1;
  return employee_id;
}

// main code 
let input = [
  // TC: 1
  [3, 7, 9, 6, 1],
  // TC: 2
  [2, 7, 1, 4, 3, 0, 5],
  // TC: 3
  [7, 5, 0, 1, 2, 12, 6],
];
for (let i = 0; i < input.length; i++) {
  console.log(`#${i + 1} ${answer(input[i])}`);
}
*/

/*** 5. 무한 뺄셈 ***/
/*
// user code
function answer(s, e) {
  let sequence = [];
  sequence.push(s);
  sequence.push(e);

  let i = 0, x = 1;
  while (x >= 0) {
    x = sequence[i] - sequence[i+1];
    if (x >= 0) sequence.push(x);
    i++
  }
  return sequence;
}

// main code
let input = [
  // TC: 1
  [9, 3],
  // TC: 2
  [6, 3],
  // TC: 3
  [13, 7],
];

for (let i = 0; i < input.length; i++) {
  process.stdout.write(`#${i + 1} `);
  console.log(answer(input[i][0], input[i][1]));
}
*/