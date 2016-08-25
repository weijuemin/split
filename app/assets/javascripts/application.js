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
    var searchVal = $(this).val();
    var html = "";
    $.ajax("/getusers?input="+searchVal).then(function(res){
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

  $(document).on('click', '.adduser', function(e){
    var userId = $(e.target).siblings().val();
    var ufname = $(e.target).parent().siblings('.name').children('.fname').text();
    var ulname = $(e.target).parent().siblings('.name').children('.lname').text();
    var user = "";
    user += "<p class='uobj'><input type='hidden' name='getUName' class='addedU' value='"+userId+"'>"+ufname+". "+ulname[0]+" <span class='removeAddedU btn btn-warning btn-xs'>X</span></p>";

  // should add duplicate check for added users later
    $('.inviteResult').append(user);
  })

  $(document).on('click', '.removeAddedU', function(){
    $(this).parent().remove();
  })

})