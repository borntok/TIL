// 반복문 for를 이용하여 0부터 10까지의 정수 중 짝수의 합을 구한 뒤 출력해주는 코드를 작성하시오.

const UNTIL_NUM = 10;
let sum = 0;

for (i = 0; i <= UNTIL_NUM; i++) {
  if (i % 2 === 0) {
    sum += i;
  }
}
console.log(sum);

sum = 0;
for (i = UNTIL_NUM; i >= 0; i--) {
  if (i % 2 === 0) {
    sum += i;
  }
}
console.log(sum);