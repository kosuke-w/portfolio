// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require popper
//= require bootstrap-sprockets

//= require jquery

//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .
/*global $*/
/*global gon*/
$(function () {

    // 緯度経度を取得
    const latlon_url = 'https://api.openweathermap.org/geo/1.0/direct?q=' + gon.address + '&appid=' + gon.key;

    $.ajax({
      url: latlon_url,
      dataType: "json",
      type: 'GET',
    })
    .done(function (latlon) {
      const lat = latlon[0].lat;
      const lon = latlon[0].lon;

      // 天気予報を取得
      const weather_url = 'https://api.openweathermap.org/data/2.5/onecall?lat=' + lat + '&lon=' + lon + '&exclude=current,minutely,hourly,alerts&units=metric&appid=' + gon.key;

      $.ajax({
          url: weather_url,
          dataType: 'json',
          type: 'GET',
        })
        .done(function (weather) {
          let insertHTML = '';

          for (let i = 0; i <= 6; i = i + 1) {
            insertHTML += buildHTML(weather, i);
          }
          $('#weather').html(insertHTML);
        })
        .fail(function (weather) {
          alert('天気予報の取得に失敗しました');
        });
    });
  });

  function buildHTML(weather, i) {
    //日付、時間を取得
    const date = new Date(weather.daily[i].dt * 1000);
    //UTCとの時差調整
    date.setHours(date.getHours() + 9);
    //月の情報を取得。0~11に1を足して1~12に変換。
    const month = date.getMonth() + 1;
    //曜日の日本語化。配列から取得
    const Week = new Array('(日)', '(月)', '(火)', '(水)', '(木)', '(金)', '(土)');
    //月＋日＋曜日をdayに代入。getDay()は0~6を返すためWeek配列内のインデックスに対応した文字列を取得
    const day = month + '/' + date.getDate() + Week[date.getDay()];
    //天気のアイコンを取得
    const icon = weather.daily[i].weather[0].icon;

    const html =
      '<div class="weather__content--report">' +
        '<img src="https://openweathermap.org/img/w/' + icon + '.png">' +
        '<span class="weather__content--report-date">' + day + "</span>" +
        '<div class="weather__content--report-temp-max">' + '最高：' + Math.round(weather.daily[i].temp.max) + "℃</div>" +
        '<span class="weather__content--report-temp-min">' + '最低：' + Math.floor(weather.daily[i].temp.min) + "℃</span>" +
      '</div>';
    return html;
  }