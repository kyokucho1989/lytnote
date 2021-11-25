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
  var select_field = $('select[id^="review"]');
  $(select_field).change(function(){
    console.log(this);
    // console.log(this.value);
    let content = this.value;
    $.ajax({
      type: 'GET', // リクエストのタイプ
      url: '/reviews/change_state', // リクエストを送信するURL
      data:  { 'content' : content }, // サーバーに送信するデータ
      dataType: 'json' // サーバーから返却される型
    })
  });
});