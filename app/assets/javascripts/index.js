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

  $('.open-qbox').click(function(e){
    e.preventDefault();
    $('#footer').toggleClass('active');
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
    $(".section").css( "height", _height);
  };
  calcHeight();

  $(window).resize(calcHeight);

  /* sticky header */
  $(window).scroll(function() {
    if ($(this).scrollTop() > 100){  
        $('#header').addClass("sticky");
      }
      else{
        $('#header').removeClass("sticky");
      }
  });

  $('#toggle-search').on('click', function(){
    $('#header').toggleClass('active');
  });
});
