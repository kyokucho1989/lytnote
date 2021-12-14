$(document).on("page:load turbolinks:load", function() {
// cocoon callback
  const max_field_items = 5;
  $('#report_items').on('cocoon:before-insert', function(event) {
    console.log("before-insert");
    let size = $('#report_items .nested-fields').length;
    if (size == max_field_items) {
      console.log('max size');
      event.preventDefault();
    }
    console.log(size);
  })
  .on('cocoon:after-insert', function() {
    /* ... do something ... */    
    console.log("after-insert");
    let size = $('#report_items .nested-fields').length;
    console.log(size);
  })
  .on("cocoon:before-remove", function(event) {
    // console.log("before-remove");
    let size = $('#report_items .nested-fields').length;
    if (size == 1) {
      console.log('min size');
      event.preventDefault();
    }
    console.log(size);
  })
  .on("cocoon:after-remove", function() {
    /* e.g. recalculate order of child items */    
    console.log("after-remove");
    let size = $('#report_items .nested-fields').length;
    console.log(size);
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