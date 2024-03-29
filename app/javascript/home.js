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
    // console.log(this);
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
    // console.log(this);
    $.ajax({
      type: 'GET', // リクエストのタイプ
      url: '/plan', // リクエストを送信するURL
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
  let reportedDaysValue = document.getElementById('reported');
  let reportsValue = document.getElementById('reported_array');
  let reportedDays_json;
  let reports_json;
  if (document.getElementById('reported') !== null){
    reportedDays_json = reportedDaysValue.value;
    reports_json = reportsValue.value;
  }

  if (document.getElementById('reported') !== null) {
  //  let reports = JSON.parse(gireports);
    let reportedDays = JSON.parse(reportedDays_json);
    let reportedWeeks = reportedDays.map(function(dateString) {
      const date = dayjs(dateString);
      // 月曜日に変更する
      const monday = date.startOf('week');
      return monday.format('YYYY-MM-DD');
    });
    $( "#datepicker-report" ).datepicker({
      beforeShowDay: function(date) {
          let formattedDay = dayjs(date).format('YYYY-MM-DD');
          if (reportedDays.indexOf(formattedDay) != -1) {
            return [false, 'reported-days', 'aa'];
          }else{
            return [false, '', ''];
          }
      },
      onChangeMonthYear: function(year, month, inst) {
        // ここに、カレンダーの月が変更されたときに実行する処理を記述します
        // console.log("The month has changed to " + month + "-" + year);
        $.ajax({
          type: 'GET', // リクエストのタイプ
          url: '/reports/filter_report', // リクエストを送信するURL
          data:  { 'year' : year, 'month' : month }, // サーバーに送信するデータ
          dataType: 'script' // サーバーから返却される型
        })
        .done(function(data){ // dataにはレスポンスされたデータが入る
          //console.log(data);
          //const p1 = document.getElementById(`${data.id}_disp`);
        })
      }
    });

    $( "#datepicker-review" ).datepicker({
      beforeShowDay: function(date) {
          let weeksBeginningDate =dayjs(date).startOf('week');
          let formattedDay = weeksBeginningDate.format('YYYY-MM-DD');
          if (reportedWeeks.indexOf(formattedDay) != -1) {
            return [false, 'reported-days', 'aa'];
          }else{
            return [false, '', ''];
          }
      },
      onChangeMonthYear: function(year, month, inst) {
        // ここに、カレンダーの月が変更されたときに実行する処理を記述します
        // console.log("The month has changed to " + month + "-" + year);
        $.ajax({
          type: 'GET', // リクエストのタイプ
          url: '/reviews/filter_review', // リクエストを送信するURL
          data:  { 'year' : year, 'month' : month }, // サーバーに送信するデータ
          dataType: 'script' // サーバーから返却される型
        })
        .done(function(data){ // dataにはレスポンスされたデータが入る
          //console.log(data);
          //const p1 = document.getElementById(`${data.id}_disp`);
        })
      }
    });
  }

  // 日報をクリップボードへコピーする機能
  const copyReportButtons = document.querySelectorAll('.js-copy-report');
  if (document.querySelectorAll('.js-copy-report') !== null){
    copyReportButtons.forEach(function(button) {
      const reportId = button.dataset.reportId;
    
      button.addEventListener('click', function(event) {
        event.preventDefault();
        button.textContent = 'Copied!';
        setTimeout(() => {
          button.innerHTML = `<i class="far fa-clipboard mr-1"></i>COPY`;
        }, 1000);
        copyText = document.querySelector(`[share-report-id="${reportId}"]`).textContent;
        copyToClipboard(copyText);
      });
    });
  }

    // 振り返りをクリップボードへコピーする機能
    const copyReviewButtons = document.querySelectorAll('.js-copy-review');
    if (document.querySelectorAll('.js-copy-review') !== null){
      copyReviewButtons.forEach(function(button) {
        const reviewId = button.dataset.reviewId;
      
        button.addEventListener('click', function(event) {
          event.preventDefault();
          button.textContent = 'Copied!';
          setTimeout(() => {
            button.innerHTML = `<i class="far fa-clipboard mr-1"></i>COPY`;
          }, 1000);
          copyText = document.querySelector(`[share-review-id="${reviewId}"]`).textContent;
          copyToClipboard(copyText);
        });
      });
    }


  // 目標をクリップボードへコピーする機能
  const copyPlanButton = document.querySelector('.js-copy-plan');
  if (document.querySelector('.js-copy-plan') !== null){
    
    copyPlanButton.addEventListener('click', function(event) {
      event.preventDefault();
      copyPlanButton.textContent = 'Copied!';
      setTimeout(() => {
        copyPlanButton.innerHTML = `<i class="far fa-clipboard mr-1"></i>COPY`;
      }, 1000);
      copyTextArray = document.querySelectorAll('.share-plan');
      copyText = "目標\n";
      copyTextArray.forEach((item) =>{
        copyText += item.textContent + '\n';
      });
      copyToClipboard(copyText);
    });
  }
});

function copyToClipboard(text) {
  navigator.clipboard.writeText(text)
    .then(() => {
      // console.log('Copied to clipboard');
    })
    .catch((error) => {
      // console.error('Failed to copy to clipboard', error);
    });
}