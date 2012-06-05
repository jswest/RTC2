$ ->
  current_position = 0
  window.set_ajax_url( current_position )
  $('ul#pages').width( $(window).width() * $('li.page').size() )
  $('li.page').width( $('ul#pages').width() / $('li.page').size() )
  $('nav.button').fadeIn(
    250
    ->
      window.button_bindings()
      $('li.page').fadeIn(
        500
      )
  )
      
  