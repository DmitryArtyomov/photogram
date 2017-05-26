$(document).on 'turbolinks:load', ->
  return unless $('.tags-select').length
  $('.tags-select').select2
    theme: 'bootstrap'
    tags: true
    tokenSeparators: [',', ' ', '_']
    ajax:
      url: '/tags'
      delay: 250
      processResults: (data, params) ->
        results: data
      cache: true
    createTag: (params) ->
      term = $.trim(params.term)
      unless term.match(/^#[\da-zA-Zа-яА-ЯёЁ]{1,20}$/)
        if term.match(/^[\da-zA-Zа-яА-ЯёЁ]{1,19}$/)
          term = "\##{term}"
        else
          return null
      {
        id: term
        text: term
      }
