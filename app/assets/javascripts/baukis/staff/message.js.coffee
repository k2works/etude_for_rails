$(document).on 'turbolinks:load', ->
  if $('#number-of-unprocessed-messages').length
    window.setInterval(update_number_of_unprocessed_mesbsages, 1000 * 60 )

update_number_of_unprocessed_mesbsages = ->
  $.get window.path_for("count_baukis_staff_messages"), (data) ->
    $('#number-of-unprocessed-messages').text "(#{data})"
