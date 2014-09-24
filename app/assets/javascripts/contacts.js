$(document).on("ajax:success", "form.new_contact", function(e, data, status, xhr) {
	closeBtnHtml =  '<a href="" id="btn-close">Close X</a>';
	errorMsg = 'Oppps! Something went wrong. Please check your email address and try again.';
	if (data.success == true) {
    	$('#contact').html('Thank you!' + closeBtnHtml);
	} else {
    	$('#contact p.message').html(errorMsg);
	}
}).on('ajax:error', function(e, data, status, xhr) {
    $('#contact').html(errorMsg);
});

$(document).on('page:change', function() {
	//open contact form.
	jQuery(document).on('click', '#contact-button', function() {
		contact = $('#contact');
		if (contact.children().length <= 1){			
			$.ajax({
	  			url: "contacts/new",
			}).done(function(data) {
				contact.html(data);	
			});
		}
		return false;
	});

  	$('#contact-button').click(function(e){
    	e.preventDefault();
    	$('body').toggleClass('contact-active');
  	});

  	$('body').on('click','#btn-close',function(e){
    	e.preventDefault();
    	$('body').removeClass('contact-active');
  	});
});
