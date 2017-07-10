$(document).on 'turbolinks:load', ->
  $('form.edit_customer_form').on 'click', '#enable-password-field', ->
    $('#enable-password-field').hide()
    $('#disable-password-field').show()
    $('#baukis_staff_customer_form_customer_password').removeAttr('disabled')
    $('#baukis_staff_customer_form_customer_password').removeClass('disable')
    $('#baukis_staff_customer_form_customer_password').addClass('enable')
    $('label[for=baukis_staff_customer_form_customer_password').addClass('required')
  $('form.edit_customer_form').on 'click', '#disable-password-field', ->
    $('#disable-password-field').hide()
    $('#enable-password-field').show()
    $('#baukis_staff_customer_form_customer_password').attr('disabled', 'disabled')
    $('label[for=baukis_staff_customer_form_customer_password]').removeClass('required')
    $('#baukis_staff_customer_form_customer_password').addClass('disable')
    $('#baukis_staff_customer_form_customer_password').removeClass('enable')
  toggle_home_address_fields()
  toggle_work_address_fields()
  $('input#form_inputs_home_address').on 'click', ->
    toggle_home_address_fields()
  $('input#form_inputs_work_address').on 'click', ->
    toggle_work_address_fields()

toggle_home_address_fields = ->
  checked = $('input#form_inputs_home_address').prop('checked')
  $('fieldset#home-address-fields input').prop('disabled', !checked)
  $('fieldset#home-address-fields select').prop('disabled', !checked)
  $('fieldset#home-address-fields').toggle(checked)

toggle_work_address_fields = ->
  checked = $('input#form_inputs_work_address').prop('checked')
  $('fieldset#work-address-fields input').prop('disabled', !checked)
  $('fieldset#work-address-fields select').prop('disabled', !checked)
  $('fieldset#work-address-fields').toggle(checked)