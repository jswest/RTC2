$ ->
  
  ###
  NAV BUTTONS FUNCTIONS
  These are the functions that control the nav button, allowing it
  to move the user left and right. We need to define the speed with which the
  user is moved, which is stored in the move_user_speed variable.
  ###
  
  # The move_user_speed and bounce_user_spped variables controls the speed with which the user is jerked around.
  move_user_speed = 500
  bounce_user_speed = 200
  
  # The bounce amount variable determines how far to bounce if the user goes the wrong way.
  bounce_amount = 200
  
  ###
  THE IS PAGE DOWN FUNCTION
  This function checks to see if the page is down, and if it isn't, it puts it down.
  Once it's done that, it returns true.
  ###
  window.is_page_down = () ->
    
    # Check if the page is down
    window.page_down() unless $('page').hasClass( 'down' )
    
    # Return true once it is.
    return true    


  ###
  THE SET AJAX URL FUNCTION
  This function sets the ajax url of the text button
  Or it disables the function depending on the array,
  pages, which uses the li.page elements as a sort of
  database that holds each element's position in the
  ul#pages and its ajax_url (or false if there is no
  ajax url, which will eventually cause the text button
  to be disabled).
  ###
  window.set_ajax_url = ( current_position ) ->

    current_page = []
    # Grab the ajax_url of the li.page with the same position as the current_position
    # We have to loop through all the lis and find the correct one that way.
    $('li.page').each ->
      if $(this).data( 'position' ) is current_position
        current_page = $(this)
    
    # Now we set the text button's url. The text-button data-ajax_url gets set to false
    # if the current_page's is false. The if control is done in window.get_text() in
    # text_button_functions.js.coffee.
    $('nav#text-button').data( 'ajax_url', current_page.data( 'ajax_url' ) )
      

  ###
  THE MOVE USER FUNCTION
  This function takes the current_position, which is incremented if the user wants to go
  right and deincrimented if the user wants to go left. It then changes the position.left
  of the ul#pages.
  ###
  window.move_user = ( current_position ) -> # TODO: ADD A CALLBACK?
    
    # Animate the ul#pages element.
    $('ul#pages').animate(
      'left': -$(window).width() * current_position   # How far to move
      move_user_speed                                 # The speed with which to move
      ->                                              # The callback...
        
        # The callback calls the SET AJAX URL function, which will
        # properly set the ajax url of the text button for whichever li
        # is now being displayed (see above)
        window.set_ajax_url( current_position )
    )
  
  ###
  THE BOUNCE USER FUNCTION
  This function takes the current position and the bounce amount. From the current
  position it determines if is should bounce the user left or right, and from the
  bounce amount it bounces. It then bounces back.
  ###
  window.bounce_user = ( current_position ) ->
    
    # If the current user is 0
    # or, in other words, if the user is going to bounce left,
    # move the user left then right.
    if current_position is -1
      
      # Animate the ul#pages right (move the user left)
      # by the bounce_amount and at the bounce_speed
      $('ul#pages').animate(
        'left': bounce_amount # left is set to the bounce amount
        bounce_user_speed     # the speed with which it bounces
        ->                    # the callback...
        
          # Animate the ul#pages left by the bounce_amount (move the user back right)
          # by the bounce_amount and at the bounce_speed
          $('ul#pages').animate(
            'left': 0         # left is reset to 0
            bounce_user_speed # the speed with which it bounces
          )
      )
      
    # Else, or, in other words, if the user is going to bounce right,
    # move the user right and then left.
    else
    
      # Animate the ul#pages left (move the user right)
      # by the bounce_amount and at the bounce_speed
      $('ul#pages').animate(
        'left': -( $(window).width() * ( current_position - 1 ) ) - bounce_amount  # left is set to the neg width of the current slide - the bounce amount
        bounce_user_speed                                                  # the speed with which the user is moved left
        ->                                                                 # the callback...
          
          # Animate the ul#pages right (move the user left)
          # by the bounce_amount and at the bounce_speed
          $('ul#pages').animate(
            'left': -( $(window).width() * ( current_position - 1 ) ) # reset the ul#pages position.left to the last slide.   
            bounce_user_speed                                 # the speed with which the user is moved right
          )
      )
  
    