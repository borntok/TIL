// 연결리스트 - 열차 연결 문제
/* user code */
function Train(number) {
  this.number = number;
  this.next = null;
}

function LinkedList() {
  this.head = null;
}

function answer(nums) {
  let ll = new LinkedList();

  let current, prev;
  for (i = 0; i < nums.length; i++) {
    current = new Train(nums[i]);
    if (i === 0) {
      ll.head = current;
    } else {
      prev.next = current;
    }
    prev = current;
  }

  return ll;
}

/* main code */
let input = [
  // TC: 1
  [4, 7, 1, 10, 6],

  // TC: 2
  [3, 10, 6, 9, 11, 3, 4],

  // TC: 3
  [5, 8, 7, 3, 4, 1, 2, 7, 10, 7],
];

LinkedList.prototype.printNode = function () {
  for (let node = this.head; node != null; node = node.next) {
    process.stdout.write(`${node.number} -> `);
  }
  console.log("null");
};

for (let i = 0; i < input.length; i++) {
  process.stdout.write(`#${i + 1} `);
  answer(input[i]).printNode();
}






// 연결리스트 - 서류 정리 문제
/* user code */
function File(number) {
  this.number = number;
  this.next = null;
}

function LinkedList() {
  this.head = null;
}

function answer(ll) {
  let current = ll.head,
    prev = null,
    next;
  // 역방향 정렬
  while (current != null) {
    next = current.next;
    current.next = prev;
    prev = current;
    current = next;
  }

  ll.head = prev;

  return ll;
}

/* main code */
let input = [
  // TC: 1
  [7, 3, 1],

  // TC: 2
  [4, 6, 9, 1, 3],

  // TC: 3
  [3, 4, 1, 2, 7, 9, 6],
];

LinkedList.prototype.printNode = function () {
  for (let node = this.head; node != null; node = node.next) {
    process.stdout.write(`${node.number} -> `);
  }
  console.log("null");
};

LinkedList.prototype.makeFiles = function (files) {
  let current = this.head;
  let node;
  for (let i = 0; i < files.length; i++) {
    node = new File(files[i]);
    node.next = current;
    this.head = node;

    current = node;
  }
};

for (let i = 0; i < input.length; i++) {
  process.stdout.write(`#${i + 1} `);

  let ll = new LinkedList();
  ll.makeFiles(input[i]);
  answer(ll).printNode();
}






// 원형 리스트 - 대표 선출 문제
/* user code */
function Node(data) {
  this.data = data;
  this.next = null;
}

function LinkedList() {
  this.head = null;
}

function answer(n, m, k) {
  let result = [];

  // 1. Circular Linked List 제작
  let ll = new LinkedList();
  let current, prev;

  for (let i = 1; i <= n; i++) {
    current = new Node(i);

    if (i === 1) {
      ll.head = current;
    } else {
      prev.next = current;
    }

    prev = current;
  }
  current.next = ll.head;

  // 2. Start node 위치 설정
  current = ll.head;
  while (--m) {
    prev = current;
    current = current.next;
  }

  // 3. 후보자들 중 k만큼 움직이면서 제거 -> 단, 혼자 남을 때까지
  let count;
  while (current.next != current) {
    result.push(current.data);
    prev.next = current.next;

    count = k;
    while (count--) {
      prev = current;
      current = current.next;
    }
  }

  // 4. 혼자 남은 후보 번호를 result에 추가
  result.push(current.data);

  return result;
}

/* main code */
let input = [
  // TC: 1
  [8, 2, 3],

  // TC: 2
  [10, 2, 3],

  // TC: 3
  [20, 5, 7],
];

for (let i = 0; i < input.length; i++) {
  process.stdout.write(`#${i + 1} `);
  console.log(answer(input[i][0], input[i][1], input[i][2]));
}
