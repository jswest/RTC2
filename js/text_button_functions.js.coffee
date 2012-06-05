$ ->
  
  ###
  TEXT BUTTON FUNCTIONS
  These are the functions that control the text-button actions.
  There are five of them: PAGE UP, which moves the page up. GET TEXT,
  which ajaxes in the correct text and the calles PAGE UP. REMOVE TEXT,
  which cleans up all the text in the hidden text area. PAGE DOWN, which moves
  the page down and calls REMOVE TEXT. Lastly, there's PAGE DOWN HARD, which puts
  the page down, hard; this is called in emergencies (e.g. the user broke something
  in the UI). These are called from the buttons.js.coffee file.
  ###

  # Define the slideToggle speed variable, which says how fast to custom slideToggle
  slideToggle_speed = 500
  
  
  ###
  THE PAGE UP FUNCTION
  This function moves the page up, revealing the hidden text.
  It controls the requisite classes, and it is called by the
  get text function (see below).
  ###
  window.page_up = () ->

    # First, we need to calculate how to preserve access to the buttons
    # and also set the margin_top of the #hidden-text-wrapper.
    margin_top = ( $('.button').size() * parseInt( $('.button').css( 'height' ) ) ) # The height of all of the buttons
    margin_top += $('#buttons-wrapper').position().top * 2                          # Center the buttons within the sliver remaining after the slideToggle
    margin_top += parseInt( $('.button').eq( 1 ).css( 'margin-top' ) )              # Get the margin-top of the non-first buttons
  
    # Set the margin_top of the hidden-text-wrapper div
    $('#hidden-text-wrapper').css( 'top', margin_top ) 
  
    # Make it the proper negative number
    margin_top = -$('#page').height() + margin_top
  
    # The custom slideToggle making sure to deal with the classes.
    $('#page').animate(
      {
        'margin-top': margin_top   # SlideToggle, but only enough so that the buttons still show
      } 
      slideToggle_speed                                   # Set the speed with which the toggle happens
      ->                                                  # Its callback function...
      
        # Control the classes
        $('#page').removeClass( 'down' )
        $('#page').addClass( 'up' )
    )

   
  ###
  THE GET TEXT FUNCTION
  This function actually does the work of getting the text and putting it
  Into the hidden text div. It makes an ajax request based on the data-ajax_url
  attached to the text button (if that is false, it disables the button).
  It then parses that data so that everything goes
  into the right place. Lastly, it calls the page up function revealing the text.
  ###
  window.get_text = () ->
    
    # If there is, in fact, an ajax_url, go ahead and get the text
    if $('nav#text-button').data( 'ajax_url' )
            
      # Make the ajax request
      $.ajax
        method:   'POST'                                     # Use the POST method
        dataType: 'html'                                     # Grab an HTML file
        url:      $('nav#text-button').data( 'ajax_url' )    # Get the ajax url from the nav_button
        success:  ( data ) ->                                # On success...
                    
          # Parse the data file into its title and p tags,
          # then add the text to the header and body
          header_text = data.substring( 0, data.indexOf( "</h1>" ) + 5 )
          body_text = data.substring( data.indexOf( "<p>" ) )
          $('header#hidden-text-header hgroup').html( header_text )
          $('#hidden-text-content').html( body_text )
      
          # Call the custom slideToggle function (see above).
          window.page_up()
    
    # If there isn't an ajax_url, then disable the button
    # TODO: ADD SOME IMAGE (MAYBE AN "X")
    else
      console.log "Something will happen to the button here"
    
      
  ###
  THE REMOVE TEXT FUNCTION
  This function cleans up the text that's in the hidden text div.
  Just in case the user manages to trick the js, this ensures that
  they don't see something they're not supposed to.
  ###
  window.remove_text = () ->
    
    # Get rid of the title
    $('header#hidden-text-header').find( 'hgroup' ).html( '' )
    
    # Get rid of the content
    $('#hidden-text-content').html( '' )
    
    
  ###
  THE PAGE DOWN FUNCTION
  This function moves the page down, controlling the classes.
  It then calls the remove text function, which cleans up the
  hidden text.
  ###
  window.page_down = () ->
  
    # The custom slideToggle,
    # making sure to deal with the classes and get rid of the hidden text.
    $('#page').animate(
      { 'margin-top': 0 } # Set the margin-top to 0, effectively putting the page back in place
      slideToggle_speed   # Set the speed with which the toggle happens
      ->                  # Its callback function...
      
        # Control the classes
        $('#page').removeClass( 'up' )
        $('#page').addClass( 'down' )
      
        # Get rid of the hidden text
        window.remove_text()
    )
  
  
  ###
  THE PAGE DOWN HARD FUNCTION
  This function puts the page down, hard. It's called
  in case the user tricks the js somehow (e.g. by doubleclicking in a slow browser).
  It just hard-sets the css--instead of animating--and then it controls the classes
  ###
  window.page_down_hard = () ->
    
    # Put the page down
    $('#page').css( 'margin-top', 0 )
    
    # Control the classes
    $('#page').removeClass( 'up' )
    $('#page').addClass( 'down' )
  
