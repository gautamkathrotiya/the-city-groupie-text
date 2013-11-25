$(window).load(function() {

  var count_id = $('#count_id').val();
  
  if(count_id == 1)
   {
      window.console.log(1);
      var group_id = $('#group_id').val();
      getMembers(group_id);
   }
   
});

function getMembers(group_id)
  {
    $('#sendmail').removeAttr('disabled');
   $( "#sendmail" ).removeClass( "btn btn_disabled" ).addClass( "btn btn_go" );
   $('#message').removeAttr('readonly');

   var str ='<a href="#" id="checkall" class="btn btn_go btn_mini">Check All</a><a href="#" id="clearall" class="btn btn_go btn_mini" style="margin-left:7px;">Uncheck All</a><br/>';
    $.ajax({
          url: '/groupmember',
          data: {id: group_id},
          type: 'post',
          dataType: 'json',
        success: function(data)
        {
            str += '<fieldset><ul>';
          $.each(data,function(i,user){
              str += '<li class="grid-4-12"><label><input type="checkbox" class="riveruser" name="member[]" checked="checked" value="'+user.user_id+'">'+user.user_name+'</label></li>';
              
          });
            str += '</ul></fieldset>';
          $("#memberslist").html(str);
        }
    });  
  }

$(function(){

  $('#message').inputlimiter({
  limit: 80,
  boxId: 'messagelimitext',
  boxAttach: false
});

TheCity.PluginHelper.resizeIFrame({
  subdomain: 'YOUR CITY SUBDOMAIN',    //Change this to your City subdomain
  useSSL: true,       //Whether or not your plugin uses SSL
  extra: 450,           //Extra number of pixels to expand iFrame height to 
  refresh: 0        //How often to check for new documentHeight, 0 to disable
});

  $("#groupdrpdown").change(function(){

   var group_id = $( "select#groupdrpdown option:selected").val();
   if(group_id == 0)
   {
      $("#memberslist").html("<p>Please select group to view members</p>");
  }else{
    getMembers(group_id);
  }
     
  });

  
 
  $('#memberslist').on('click','#checkall',
    function() {
        $('.riveruser').prop('checked', true);
    }
);
  $('#memberslist').on('click','#clearall',

    function() {
        $('.riveruser').prop('checked', false);
        }
     );

	$("#sendmail").click(function(){
    $('#sendmail').attr('disabled','disabled');
    $( "#sendmail" ).removeClass( "btn btn_go" ).addClass( "btn btn_disabled" );
		$("#loading").html("<img src='/assets/ajax-loader.gif'/>");
    var checkedUser = $("input[name='member[]']:checked").map(function() { return this.value; }).get().join();
	window.console.log(checkedUser);
	var message = $("#message").val();
  $('#message').attr('readonly','readonly');
  if(checkedUser != '' && message != '')
  {
    var count_id = $('#count_id').val();
   if(count_id == 1)
   {
      var group_name = $('#group_name').val();
   }else{
      var group_name = $( "select#groupdrpdown option:selected").text();

   }
   var leader_name = $('#user_name').val();
	$.ajax({
                url: '/sendsms',
                data: {users_id: checkedUser,message:message,leader:leader_name,group:group_name},
                type: 'post',
                dataType: 'json',
        success: function(data)
        {
        	$("#loading").html("Successfully Sent");
        		window.console.log(data);
            $('#sendmail').removeAttr('disabled');
            $( "#sendmail" ).removeClass( "btn btn_disabled" ).addClass( "btn btn_go" );
            $('#message').removeAttr('readonly');
        }
    });
   }else{
    var group_id = $( "select#groupdrpdown option:selected").val();
    var count_id = $('#count_id').val();
    if(count_id == 1)
    {
      group_id = 1;
    }
    if(group_id == 0)
    {
      $("#loading").html("Please select a group and at least 1 member");
    }else if(message == ''){
      if(checkedUser == '')
        {
          $("#loading").html("Please enter message and select at least 1 member");
        }else{
          $("#loading").html("Please enter message");
        }
    }else{
      $("#loading").html("Please select at least 1 member");
    }
    $('#sendmail').removeAttr('disabled');
    $( "#sendmail" ).removeClass( "btn btn_disabled" ).addClass( "btn btn_go" );
    $('#message').removeAttr('readonly');
   }     
	});


})