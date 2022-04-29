/* 프린터 출력 */
function Queue() {
  this.array = [];
}

Queue.prototype.enqueue = function(element) {
  this.array.push(element);
}

Queue.prototype.dequeue = function() {
  return this.array.shift();
}

Queue.prototype.front = function() {
  return this.array[0];
}

Queue.prototype.max = function() {
  return Math.max(...this.array);
}


/* user code */
function answer(priorities, select) {
  let result = -1;
  
  let vq = new Queue();
  let pq = new Queue();

  for (let i = 0; i < priorities.length; i++) {
    vq.enqueue(i);
    pq.enqueue(priorities[i]);
  }

  let count = 0;
  while (true) {
    if (pq.front() === pq.max()) {
      count++;
      if(vq.front() === select) {
        result = count;
        break;
      } else {
        vq.dequeue();
        pq.dequeue();
      }
    } else {
      vq.enqueue(vq.dequeue());
      pq.enqueue(pq.dequeue());
    }
  }

  return result;
}

/* main code */
let input = [
  // TC: 1
  [[3], 0],

  // TC: 2
  [[3, 4, 5, 6], 2],

  // TC: 3
  [[1, 1, 5, 1, 1, 1], 0],
];

for (let i = 0; i < input.length; i++) {
  process.stdout.write(`#${i + 1} `);
  console.log(answer(input[i][0], input[i][1]));
}





/* 카드 뽑기 */

/* user code */
function answer(n) {
  let result = [];

  let cards = [];
  for (i = 1; i <= n; i++) {
    cards.push(i);
  }

  while (cards.length != 0) {
    result.push(cards.shift());
    
    if (cards.length != 0) {
      cards.push(cards.shift());
    }
  }
  return result;
}

/* main code */
let input = [
  // TC: 1
  4,

  // TC: 2
  7,

  // TC: 3
  10,
];

for (let i = 0; i < input.length; i++) {
  process.stdout.write(`#${i + 1} `);
  console.log(answer(input[i]));
}



/* 대표 선출 */

function CircularQueue(size) {
  this.array = new Array(size);
  this.size = this.array.length;
  this.length = 0;
  this.head = 0;
  this.tail = 0;
}

CircularQueue.prototype.enqueue = function(element) {
  this.length++;
  this.array[this.tail++ % this.size] = element;
}

CircularQueue.prototype.dequeue = function() {
  this.length--;
  return this.array[this.head++ % this.size];
}

/* user code */
function answer(n, m, k) {
  let result = [];

  let cq = new CircularQueue(n);
  for (let i = 1; i <=n; i++) {
    cq.enqueue(i);
  }

  cq.tail = cq.head = (n + m - 1) % n;

  let count;
  result.push(cq.dequeue());
  while (cq.length != 0) {
    count = k - 1;
    while (count--) {
      cq.enqueue(cq.dequeue());
    }
    result.push(cq.dequeue());
  }

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



/* 데크 만들기 */

function Deque(array = []) {
  this.array = array;
}

Deque.prototype.push_front = function(element) {
  return this.array.unshift(element);
}
Deque.prototype.push_back = function(element) {
  return this.array.push(element);
}
Deque.prototype.pop_front = function() {
  let ret = this.array.shift();
  return ret === undefined ? -1 : ret;
}
Deque.prototype.pop_back = function() {
  let ret = this.array.pop();
  return ret === undefined ? -1 : ret;
}
Deque.prototype.empty = function() {
  return this.array.length === 0 ? 1 : 0;
}
Deque.prototype.size = function() {
  return this.array.length;
}
Deque.prototype.front = function() {
  return this.array.length === 0 ? -1 : this.array[0];
}
Deque.prototype.back = function() {
  return this.array.length === 0 ? -1 : this.array[this.array.length-1];
}
/* user code */
function answer(cmds) {
  let result = [];

  let dq = new Deque();
  for (let i = 0; i < cmds.length; i++) {
    let cmd = cmds[i].split(" ")[0];

    switch (cmd) {
      case "push_front":
        dq.push_front(Number(cmds[i].split(" ")[1]));
        break;
      case "push_back":
        dq.push_back(Number(cmds[i].split(" ")[1]));
        break;
      case "pop_front":
        result.push(dq.pop_front());
        break;
      case "pop_back":
        result.push(dq.pop_back());
        break;
      case "size":
        result.push(dq.size());
        break;
      case "empty":
        result.push(dq.empty());
        break;
      case "front":
        result.push(dq.front());
        break;
      case "back":
        result.push(dq.back());
        break;
    }
  }
  return result;
}

/* main code */
let input = [
  // TC: 1
  ["push_back 1", "push_front 2", "pop_front", "pop_back", "pop_front"],

  // TC: 2
  [
    "push_back 3",
    "push_front 4",
    "push_back 5",
    "push_front 6",
    "front",
    "back",
    "pop_front",
    "size",
    "empty",
  ],

  // TC: 3
  [
    "push_back 7",
    "push_front 8",
    "front",
    "back",
    "size",
    "empty",
    "pop_front",
    "pop_back",
    "pop_front",
    "size",
    "empty",
    "pop_back",
    "push_front 9",
    "empty",
    "front",
  ],
];

for (let i = 0; i < input.length; i++) {
  process.stdout.write(`#${i + 1} `);
  console.log(answer(input[i]));
}