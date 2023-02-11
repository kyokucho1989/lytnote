$(document).on("page:load turbolinks:load", function() {
// cocoon callback
  let size = $('#report_items .nested-fields').length;
  if (size == 1) {
    $("a.remove_fields").hide();
  }
  const max_field_items = 5;
  $('#report_items').on('cocoon:before-insert', function(event) {
    let size = $('#report_items .nested-fields').length;
    if (size == max_field_items) {
      event.preventDefault();
    }
    console.log(size);
  })
  .on('cocoon:after-insert', function() {
    $("a.remove_fields").show();
    let size = $('#report_items .nested-fields').length;
    if (size == max_field_items) {
      $("#report_items .links").hide();
    }
  })
  .on("cocoon:before-remove", function(event) {
    let size = $('#report_items .nested-fields').length;
    if (size == 1) {
      event.preventDefault();
    }
  })
  .on("cocoon:after-remove", function() {   
    $("#report_items .links").show();
    let size = $('#report_items .nested-fields').length;
    if (size == 1) {
      $("a.remove_fields").hide();
    }
  });


// 振り返り時の項目 動的変更
  var select_field = $('select[id^="review"]');
  $(select_field).change(function(){
    let state = this.value;
    let state_id = this.id;
    console.log(this);
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

  // 目標一覧の絞り込み
  var select_plan_field = $('select[id^="plan"]');
  $(select_plan_field).change(function(){
    let state = this.value;
    let state_id = this.id;
    console.log(this);
    $.ajax({
      type: 'GET', // リクエストのタイプ
      url: '/plan/change_state', // リクエストを送信するURL
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
  let reportedDays_json = document.getElementById('reported').value;
  if (reportedDays_json !== null) {
    let reportedDays = JSON.parse(reportedDays_json);
    $( "#datepicker" ).datepicker({
      beforeShowDay: function(date) {
          let formattedDay = dayjs(date).format('YYYY-MM-DD');
          if (reportedDays.indexOf(formattedDay) != -1) {
            return [false, 'reported-days', 'aa'];
          }else{
            return [false, '', ''];
          }
      }
    });
  }
});