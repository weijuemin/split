// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
$(document).on('turbolinks:load', function(){
  $('.dropdown-toggle').dropdown();

  var modal = $('.modalWrap, .modal');
  modal.hide();
  $('.newgroup').on('click', function(){
    modal.fadeIn('fast');
  })
  $('.modalWrap').on('click', function(){
    modal.fadeOut('fast');
  })

  var modal1 = $('.modalWrap1, .modal1');
  modal1.hide();
  $('.newmember').on('click', function(){
    modal1.fadeIn('fast');
  })
  $('.modalWrap1').on('click', function(){
    modal1.fadeOut('fast');
  })

  $('#invite').on('keyup', function(){
    var searchVal = $(this).val();
    var html = "";
    $.ajax("/getusers?input="+searchVal).then(function(res){
      console.log(res);
      console.log(res.length);
      if (res.length > 0){
        html += "<table class='showUsers table'>";
        for (var i=0; i<res.length; i++){
          html += "<tr><td>" + res[i].first_name + " " + res[i].last_name + "</td>";
          html += "<td>" + res[i].email + "</td>";
          html += "<td><button class='adduser btn btn-info btn-xs'>Add</button></td>"
          html += "</tr>";
        }
        html += "</table>";
        console.log("HTML: "+html);
      }
      $('.inviteWrap').html(html);
    })
  })
})