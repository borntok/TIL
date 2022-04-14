/*
// 순열(반복문)
let input = ["a", "b", "c"];
let count = 0;

function permutation(arr) {
  for (let i = 0; i < arr.length; i++) {
    for (let j = 0; j < arr.length; j++) {
      if (i == j) continue;
      for (let k = 0; k < arr.length; k++) {
        if (i == k) continue;
        if (j == k) continue;

        console.log(arr[i], arr[j], arr[k]);
        count++;
      }
    }
  }
}

permutation(input);
console.log(count);
*/
/*
// 순열(재귀함수)
let input = ["a", "b", "c"];
let count = 0;

function permutation(arr, s, r) {
  if (s == r) {
    count++;
    console.log(arr.join(" "));
    return;
  }
  for (let i = s; i < arr.length; i++) {
    [arr[s], arr[i]] = [arr[i], arr[s]];
    permutation(arr, s+1, r);
    [arr[s], arr[i]] = [arr[i], arr[s]];
  }
}

permutation(input, 0, 2);
console.log(count);
*/
/*
// 조합(반복문) 4C2
let input = [1, 2, 3, 4];
let count = 0;

function combination(arr) {
  for (let i = 0; i < arr.length; i++) {
    for (let j = i+1; j < arr.length; j++) {
      count++;
      console.log(arr[i], arr[j]);
    }
  }
}

combination(input);
console.log(count);
*/
/*
// 조합(재귀함수) 4C2
let input = [1, 2, 3, 4];
let output = [];
let count = 0;

function combination(arr, data, s, idx, r) {
  if (s == r) {
    count++;
    console.log(data);
    return;
  }

  for (let i = idx; arr.length - i >= r - s; i++) {
    data[s] = arr[i];
    combination(arr, data, s+1, i+1, r);
  }
}

combination(input, output, 0, 0, 2);
console.log(count);
*/