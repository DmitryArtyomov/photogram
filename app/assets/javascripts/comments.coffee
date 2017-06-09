$(document).on 'turbolinks:load', ->

  $('.comment a[data-method=\'delete\']').click ->
    $(this).on 'ajax:beforeSend', ->
      $(this).hide()
