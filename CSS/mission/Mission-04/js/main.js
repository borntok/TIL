// 요소 선택
//  마이쿠팡 영역의 클래스 이름은 myCoupang으로 지정되어 있어야하며 합.
const myCoupang = document.querySelector('.myCoupang');
const myCoupangButton = myCoupang.querySelector('.myCoupang button');
//  장바구니 영역의 클래스 이름은 cart로 지정되어 있어야하며 합.
const cart = document.querySelector('.cart');
const cartButton = myCoupang.querySelector('.myCoupang button');

// 이벤트 바인딩
myCoupang.addEventListener('mouseenter', addActive);
myCoupang.addEventListener('mouseleave', removeActive);
myCoupang.addEventListener('focusin', addActive);
myCoupang.addEventListener('focusout', removeActive);

cart.addEventListener('mouseenter', addEmpty);
cart.addEventListener('mouseleave', removeEmpty);
cart.addEventListener('focusin', addEmpty);
cart.addEventListener('focusout', removeEmpty);


// 함수 구현
// focusout과 focusin이 같이 발생하면서 focusout에 의해서 화면에서 사라지면 focusin 이벤트가 발생할 요소가 없어지기 때문에 지연시간을 추가.
function addActive(e){
  setTimeout(() => myCoupang.classList.add('is--active'));
}

function removeActive(e){
  setTimeout(() => myCoupang.classList.remove('is--active'));
}

function addEmpty(e){
  setTimeout(() => cart.classList.add('cart--empty'));
}

function removeEmpty(e){
  setTimeout(() => cart.classList.remove('cart--empty'));
}