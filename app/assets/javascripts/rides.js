

$(document).ready(function() {
	var menu = $("#ride_airport")[0]
	var ridetime = $(".time-div")
	var title = $('title')[0].text
	if (title === "5C ride share :: Home") {
		$('#nav').hide()
	} 
	
	currentPage(title)
	
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
		case "Rides to LAX":
			nav.eq(2).addClass('current-page')
			break
		case "Rides from LAX":
			nav.eq(3).addClass('current-page')
			break
		case "Rides to Ontario":
			nav.first().addClass('current-page')
			break
		case "Rides from Ontario":
			nav.eq(1).addClass('current-page')
			break
		case "5C ride share :: new":
			$("#create-new-ride a").addClass('current-page')
			break
	}
}

function alternateBackgrounds() {
	$(".ride-container:odd").addClass("dark")
	$(".ride-container:even").addClass("light")
}
