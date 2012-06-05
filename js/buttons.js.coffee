$ ->
  
  window.button_bindings = () ->
  
  
    ###
    BUTTONS
    This makes a nice effect on mousedown.
    It should look like it goes in.
    ###
    b = $('.button')
  
    # On mousedown, make the button "go in."
    b.mousedown ->
      $(this).css(
        'background-color': 'rgb(50,50,50)'
        'box-shadow': '0px 0px 10px rgb(50,50,50)'
      )
    
    # On mouseup, return it to normal.
    b.mouseup ->
      $(this).css(
        'background-color': 'white'
        'box-shadow': '0px 0px 10px white'
      )
  
  
    ###
    TEXT BUTTON CLICK LISTER
    When the text button is clicked, custom slideToggle it,
    ajaxing in the correct text if page is down and clearing
    the text if the page is up. These functions are located in the
    text_button.js.coffee file.
    ###
    $('#text-button').click ->
    
      # If the page is down, make the ajax request
      # to get the correct text and custom slideToggle the page.
      if $('#page').hasClass( 'down' )
        window.get_text()
          
      # Else if the page is up, custom slideToggle the page
      # then get rid of the text that's hiding.
      else if $('#page').hasClass( 'up' )
        window.page_down()
    
      # Else something has gone horribly wrong,
      # And we should reset everything.
      else
        window.page_down_hard()

   
    ###
    NAV BUTTONS
    These two buttons, NAV RIGHT CLICK and NAV LEFT CLICK
    move the user to the right or left by moving the #pages ul
    to the left or right. It is controlled by the variable current_position
    which incriments or deincriments depending on which button is clicked.
    These buttons also disable the text custom slideToggle and, if the #page
    div is up, it slides it down. First we need to define the current_position variable
    to control the movement and the number_of_lis variable to aviod going too far.
    ###

    # The current_position variable controls the ul's position
    current_position = 0
  
    # The number of lis variable determines the number of 
    number_of_lis = $('li.page').size()
  
  
    ###
    NAV RIGHT BUTTON CLICK LISTENER
    On click, this button should "move the user right" by
    sending the ul#pages to the left. It should also tell
    the text button data-ajax_url which page is out front.
    ###  
    $('#nav-right-button').click ->
      current_position += 1
      window.move_user( current_position ) if window.is_page_down() is true and current_position < number_of_lis
      if current_position is number_of_lis
        window.bounce_user( current_position )
        current_position -= 1


    ###
    NAV LEFT BUTTON CLICK LISTENER
    On click, this button should "move the user left" by
    sending the ul#pages to the right. It should also tell
    the text button data-ajax_url which page is out front.
    ###  
    $('#nav-left-button').click ->
      current_position -= 1
      window.move_user( current_position ) if window.is_page_down() is true and current_position >= 0
      if current_position < 0
        window.bounce_user( current_position )
        current_position = 0

    
    