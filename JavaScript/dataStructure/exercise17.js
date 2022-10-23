/* 출석 체크 - 딕셔너리 문제 */

function Dictionary(items = {}) {
  this.items = items;
}

Dictionary.prototype.has = function (key) {
  return this.items.hasOwnProperty(key);
};

Dictionary.prototype.set = function (key, value) {
  this.items[key] = value;
};

// user code
function answer(class_1, class_2) {
  let result = [];

  // class_2에 대한 key/value 형태로 저장 -> 학생 있는지 없는지 확인
  let tmp = new Dictionary();
  for (let i = 0; i < class_2.length; i++) {
    tmp.set(class_2[i], true);
  }

  // class_1 for class_2 dictionary 학생 있는지 없는지 유무를 통해 빠르게 확인
  for (let i = 0; i < class_1.length; i++) {
    if (tmp.has(class_1[i])) {
      result.push(class_1[i]);
    }
  }
  // 2O(n) 시간복잡도
  return result;
}

// main code
let input = [
  // TC: 1
  [
    ["Kali", "Oliver", "Naomi"],
    ["Oliver", "Naomi", "Maya"],
  ],

  // TC: 2
  [
    ["Roxy", "Olga", "Kara", "Nana"],
    ["Oliver", "Roxy", "Kara", "Nana", "Maya"],
  ],

  // TC: 3
  [
    ["Roxy", "Ravi", "Nana", "Rei", "Karis", "Mana", "Naomi"],
    ["Olga", "Nana", "Rei", "Naomi", "Kali", "Ravi", "Kara"],
  ],
];

for (let i = 0; i < input.length; i++) {
  process.stdout.write(`#${i + 1} `);
  console.log(answer(input[i][0], input[i][1]));
}

/* 숫자 카드 - 해시테이블 */

const HASH_SIZE = 21;

function HashTable() {
  this.table = new Array(HASH_SIZE);
}

HashTable.prototype.hashCode = function (key) {
  return (key + 10) % HASH_SIZE; // -10 ~ 10 -> 0 ~ 20
};

HashTable.prototype.put = function (key) {
  let index = this.hashCode(key);
  if (this.table[index] === undefined) {
    this.table[index] = 0;
  }
  this.table[index]++;
};

HashTable.prototype.get = function (key) {
  let index = this.hashCode(key);
  return this.table[index] ? this.table[index] : 0;
};

// user code
function answer(card, select) {
  let result = [];

  // 1. card 내에 있는 숫자 카드가 몇 개인지를 count
  let ht = new HashTable();
  for (let i = 0; i < card.length; i++) {
    // 카드 숫자별 카운트
    ht.put(card[i]);
  }

  // 2. select 내에 있는 숫자 카드가 1번의 count 한 배열에서 몇 개 있는지 확인
  for (let i = 0; i < select.length; i++) {
    // 1번에서 구한 숫자카드가 있는 경우 그 카드의 개수를 넣어주고 없는 경우 0
    result.push(ht.get(select[i]));
  }

  return result;
}

// main code
let input = [
  // TC: 1
  [
    [-6, -1, 6, 1, 1],
    [-2, 1, 3],
  ],

  // TC: 2
  [
    [7, 4, 3, 10, 10, 10, -10, -10, 7, 3],
    [10, 9, -5, 4, 6, -10],
  ],

  // TC: 3
  [
    [5, -3, -7, 10, -3, 4, 8, 4, -3, 3, 8, -2, -9, -8, -1],
    [4, 5, 1, 10, -2, -3, 3, -8],
  ],
];

for (let i = 0; i < input.length; i++) {
  process.stdout.write(`#${i + 1} `);
  console.log(answer(input[i][0], input[i][1]));
}

/* 백신 접종 - 선형조사법 해시테이블 */

// user code
function Element(key, value) {
  this.key = key;
  this.value = value;
}

function HashTable(size) {
  this.size = size;
  this.table = new Array(this.size);
  this.length = 0;
}

HashTable.prototype.hashCode = function (key) {
  let hash = 0;
  for (let i = 0; i < key.length; i++) {
    hash += key.charCodeAt(i);
  }
  return hash % this.size;
};

HashTable.prototype.put = function (key) {
  let index = this.hashCode(key);
  let startIndex = index;

  do {
    if (this.table[index] === undefined) {
      this.table[index] = new Element(key, index + 1);
      this.length++;
      return true;
    }
    index = (index + 1) % this.size;
  } while (startIndex !== index);
};

HashTable.prototype.get = function (key) {
  let index = this.hashCode(key);
  let startIndex = index;

  do {
    if (this.table[index] !== undefined && this.table[index].key === key) {
      return this.table[index].value;
    }
    index = (index + 1) % this.size;
  } while (startIndex !== index);

  return undefined;
};

// user code
function answer(name) {
  let result = [];

  let ht = new HashTable(name.length);

  // 1. for loop: push
  for (let i = 0; i < name.length; i++) {
    ht.put(name[i]);
  }
  // 2. for loop: get
  for (let i = 0; i < name.length; i++) {
    result.push(ht.get(name[i]));
  }

  return result;
}

// main code
let input = [
  // TC: 1
  ["Mana", "Naomi", "Lelia", "Morris", "Madonna"],

  // TC: 2
  ["Oliver", "Mabel", "Nero", "Rei", "Kara", "Jordan", "Nami"],

  // TC: 3
  [
    "Ruby",
    "Robin",
    "Jordan",
    "Kori",
    "Rei",
    "Madonna",
    "Justin",
    "Maya",
    "Lakia",
    "Kali",
  ],
];

for (let i = 0; i < input.length; i++) {
  process.stdout.write(`#${i + 1} `);
  console.log(answer(input[i]));
}
