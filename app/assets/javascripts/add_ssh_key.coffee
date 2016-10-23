$(document).on 'turbolinks:load', ->
  $('#add-ssh-key').click ->
    if $(this).is(':checked')
      $('.add-ssh-key').show()
    else
      $('.add-ssh-key').hide()
