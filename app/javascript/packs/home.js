const addButton = document.querySelector('.todo-button');
const addTodo = () => {
  alert('追加');
};

function alertDisp(){
  alert('変更');
}

if( addButton !== null ){
  addButton.addEventListener('click', addTodo);
}

$(function () {
  var selectB = $('select[id^="review"]');
  $('select[id^="review"]').change(function(){
    console.log("キーボードを入力した時に発生");
  })
});