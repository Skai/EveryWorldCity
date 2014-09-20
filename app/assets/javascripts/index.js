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
  select_city.disable();

  $('#contact-button').click(function(e){
    e.preventDefault();
    //$('body').toggleClass('stop-scrolling');
    $('body').toggleClass('contact-active');
     //$('body').unbind('touchmove');
    //$('body.stop-scrolling').bind('touchmove', function(e){e.preventDefault()});
  });

  $('body').on('click','#btn-close',function(e){
    e.preventDefault();
    $('body').removeClass('contact-active');
  });

  // scrolling Page to top with a lot of content
  $('#nav a').click(function(){
    var goal = $(this).attr('href');
    highlightCurrentItem();
    scrollPage(goal);
    return false;
  });

  function scrollPage(id){
    $('html, body').animate({
      scrollTop: $(id).offset().top      
     }, 1000);    
  };

  // highlightCurrentItem active nav item 
  function highlightCurrentItem() {
    var h = $(".section:first").height();
    var sIndex = Math.floor($(window).scrollTop() / h);    
    if(sIndex > 2) sIndex = 2;     /* hardcode*/
    var $sItem = $("#nav li").eq(sIndex);
    if (!$sItem.hasClass("active")) {
        $("#nav li.active").removeClass("active");
        $sItem.addClass('active');
    }    
  };

  highlightCurrentItem();

  $(window).scroll(function(e) {
      highlightCurrentItem();
  });  

  /* calculate height of section */
  function calcHeight(){
    var _height = $(window).height();
    $(".section").css( "min-height", _height);
  };
  calcHeight();

  $(window).resize(function(){
    calcHeight();
    var _width = $(window).innerWidth();    
    if (_width > 767 && $('header').hasClass('active')){
      $('header').removeClass('active');
    };    
    changeImageHeight();
  });

  function changeImageHeight(){
    var _width = $(window).innerWidth(),
        newHeight = _width/2;
    $('#photos-panoramio .owl-item img').css( "height", newHeight);
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
    lazyLoad : true,
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
      if (data['photos'][i].height < 2500 && data['photos'][i].width < 2500) {
        var img = data["photos"][i].photo_file_url;
        var alt = data["photos"][i].photo_title + ' by ' + data["photos"][i].owner_name;
        content += "<img src=\"" +img+ "\" alt=\"" +alt+ "\">";
      }
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