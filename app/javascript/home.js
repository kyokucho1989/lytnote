$(document).on("page:load turbolinks:load", function() {
// cocoon callback

  $('#report_items').on('cocoon:before-insert', function() {
    console.log("before-insert");
  })
  .on('cocoon:after-insert', function() {
    /* ... do something ... */    
    console.log("after-insert");
  })
  .on("cocoon:before-remove", function() {
    console.log("before-remove");
  })
  .on("cocoon:after-remove", function() {
    /* e.g. recalculate order of child items */    
    console.log("after-remove");
  });


// 振り返り時の項目 動的変更
  var select_field = $('select[id^="review"]');
  $(select_field).change(function(){
    let state = this.value;
    let state_id = this.id;
    $.ajax({
      type: 'GET', // リクエストのタイプ
      url: '/reviews/change_state', // リクエストを送信するURL
      data:  { 'state' : state, 'id' : state_id }, // サーバーに送信するデータ
      dataType: 'json' // サーバーから返却される型
    })
    .done(function(data){ // dataにはレスポンスされたデータが入る
      const p1 = document.getElementById(`${data.id}_disp`);
      p1.classList.remove('visible','imvisible');
      if (data.state == "進行中"){
        p1.classList.add('visible');
      }else{
        p1.classList.add('imvisible');
      }
    })
  });
});