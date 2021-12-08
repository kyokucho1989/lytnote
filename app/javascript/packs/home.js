

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
$(document).on("page:load turbolinks:load", function() {
  console.log("aaaa");

  $('#report_items').on('cocoon:before-insert', function() {
    console.log("aqq");
  })
  .on('cocoon:after-insert', function() {
    /* ... do something ... */    
    console.log("aqq");
  })
  .on("cocoon:before-remove", function() {
    console.log("aqq");
  })
  .on("cocoon:after-remove", function() {
    /* e.g. recalculate order of child items */    
    console.log("aqq");
  });

});

$(function () {
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