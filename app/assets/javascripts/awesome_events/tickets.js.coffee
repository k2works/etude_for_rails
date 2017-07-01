$(document).on 'ajax:success', '#createTicket', (e) ->
  location.reload()

$(document).on 'ajax:error', '#createTicket', (event) ->
  detail = event.detail;
  data = detail[0]
  status = detail[1]
  xhr = detail[2];

  form = $('#new_ticket .modal-body')
  div = $('<div id="createTicketErrors" class="alert alert-danger"></div>')
  ul = $('<ul></ul>')
  for message in data.message
    li = $('<li></li>').text(message)
    ul.append(li)

  if $('#createTicketErrors')[0]
    $('#createTicketErrors').html(ul)
  else
    div.append(ul)
    form.prepend(div)
