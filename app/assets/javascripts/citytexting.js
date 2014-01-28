// Getting number of groups when page loads

$(window).load(function () {

    var count_id = $('#count_id').val();
    //Get user details automatically if user leader of one group
    if (count_id == 1) {
        window.console.log(1);
        var group_id = $('#group_id').val();
        getCount(group_id);
    }
});

/**
 * Get count of users based on group
 * @param {Number} group_id
 */

function getCount(group_id) {

    $("#memberslist").html("<img src='/assets/ajax-loader.gif'/> Checking to see who is in the group");
    $('#sendmail').removeAttr('disabled');
    $("#sendmail").removeClass("btn btn_disabled").addClass("btn btn_go");
    $('#message').removeAttr('readonly');

    $.ajax({
        url: '/groupcount',
        data: {id: group_id},
        type: 'post',
        dataType: 'json',
        success: function (data) {
            getMembers(group_id, data['count']);
        }
    });
}

/**
 * Get Members of group
 * @param {Number} group_id
 * @param {Number} page - total no of pages
 */

function getMembers(group_id, page) {
    var userDetails = new Array();

    var str = '<a href="#" id="checkall" class="btn btn_go btn_mini">Check All</a><a href="#" id="clearall" class="btn btn_go btn_mini" style="margin-left:7px;">Uncheck All</a><br/>';

    //Get members of group via AJAX
    $.ajax({
        url: '/groupmember',
        data: {id: group_id},
        type: 'post',
        dataType: 'json',
        success: function (data) {
            $.each(data, function (i, user) {
                userDetails.push({key: '"' + user.user_id + '"', name: user.user_name});
            });

            var sorted = userDetails.sort(function (a, b) {
                if (a.name < b.name) {
                    return -1;
                } else if (a.name > b.name) {
                    return 1;
                }
                return 0;
            });
            display_list(sorted);
        }
    });
}

function display_list(sorted){
    var str ='<a href="#" id="checkall" class="btn btn_go btn_mini">Check All</a><a href="#" id="clearall" class="btn btn_go btn_mini" style="margin-left:7px;">Uncheck All</a><br/>';
    str += '<fieldset><ul>';
    $.each(sorted,function(i,user){
        str += '<li class="grid-4-12"><label>';
        str += '<input type="checkbox" class="riveruser" name="member[]" checked="checked" value=' + user.key + ' />';
        str +=  user.name + '</label></li>';
    });
    str += '</ul></fieldset>';
    $("#memberslist").html(str);
}

/**
 * Send Mail/SMS Method
 */
function sendSMS(){
    $('#sendmail').attr('disabled', 'disabled');
    $("#sendmail").removeClass("btn btn_go").addClass("btn btn_disabled");
    $("#loading").html("<img src='/assets/ajax-loader.gif'/>");
    var checkedUser = $("input[name='member[]']:checked").map(function () {
        return this.value;
    }).get().join();
    var message = $("#message").val();
    $('#message').attr('readonly', 'readonly');
    if (checkedUser != '' && message != '') {
        var count_id = $('#count_id').val();
        if (count_id == 1) {
            var group_name = $('#group_name').val();
        } else {
            var group_name = $("select#groupdrpdown option:selected").text();
        }
        var leader_name = $('#user_name').val();
        $.ajax({
            url: '/sendsms',
            data: {users_id: checkedUser, message: message, leader: leader_name, group: group_name},
            type: 'post',
            dataType: 'json',
            success: function (data) {
                $("#loading").html("Successfully Sent");
                window.console.log(data);
                $('#sendmail').removeAttr('disabled');
                $("#sendmail").removeClass("btn btn_disabled").addClass("btn btn_go");
                $('#message').removeAttr('readonly');
            }
        });
    } else {
        var group_id = $("select#groupdrpdown option:selected").val();
        var count_id = $('#count_id').val();
        if (count_id == 1) {
            group_id = 1;
        }
        if (group_id == 0) {
            $("#loading").html("Please select a group and at least 1 member");
        } else if (message == '') {
            if (checkedUser == '') {
                $("#loading").html("Please enter message and select at least 1 member");
            } else {
                $("#loading").html("Please enter message");
            }
        } else {
            $("#loading").html("Please select at least 1 member");
        }
        $('#sendmail').removeAttr('disabled');
        $("#sendmail").removeClass("btn btn_disabled").addClass("btn btn_go");
        $('#message').removeAttr('readonly');
    }
}

$(function () {

    /**
     * Textarea inputlimiter function
     */
    $('#message').inputlimiter({
        limit: 80,
        boxId: 'messagelimitext',
        boxAttach: false
    });

    // Resize iframe city plugin method
    TheCity.PluginHelper.resizeIFrame({
        subdomain: '2rc',    //Change this to your City subdomain
        useSSL: true,       //Whether or not your plugin uses SSL
        extra: 450,           //Extra number of pixels to expand iFrame height to
        refresh: 0        //How often to check for new documentHeight, 0 to disable
    });

// If Change group call members list based on groups
    $("#groupdrpdown").change(function () {
        var group_id = $("select#groupdrpdown option:selected").val();
        if (group_id == 0) {
            $("#memberslist").html("<p>Please select group to view members</p>");
        } else {
            getCount(group_id);
        }
    });


    $('#memberslist').on('click', '#checkall',
        function () {
            $('.riveruser').prop('checked', true);
        }
    );

    $('#memberslist').on('click', '#clearall',
        function () {
            $('.riveruser').prop('checked', false);
        }
    );
})