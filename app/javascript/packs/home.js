

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
  $('#container').on('cocoon:before-insert', function(event, insertedItem) {
    var confirmation = confirm("Are you sure?");
    if( confirmation === false ){
      event.preventDefault();
    }
  });
  
  var select_field = $('select[id^="review"]');
  $(select_field).change(function(){
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
      // const select_plan_id = "." + data.id;
      // $(select_plan_id).empty();
      const p1 = document.getElementById(`${data.id}_disp`);
      p1.classList.remove('visible','imvisible');
      if (data.state == "進行中"){
        p1.classList.add('visible');
      }else{
        p1.classList.add('imvisible');
      }
      // $("." + data.id).append(
      //   `${data.state}"---"${data.id}`
      // );
    })
  });
});