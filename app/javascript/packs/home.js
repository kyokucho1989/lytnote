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
  var content = $('select[id^="review"]');
  $('select[id^="review"]').change(function(){
    console.log(content);
    $.ajax({
      type: 'GET', // リクエストのタイプ
      url: '/reviews/chantate', // リクエストを送信するURL
      data:  { content: content }, // サーバーに送信するデータ
      dataType: 'json' // サーバーから返却される型
    })
  });


});