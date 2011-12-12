

$(document).ready(function() {
	var menu = $("#ride_airport")[0]
	var ridetime = $(".time-div")
	menu.onchange = function() {
		if(menu.value === "From LAX" || menu.value === "From Ontario") {
			ridetime.toggle(500);
		}
		if(menu.value === "To LAX" || menu.value === "To Ontario") {
			ridetime.toggle(500);
		}
	}
})
