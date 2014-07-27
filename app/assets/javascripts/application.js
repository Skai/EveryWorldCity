// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

jQuery(document).on('click', '#contact-button', function() {
	
	contact = $('#contact');
	
	if (contact.hasClass('active')) {
		contact.removeClass('active').addClass('display-none');
	} else {
 		contact.addClass('active').removeClass('display-none');
	}
	 
	if (contact.children().length == 0){
		$.ajax({
  			url: "contacts/new",
		}).done(function(data) {
			contact.addClass('active').removeClass('display-none').html(data);
		})
	}

	return false;
});