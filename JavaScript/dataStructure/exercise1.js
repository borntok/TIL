/* 수열 최소값 위치 */
/*
// user code 
function answer(nums) {
  let result = [];
  let min = Math.min(...nums);
  for (i = 0; i < nums.length; i++) {
    if (nums[i] == min) {
      result.push(i);
    }
  }
  return result;
}
*/
/*
function answer(nums) {
  let result = [];

  let min = Number.MAX_SAFE_INTEGER;
  for (let i = 0; i < nums.length; i++) {
    if (min > nums[i]) {
      min = nums[i];
    }
  }

  let count = 0;
  for (let i = 0; i < nums.length; i++) {
    if (min == nums[i]) {
      result[count] = i;
      count++;
    }
  }

  return result;
}
*/
/*
// main code //
let input = [
  // TC: 1
  [5, 2, 10, 2],

  // TC: 2
  [4, 5, 7, 4, 8],

  // TC: 3
  [12, 11, 11, 16, 11, 12],
];

for (let i = 0; i < input.length; i++) {
  process.stdout.write(`#${i + 1}`);
  console.log(answer(input[i]));
}
*/

/* 체스 세트 */
/*
// user code 
function answer(chess) {
  let result = [];
  let need = [1, 1, 2, 2, 2, 8];

  for (i = 0; i < chess.length; i++) {
    result[i] = need[i] - chess[i];
  }
  return result;
}

// main code 
let input = [
  // TC: 1
  [0, 1, 2, 2, 2, 7],

  // TC: 2
  [2, 1, 2, 1, 2, 1],

  // TC: 3
  [0, 1, 1, 5, 3, 6],
];

for (let i = 0; i < input.length; i++) {
  process.stdout.write(`#${i + 1}`);
  console.log(answer(input[i]));
}
*/

/* 두 수 최대합 */

// user code 
/*
function answer(nums) {
  let result = [];
  let sorted = nums.sort((x, y) => x - y);
  sorted.reverse();
  result[0] = sorted[0];
  result[1] = sorted[1];
  return result;
}
*/
/*
function answer(nums) {
  let result = [];
  
  result = nums[0] > nums[1] ? [nums[0], nums[1]] : [nums[1], nums[0]];
  for (let i = 2; i < nums.length; i++) {
    if (nums[i] > result[0]) {
      result[1] = result[0];
      result[0] = nums[i];
    } else if (nums[i] > result[1]) {
      result[1] = nums[i];
    }
  }
  return result;
}
// main code 
let input = [
  // TC: 1
  [-11, 5, 18, -2, -3, 6, 4, 17, 10, 9],

  // TC: 2
  [3, 7, -14, 2, -6, 13, -20, -2, -7, 6, -17, -5, 14, -9, 19],

  // TC: 3
  [
    -15, -4, -8, 12, 12, -8, -8, 9, 10, 15, -2, 10, -14, 2, 13, 19, -9, 3, -18,
    14,
  ],
];

for (let i = 0; i < input.length; i++) {
  process.stdout.write(`#${i + 1}`);
  console.log(answer(input[i]));
}
*/

/* 일곱 난장이 */

// user code 
/*
function answer(dwarf) {
  let result = [];
  let total = 0;

  for (let num of dwarf) {
    total += num;
  }

  let total_1 = 0, total_2 = 0;
  let idx1, idx2;

  for (i = 0; i < dwarf.length; i++) {
    total_1 = total - dwarf[i];
    for (j = i+1; j < dwarf.length; j++) {
      total_2 = total_1 - dwarf[j];
      if (total_2 == 100) {
        idx1 = i;
        idx2 = j;
        break;
      }
    }
    if (i == idx1) continue;
    if (i == idx2) continue;
    result.push(dwarf[i]);
  }
  return result;
}
*/
/*
function answer(dwarf) {
  let result = [];
  
  let sum = 0;
  for (let i = 0; i < dwarf.length; i++) {
    sum += dwarf[i];
  }
  sum -= 100;

  let faker = [];
  for (let i = 0; i < dwarf.length; i++) {
    for (let j = i+1; j < dwarf.length; j++) {
      if (sum == dwarf[i] + dwarf[j]) {
        faker[0] = i;
        faker[1] = j;
        break;
      }
    }
    if (faker.length != 0) break;
  }

  let count = 0;
  for (let i = 0; i < dwarf.length; i++) {
    if (faker[0] != i && faker[1] != i) {
      result[count++] = dwarf[i];
    }
  }
  return result;
}

// main code 
let input = [
  // TC: 1
  [1, 5, 6, 7, 10, 12, 19, 29, 33],

  // TC: 2
  [25, 23, 11, 2, 18, 3, 28, 6, 37],

  // TC: 3
  [3, 37, 5, 36, 6, 22, 19, 2, 28],
];

for (let i = 0; i < input.length; i++) {
  process.stdout.write(`#${i + 1}`);
  console.log(answer(input[i]));
}
*/

