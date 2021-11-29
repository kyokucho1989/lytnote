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
    let state = this.value;
    let state_id = this.id;
    $.ajax({
      type: 'GET', // リクエストのタイプ
      url: '/reviews/change_state', // リクエストを送信するURL
      data:  { 'state' : state, 'id' : state_id }, // サーバーに送信するデータ
      dataType: 'json' // サーバーから返却される型
    })
    .done(function(data){ // dataにはレスポンスされたデータが入る
      // $('.test').remove();
      // $('.test').append(
      //   `${data.state}"---"${data.id}`
      // );
    })
  });
});