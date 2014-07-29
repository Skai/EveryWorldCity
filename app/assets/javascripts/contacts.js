$('form.new_contact').on('ajax:success',function(event, data, status, xhr){
    if (data.success == true) {
      $('#contact').html('Thank you!');
    }
});