$(document).on 'turbolinks:load', ->
  $('#photo-modal').on 'show.bs.modal', (event) ->
    window.previousUrl = window.location.href
    url = event.relatedTarget.href
    if window.previousUrl != url
      window.history.pushState({ turbolinks: {} }, '', url)

    $('.modal-body').load event.relatedTarget.href

  $('#photo-modal').on 'hide.bs.modal', (event) ->
    window.history.pushState({ turbolinks: {} }, '', window.previousUrl)
