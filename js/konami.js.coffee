$ ->
  d = $(document)
  d.keypress ( e ) ->
    if e.keyCode is 38
      d.keypress ( e ) ->
        if e.keyCode is 38
          d.keypress ( e ) ->
            if e.keyCode is 40
              d.keypress ( e ) ->
                if e.keyCode is 40
                  d.keypress ( e ) ->
                    if e.keyCode is 37
                      d.keypress ( e ) ->
                        if e.keyCode is 39
                          d.keypress ( e ) ->
                            if e.keyCode is 37
                              d.keypress ( e ) ->
                                if e.keyCode is 39
                                  d.keypress ( e ) ->
                                    if e.charCode is 98
                                      d.keypress ( e ) ->
                                        if e.charCode is 97
                                          window.location = "http://www.youtube.com/watch?v=oHg5SJYRHA0&feature=player_embedded"