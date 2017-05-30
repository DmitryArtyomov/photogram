$(document).on 'turbolinks:load', ->
  return unless $('.tags-select').length
  window.select2 = $('.tags-select').select2
    theme: 'bootstrap'
    tags: true
    allowClear: true
    placeholder: 'Enter your tags...'
    tokenSeparators: [',', ' ', '_']
    ajax:
      url: '/tags/search'
      delay: 250
      processResults: (data, params) ->
        term = $.trim(params.term)
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
    insertTag: (data, tag) ->
      data.unshift tag unless data.filter((el) ->
        tag.text == el.text
      ).length
