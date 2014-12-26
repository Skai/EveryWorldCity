$(document).on('page:change', function() {
  var xhr, select_country, $select_country, select_city, $select_city;

  $select_country = jQuery('#select-country').selectize({
    onChange: function(value) {
      if (!value.length) {
       return;
      }
      select_city.disable();
      select_city.clearOptions();
      select_city.load(function(callback) {
        xhr && xhr.abort();
        xhr = jQuery.ajax({
          url: '/get_cities/' + value,
          success: function(results) {
            select_city.enable();
            callback(results);
          },
          error: function() {
            callback();
          }
        })
      });
    }
  });

  $select_city = jQuery('#select-city').selectize({
    valueField: 'friendly_url',
    labelField: 'city',
    searchField: ['city'],
    onChange: function() {
      location.href = this.getValue();
    }
  });

  

  select_city  = $select_city[0].selectize;
  select_country = $select_country[0].selectize;

  var selectedCountry = jQuery('#select-country').val();  
  if(selectedCountry.length){
    select_country.setValue(selectedCountry);
  };
  //select_city.disable();

  /* calculate height of section */
  function calcHeight(box){
    var _height = $(window).height();
    box.css( "min-height", _height);
  };
  calcHeight($("#gallery"));

  $(window).resize(function(){
    calcHeight($("#gallery"));
    var _width = $(window).innerWidth();    
    if (_width > 767 && $('header').hasClass('active')){
      $('header').removeClass('active');
    };    
    changeImageHeight();
  });

  function changeImageHeight(){
    var _width = $(window).innerWidth(),
        newHeight = _width/2;

    $("#photos-panoramio .owl-item img").each(function(){
        $(this).one("load", function() {
          var theImage = new Image();
          theImage.src = $(this).attr("src");
          var imgWidth = theImage.width,
              imgHeight = theImage.height,      
              dif = imgWidth/imgHeight;
        if(dif < 2.3){
          $(this).css( "height", newHeight);
        };
        //$(this).parents('.owl-item').addClass('alt');
      });      
    });
  };

  /* sticky header */
  $(window).scroll(function() {
    var h = $('#gallery').height();
    if ($(this).scrollTop() > h){  
        $('#header').addClass("sticky");
      }else{
        $('#header').removeClass("sticky");
      }
  });

  $('#toggle-search').on('click', function(){
    $('#header').toggleClass('active');
  });

  //Initializing  owlCarousel with custom JSON data.
  $("#photos-panoramio").owlCarousel({
    jsonPath : '/get_photos?latitude=' + latitude + '&longitude=' + longitude,
    jsonSuccess : customDataSuccess,
    responsive: true,
    singleItem:true,
    navigation : true,
    pagination: false,
    autoHeight : false,
    slideSpeed: 500,
    afterInit: function(){
     $("#photos-panoramio .owl-item").each(function(){
        var titel = $(this).find('img').attr('alt');
        $(this).append('<p class="titel">' + titel + '</p>');
     });
     changeImageHeight();
    }
  });
  function customDataSuccess(data){
    var content = "";
    for(var i in data["photos"]){
      var img = data["photos"][i].photo_file_url;
      var alt = data["photos"][i].photo_title + ' by ' + data["photos"][i].owner_name;
      var escapedAlt = alt.replace(/&/g, '&amp;')
                      .replace(/>/g, '&gt;')
                      .replace(/</g, '&lt;')
                      .replace(/"/g, '&quot;')
                      .replace(/'/g, '&apos;');
      content += "<img src=\"" + img + "\" alt=\"" + escapedAlt + "\">";
    };
    if(content.length > 0){
      $("#photos-panoramio").html(content).css('padding-bottom','0');      
      setTimeout(function(){
        $('#photos-panoramio').removeClass('loading');
      }, 1800);
    }else{
      $('#photos-panoramio').removeClass('loading');
    };    
  };

  //Initialization for twitter and facebook buttons.
  button = $('.twitter-share-button');
  setTimeout(function(){
    button.attr('data-url', document.location.href);
    $.getScript("//platform.twitter.com/widgets.js", function() {
      twttr.widgets.load();
    });
  }, 100);
});