window.fbAsyncInit = function() {
  FB.init({
    appId      : '300857556614018', // App ID
    channelUrl : '//localhost:3000/channel.html', // Channel File
    status     : true, // check login status
    cookie     : true, // enable cookies to allow the server to access the session
    xfbml      : true  // parse XFBML
  });

  // Additional initialization code here
	
	FB.Event.subscribe('comment.create', function (response) {
		commentMailer(response, current_user_id)
	})
};

// Load the SDK Asynchronously
(function(d){
   var js, id = 'facebook-jssdk'; if (d.getElementById(id)) {return;}
   js = d.createElement('script'); js.id = id; js.async = true;
   js.src = "//connect.facebook.net/en_US/all.js";
   d.getElementsByTagName('head')[0].appendChild(js);
 }(document));

$(document).ready(function() {
	var menu = $("#ride_airport")[0]
	var ridetime = $(".time-div")
	var title = $('title')[0].text
	if (title === "5C ride share :: Home") {
		$('#nav').hide()
	} 
	
	currentPage(title)
	centerNewRide(current_user_id)
	userRides()
	
	if(menu != undefined) {
		menu.onchange = function() {
			if(menu.value === "From LAX" || menu.value === "From Ontario") {
				ridetime.hide(500);
			}
			if(menu.value === "To LAX" || menu.value === "To Ontario") {
				ridetime.show(500);
			}
		}
	}
	
	if ($("#rides") != undefined) {
		alternateBackgrounds()
	}
	
});



function currentPage(title) {
	var nav = $('#nav').children()
	switch(title) {
		case "5C ride share :: to LAX":
			nav.eq(2).addClass('current-page')
			break
		case "5C ride share :: from LAX":
			nav.eq(3).addClass('current-page')
			break
		case "5C ride share :: to ontario":
			nav.first().addClass('current-page')
			break
		case "5C ride share :: from ontario":
			nav.eq(1).addClass('current-page')
			break
		case "5C ride share :: new":
			$("#create-new-ride").children().eq(1).addClass('current-page')
			break
		case "5C ride share :: settings":
			$("#create-new-ride").children().eq(0).addClass('current-page')
			break
		case "5C ride share :: your rides":
			$("#create-new-ride").children().eq(2).addClass('current-page')
			break
	}
}

function alternateBackgrounds() {
	$(".ride-container:odd").addClass("dark")
	$(".ride-container:even").addClass("light")
}

function centerNewRide(current_user_id) {
	if (current_user_id == -1) {
		$("#create-new-ride a").css(
			{
				"float": "none",
				"width": "auto"
			});
		$(".main-container").css("margin-top", "20px")
	}
}

function commentMailer(response, current_user_id) {
	if (current_user_id !== -1) {
		$.post(
			'/mailer/comment',
			{
				'c_id': current_user_id,
				'url': response.href
			}
		);
	}
}

function userRides() {
	var rides = $(".member")
	var ride_links = $(".member a")
	for(i = 0; i < rides.size(); i++) {
		var ride_container = rides.eq(i)
		var ride_id =  ride_links.eq(i).attr('href').split("/")[2]
		var leave_link = "<a class = 'leave' href = '/rides/leave/?id=" + ride_id + "'>leave ride</a>"
		var offset = ride_container.offset()
		var left = offset.left
		var top = offset.top
		ride_container.prepend("<div></div>")
		var divv = ride_container.children().first()
		divv.css(
			{
				'position': 'absolute',
				'width': '100px',
				'height': '40px',
				'top': (top),
				'left': (left+900),
				'z-index': '10'
			})
		divv.prepend(leave_link)
	}
}


