// Deque(): 초기 속성값 설정을 위한 생성자 함수
function Deque(array = []) {
  this.array = array;
}

// getBuffer(): 객체 내 데이터 셋 반환
Deque.prototype.getBuffer = function() {
  return this.array.slice();
};

// isEmpty(): 데이터 비어 있는지 확인
Deque.prototype.isEmpty = function() {
  return this.array.length === 0;
};

// pushFront(): 앞쪽 데이터 추가
Deque.prototype.pushFront = function(element) {
  return this.array.unshift(element);
}

// popFront(): 앞쪽 데이터 삭제
Deque.prototype.popFront = function() {
  return this.array.shift();
}

// pushBack(): 뒤쪽 데이터 추가
Deque.prototype.pushBack = function(element) {
  return this.array.push(element);
}

// popBack(): 뒤쪽 데이터 삭제
Deque.prototype.popBack = function(element) {
  return this.array.pop();
}

// front():가장 첫 데이터 반환
Deque.prototype.front = function() {
  return this.array.length === 0 ? undefined : this.array[0];
}

// back(): 가장 끝 데이터 반환
Deque.prototype.back = function() {
  return this.array.length === 0 ? undefined : this.array[this.array.length - 1];
}

// size(): 큐 내 데이터 개수 확인
Deque.prototype.size = function() {
  return this.array.length;
}

// clear(): 큐 초기화
Deque.prototype.clear = function() {
  this.array = [];
}

let dq = new Deque([1, 2, 3]);
console.log(dq);

dq.pushFront(0);
dq.pushBack(4);
console.log(dq);

console.log(dq.popFront());
console.log(dq.popBack());
console.log(dq);

console.log(dq.front());
console.log(dq.back());
console.log(dq.size());

dq.clear();
console.log(dq);