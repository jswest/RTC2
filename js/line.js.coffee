$ ->
  
  # THE OPENING LINE ANIMATION
  l = $('nav#opening-line')
  animate_line = () ->
    l.animate(
      {
        width: '100%'
      }
      2000
      ->
        l.animate(
          {
            height: '20px'
          }
          500
          ->
            l.find('li').show()
        )
    )
  
  # THE HEADER ANIMATION
  h = $('header#primary-header')
  animate_header = () ->
    h.slideToggle(
      2000
    )
  
  # BG ANIMATIONS 
  bg = $('#bg')
  bgw = bg.width()
  bgh = bg.height()
  
  # RESIZE BG
  resize_bg = () ->
    ww = $(window).width()
    wh = $(window).height()
    if ( wh / ww ) < ( bgh / bgw )
      bg.width( ww )
      bg.height( ww * ( bgh / bgw ) )
    else
      bg.height( wh )
      bg.width( wh * ( bgw / bgh ) )
   
  # BG FADE IN
  resize_bg() 
  bg.fadeIn(
    2000
    ->
      animate_header()  
      animate_line()
      $(window).resize ->
        resize_bg()       
  )
  

          
      