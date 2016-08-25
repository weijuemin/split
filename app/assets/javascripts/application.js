//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
$(document).on('turbolinks:load', function(){
  $('.dropdown-toggle').dropdown();
  $('select[name="split"]').on('change', function(){
		if($('#percent').is(":selected")) {
			$('#amount_block').hide();
			$('#percent_block').fadeIn();
		} else if ($('#custom').is(":selected")) {
			$('#percent_block').hide();
			$('#amount_block').fadeIn();
		} else {
			$('#percent_block').fadeOut();
			$('#amount_block').fadeOut();
		}
	})

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
    var groupId = $(this).attr('data-groupId');
    $('.addMemF').attr("action", "/groups/"+groupId+"/members");
  })
  $('.modalWrap1').on('click', function(){
    modal1.fadeOut('fast');
  })
  $('#invite').on('keyup', function(){
    var path = window.location.pathname;
    var g_id = parseInt(path.substr(path.lastIndexOf('/') + 1));
    var searchVal = $(this).val();
    var html = "";
    $.ajax("/getusers?group="+g_id+"&input="+searchVal).then(function(res){
      console.log(res);
      if (res.length > 0){
        html += "<table class='showUsers table'>";
        for (var i=0; i<res.length; i++){
          html += "<tr><td class='name'><span class='fname'>" + res[i].first_name + "</span> <span class='lname'>" + res[i].last_name + "</span></td>";
          html += "<td>" + res[i].email + "</td>";
          html += "<td><span class='adduser btn btn-info btn-xs'>Add</span><span style='display:none;'>"+res[i].id+"</span></td>";
          html += "</tr>";
        }
        html += "</table>";
      }
      $('.inviteWrap').html(html);
    })
  })

  var userIds = [];
  $('body').on('click', '.adduser', function(e){
    var userId = $(e.target).siblings().text();
    userIds.push(userId);
    var ufname = $(e.target).parent().siblings('.name').children('.fname').text();
    var ulname = $(e.target).parent().siblings('.name').children('.lname').text();
    var user = "";
    user += "<p class='uobj'><input type='hidden' name='getUIds' data-uid='"+userId+"' class='addedU'>"+ufname+". "+ulname[0]+" <span class='removeAddedU btn btn-warning btn-xs'>X</span></p>";

  // should add duplicate check for added users later
    $('.inviteResult').append(user);
  })
  $('body').on('click', '.removeAddedU', function(){
    var idToRemove = $(this).siblings().attr('data-uid');
    userIds = $.grep(userIds, function(val){
      return val != idToRemove;
    })
    $(this).parent().remove();
  })
  $('.addMemF').on('submit', function(e){
    $('input[name="getUIds"]').attr('value', userIds);
    return true;
  })
})