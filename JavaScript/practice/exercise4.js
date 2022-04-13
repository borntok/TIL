// 고차함수를 활용하여 오름차순&내림차순 정렬

let ascendingOrder = function (x, y) {
  if (typeof x === "string") x = x.toUpperCase();
  if (typeof y === "string") y = y.toUpperCase();
  return x > y ? 1 : -1;
}

let descendingOrder = function (x, y) {
  if (typeof x === "string") x = x.toUpperCase();
  if (typeof y === "string") y = y.toUpperCase();
  return x < y ? 1: -1;
}

let nums = [1, -1, 4, 0, 10, 20, 12];
let fruits = ["apple", "Orange", "orange", "melon"];

console.log(nums.sort(ascendingOrder));
console.log(nums.sort(descendingOrder));

console.log(fruits.sort(ascendingOrder));
console.log(fruits.sort(descendingOrder));

// forEach
/*
let nums = [1, 2, 3];
for (let i = 0; i < nums.length; i++) {
  console.log(nums[i]);
}

nums.forEach(function (i) {
  console.log(i);
})
*/

// push
/*
let nums = [1, 2, 3, 4, 5];
let useForLoop = [];

for (let i = 0; i < nums.length; i++) {
  useForLoop.push(nums[i] * 2);
}
console.log(useForLoop);

let useMap = nums.map(function (item) {
  return item * 2;
})
console.log(useMap);
*/

// find(하나의 값만 반환), filter
/*
let users = [
  { name: "Bob", age: 17, job: false },
  { name: "Aileen", age: 25, job: false },
  { name: "John", age: 27, job: true },
];

let findJob = users.filter(function (user) {
  return user.job == false;
});
console.log(findJob);

let findAge = users.filter(function (user) {
  return user.age >= 19;
})
console.log(findAge);
*/

// reduce
/*
let nums = [1, 2, 3, 4, 5];
let call_count = 0;

console.log("result\tvalue\tindex");
let sum = nums.reduce(function (accumalator, item, index, array) {
  console.log(accumalator,"\t\t", item, "\t\t", index);
  call_count++;
  return accumalator + item;
}, 0)

console.log(call_count);
console.log(sum);
*/