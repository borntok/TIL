// 등차수열
/*
let result;

function forloop(s, t, number) {
  let acc = 0;

  for (let i = 1; i <= number; i++) {
    if (i == 1) {
      acc += s;
    } else {
      acc += t;
    }
    console.log(i, acc);
  }
  return acc;
}

result = forloop(3, 2, 5);
console.log(result);
*/
/*
let result;

function recursive(s, t, number) {
  if (number == 1) {
    return s;
  }

  return recursive(s, t, number - 1) + t;
}

result = recursive(3, 2, 5);
console.log(result);
*/

// 등비수열
/*
let result;

function forloop(s, t, number) {
  let acc = 1;

  for (let i = 1; i <= number; i++) {
    if (i == 1) {
      acc *= s;
    } else {
      acc *= t;
    }
    console.log(i, acc);
  }
  return acc;
}

result = forloop(3, 2, 5);
console.log(result);
*/
/*
function recursive(s, t, number) {
  if (number == 1) {
    return s;
  }

  return recursive(s, t, number-1) * t;
}

result = recursive(3, 2, 5);
console.log(result);
*/

// 팩토리얼
/*
let result;

function factorial(number) {
  if (number == 1) {
    return 1;
  }
  return factorial(number - 1) * number;
}

result = factorial(5);
console.log(result);
*/

// 피보나치
let result;

function fibonacci(number) {
  if (number == 1 || number == 0) {
    return number;
  }

  return fibonacci(number - 1) + fibonacci(number - 2);
}

result = fibonacci(7);
console.log(result);