/* 나무 그리기 */
/*
// user code 
function answer(height) {
  let str = "\n";
  
  for (i = 0; i < height; i++) {
    for (j = 0; j < height - i - 1; j++) {
      str += " ";
    } 
    for (k = 0; k < 2*i+1; k++) {
      str += "*";
    }
    str += "\n";
  }
  return str;
}
// main code 
let input = [
  // TC: 1
  3,

  // TC: 2
  5,

  // TC: 3
  7,
];

for (let i = 0; i < input.length; i++) {
  console.log(`#${i + 1} ${answer(input[i])}`);
}
*/

/* two sum */

// user code
/*
function answer(nums, target) {
  for (let i = 0; i < nums.length; i++) {
    for (let j = i + 1; j < nums.length; j++) {
      if (nums[i] + nums[j] == target) {
        return [i, j]
      }
    } if (idx.length != 0) break;
  }
}

function answer(nums, target) {
  let map = {};

  for (let i = 0; i < nums.length; i++) {
    if (map[target - nums[i]] != undefined) {
      return [ma[[target - nums[i]], i]];
    }
    map[nums[i]] = i;
  }
  return []; 
}


// main code 
let input = [
  // TC: 1
  [[2, 7, 11, 15], 9],

  // TC: 2
  [[3, 2, 4], 6],

  // TC: 3
  [[3, 3], 6],
];

for (let i = 0; i < input.length; i++) {
  process.stdout.write(`#${i + 1}`);
  console.log(answer(input[i][0], input[i][1]));
}
*/
/* OX 퀴즈 */

// user code
/*
function answer(mark) {
  let result = 0;
  for (let i = 0; i < mark.length; i++) {
    if (mark[i] == 1) {
      result += 1;
    }
  }

  let count = 0;
  for (let i = 0; i+1 < mark.length; i++) {
    if (mark[i] == 1 && mark[i] == mark[i+1]) {
      count++;
      result += count;
    } else {
      count = 0;
    }  
  }
  return result;
}
*/
/*
function answer(mark) {
  let result = 0;

  let score = 0;
  for (let i = 0; i < mark.length; i++) {
    if (mark[i] == 1) {
      result += ++score;
    } else {
      score = 0;
    }
  }
  return result;
}



// main code 
let input = [
  // TC: 1
  [1, 0, 1, 1, 1, 0, 1, 1, 0, 0],

  // TC: 2
  [1, 1, 0, 1, 1, 0, 1, 1, 1, 1],

  // TC: 3
  [1, 1, 1, 1, 1, 0, 0, 1, 1, 0],
];

for (let i = 0; i < input.length; i++) {
  console.log(`#${i + 1} ${answer(input[i])}`);
}
*/

/* 벽돌 옮기기 */
/*
// user code
function answer(blocks) {
  let result = 0;

  let num = 0;
  for (let block of blocks) {
    num += block;
  }
  num = num / blocks.length;
  
  for (let block of blocks) {
    if (block > num) {
      result += block - num;
    }
  }
  return result;
}

// main code 
let input = [
  // TC: 1
  [5, 2, 4, 1, 7, 5],

  // TC: 2
  [12, 8, 10, 11, 9, 5, 8],

  // TC: 3
  [27, 14, 19, 11, 26, 25, 23, 15],
];

for (let i = 0; i < input.length; i++) {
  console.log(`#${i + 1} ${answer(input[i])}`);
}
*/

/* 숫자 빈도수 구하기 */
/*
// user code 
function answer(s, e) {
  let result = [];

  result = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  let num;
  for (let i = s; i <= e; i++) {
    num = i;
    while (true) {
      result[num % 10]++;
      num = num / 10;
      num = parseInt(num);

      if (num == 0) break;
    }
  }
  return result;
}

// main code 
let input = [
  // TC: 1
  [129, 137],

  // TC: 2
  [1412, 1918],

  // TC: 3
  [4159, 9182],
];

for (let i = 0; i < input.length; i++) {
  process.stdout.write(`# ${i + 1}`);
  console.log(answer(input[i][0], input[i][1]));
}
*/

/* 달팽이 만들기 */

/* user code */
function answer(length) {
  let result = [];

  for (i = 0; i < length; i++) {
    result[i] = [];
  }

  let direction = 1;
  let x, y, num;
  x = y = num = 0;
  x--;
  while (1) {
    for (let i = 0; i < length; i++) {
      x += direction;
      result[y][x] = ++num;
    }
    length--;

    if (length == 0) break;

    for (let j = 0; j < length; j++) {
      y += direction;
      result[y][x] = ++num;
    }
    direction *= -1;
  }

  return result;
}

/* main code */
let input = [
  // TC: 1
  3,

  // TC: 2
  5,

  // TC: 3
  6,
];

for (let i = 0; i < input.length; i++) {
  process.stdout.write(`#${i + 1} `);
  console.log(answer(input[i]));
}
