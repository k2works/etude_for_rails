$(document).on 'turbolinks:load', ->
  if $('#number-of-unprocessed-messages').length
    window.setInterval(update_number_of_unprocessed_mesbsages, 1000 * 60 )

update_number_of_unprocessed_mesbsages = ->
  $.get window.paths.number_of_unprocessed_messages, (data) ->
    $('#number-of-unprocessed-messages').text "(#{data})"
