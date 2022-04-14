/* 1. 최소값 구하기 */
/*
// user code
function answer(x, y) {
  let min;
  min = Math.min(x, y);
  return min;
}

function answer(x, y) {
  let min;
  min = x > y ? y : x;
  return min;
}

// main code
let input = [
  // TC: 1
  [16, 3],
  // TC: 2
  [-3, 1],
  // TC: 3
  [1000, 525],
];

for (let i = 0; i < input.length; i++) {
  console.log(`#${i + 1} ${answer(input[i][0], input[i][1])}`);
}
*/

/* 2. 제곱 구현 */
/*
// user code
function answer(x, y) {
  let result = 1;

  for (let i = 0; i < y; i++) {
    result *= x;
  }
  return result;
}

// main code
let input = [
  // TC: 1
  [2, 3],
  // TC: 2
  [4, 6],
  // TC: 3
  [1, 100],
];

for (let i = 0; i < input.length; i++) {
  console.log(`#${i + 1} ${answer(input[i][0], input[i][1])}`);
}
*/

/* 3. 놀이기구 입장 제한 */
/*
// user code
function answer(user) {
  let permit;
  permit = user.height >= 150 ? true : false;
  return permit;
}

// main code
let input = [
  // TC: 1
  { name: "john", age: 27, height: 181 },
  // TC: 2
  { name: "alice", age: 12, height: 148 },
  // TC: 3
  { name: "bob", age: 14, height: 156 },
];

for (let i = 0; i < input.length; i++) {
  console.log(`#${i + 1} ${answer(input[i])}`);
}
*/

/* 4. 요일 구하기 */
/*
// user code
function answer(str) {
  let week = new Array(
    "일요일",
    "월요일",
    "화요일",
    "수요일",
    "목요일",
    "금요일",
    "토요일"
  );
  let day;
  day = new Date(str).getDay();
  day = week[day];
  return day;
}

// main code 
let input = [
  // TC: 1
  "2021-01-27",
  // TC: 2
  "2021-02-27",
  // TC: 3
  "2021-03-14",
];

for (let i = 0; i < input.length; i++) {
  console.log(`#${i + 1} ${answer(input[i])}`);
}
*/

/* 5. 중복 단어 제거 */
/*
// user code 
function answer(arr) {
  let new_arr = [];
  let newSet = new Set(arr);
  new_arr = [...newSet];
  return new_arr;
}

// main code 
let input = [
  // TC: 1
  ["john", "alice", "alice"],
  // TC: 2
  ["Hello", "hello", "HELLO", "hello"],
  // TC: 3
  ["kiwi", "banana", "mango", "kiwi", "banana"],
];

for (let i = 0; i < input.length; i++) {
  process.stdout.write(`#${i + 1} `);
  console.log(answer(input[i]));
}
*/

/* 6. 배열 내 최대값 구하기 */
/*
// user code
function answer(arr) {
  let max;
  max = arr[0];
  for (let i = 1; i < arr.length; i++) {
    if (max < arr[i]) {
      max = arr[i];
    }
  }
  return max;
}

// main code 
let input = [
  // TC: 1
  [1, 6, 5, 2, 3],
  // TC: 2
  [19, 41, 23, -4, 17],
  // TC: 3
  [-64, -27, -41, -33, -59],
];

for (let i = 0; i < input.length; i++) {
  console.log(`#${i + 1} ${answer(input[i])}`);
}
*/

/* 7. 스팸 메일 */
/*
// user code 
function answer(str) {
  let spam_flag;
  str = str.toUpperCase();
  spam_flag = str.includes('ADVERT');
  return spam_flag;
}

// main code 
let input = [
  // TC: 1
  "RE: Request documents",
  // TC: 2
  "[Advertisement] free mobile!",
  // TC: 3
  "50% off this week (advertising)",
];

for (let i = 0; i < input.length; i++) {
  console.log(`#${i + 1} ${answer(input[i])}`);
}
*/

/* 8. 배열 회전 */

/* user code */
/*
function answer(user) {
  let reverse = [];
  len = user.length
  for (let i = 0; i < len; i++) {
    reverse.push(user.pop());
  }
  return reverse;
}

function answer(user) {
  let reverse = [];
  for(let i = 0; i < user.length/2; i++) {
    [user[i], user[user.length-1-i]] = [user[user.length-1-i], user[i]]
  }
  reverse = user;
  return reverse;
}

// main code 
let input = [
  // TC: 1
  [1, 2, 3, 4],
  // TC: 2
  [-1, 6, "hello", -15],
  // TC: 3
  ["apple", "banana", "mango"],
];

for (let i = 0; i < input.length; i++) {
  process.stdout.write(`#${i + 1} `);
  console.log(answer(input[i]));
}
*/

/* 9. 문자 교정 */
/*
// user code
function answer(str) {
  let fix_str = "";
  let words = str.split(' ');

  for (let i = 0; i < words.length; i++) {
    let word = (words[i][0].toUpperCase());
    fix_str += word;
    for (let j = 1; j < words[i].length; j++) {
      fix_str += words[i][j];
    }
    fix_str += ' ';
  }
  return fix_str;
}

function answer(str) {
  let fix_str = "";
  
  for (let item of str.split(" ")) {
    fix_str += item[0].toUpperCase() + item.slice(1) + " ";
  }
  return fix_str;
}

// main code 
let input = [
  // TC: 1
  "Hello, My name is john",
  // TC: 2
  "This week is closed due to COVID-19",
  // TC: 3
  "fifty percent off this week",
];

for (let i = 0; i < input.length; i++) {
  console.log(`#${i + 1} ${answer(input[i])}`);
}
*/

/* 10. 2차원 배열의 곱셈 합 */
/*
// user code 
function answer(arr) {
  let product = 1;
  for (let i = 0; i < arr.length; i++) {
    for (let j = 0; j < arr[i].length; j++) {
      product *= arr[i][j];
    }
  }
  return product;
}

// main code 
let input = [
  // TC: 1
  [[1], [2], [3]],
  // TC: 2
  [
    [1, 2],
    [3, 4],
    [5, 6, 7],
  ],
  // TC: 3
  [
    [5, 1],
    [0.2, 4, 0.5],
    [3, 9],
  ],
];

for (let i = 0; i < input.length; i++) {
  console.log(`#${i + 1} ${answer(input[i])}`);
}
*/