$(document).ready(function() {

  //================  Initializing Selectizer ==============
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
  //================  End selectizer init ==============


  /* calculate height of section */
  function calcHeight(box){
    var _height = $(window).height();
    box.css( "min-height", _height);
  };
  calcHeight($("#gallery"));

  $(window).resize(function(){
    calcHeight($("#gallery"));
    var _width = $(window).innerWidth();
    if (_width > 768 && $('header').hasClass('active')){
      $('header').removeClass('active');
    };
    changeImageSize();
  });

  function changeImageSize(){
    var _width = $(window).innerWidth(),
        newHeight = _width/2;

    $("#photos-panoramio .owl-item img").each(function(){
      var theImage = new Image();
      theImage.src = $(this).attr("src");
      var imgWidth = theImage.width,
          imgHeight = theImage.height,
          dif = imgWidth/imgHeight;
      if(dif < 2.3){
        $(this).css( "height", newHeight);
      };
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

  //================  Initializing owlCarousel with custom JSON data   ==============
  var panoramio = $("#photos-panoramio");
  function initCarousel() {
    panoramio.owlCarousel({
      loop: true,
      items: 1,
      nav : true,
      dots: false,
      smartSpeed: 400,
      onInitialized: function(){
       $("#photos-panoramio .owl-item").each(function(){
          var titel = $(this).find('img').attr('alt');
          $(this).append('<p class="titel">' + titel + '</p>');
       });
      }
    });
  }

  if (panoramio.html().length == 0) {
    $.getJSON(
      '/get_photos?latitude=' + latitude + '&longitude=' + longitude,
      function(data) {
        var content = "";
        for(var i in data["photos"]){
          var img = data["photos"][i].photo_file_url;
          var alt = data["photos"][i].photo_title + ' by ' + data["photos"][i].owner_name;
          content += "<img src=\"" + img + "\" alt=\"" + escapeAlt(alt) + "\">";
        };

        if (content.length > 0){
          panoramio.html(content);
          setTimeout(function(){
            initCarousel();
            changeImageSize();
            panoramio.removeClass('loading');
          }, 1500);
        } else {
          panoramio.addClass('empty');
        };
      }
    );
  } else {
    initCarousel();
  }

  function escapeAlt(alt) {
    return alt.replace(/&/g, '&amp;')
              .replace(/>/g, '&gt;')
              .replace(/</g, '&lt;')
              .replace(/"/g, '&quot;')
              .replace(/'/g, '&apos;');
  }
  //=============== end initialization carousel ========================================

  //=============== Initialization for twitter buttons ====================
  button = $('.twitter-share-button');
  setTimeout(function(){
    button.attr('data-url', document.location.href);
    $.getScript("//platform.twitter.com/widgets.js", function() {
      twttr.widgets.load();
    });
  }, 100);
});
