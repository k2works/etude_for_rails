$(document).on 'turbolinks:load', ->
  $('form.edit_staff_member').on 'click', '#enable-password-field', ->
    $('#enable-password-field').hide()
    $('#disable-password-field').show()
    $('#staff_member_password').removeAttr('disabled')
    $('#staff_member_password').removeClass('disable')
    $('#staff_member_password').addClass('enable')
    $('label[for=baukis_staff_member_password').addClass('required')
  $('form.edit_staff_member').on 'click', '#disable-password-field', ->
    $('#disable-password-field').hide()
    $('#enable-password-field').show()
    $('#staff_member_password').attr('disabled', 'disabled')
    $('label[for=baukis_staff_member_password]').removeClass('required')
    $('#staff_member_password').addClass('disable')
    $('#staff_member_password').removeClass('enable')