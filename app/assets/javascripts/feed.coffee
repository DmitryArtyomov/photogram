$(document).on 'turbolinks:load', ->

  $('.feed').jscroll
    loadingHtml: '<span>Loading...</span>'
    padding: 20
    nextSelector: 'a.jscroll-next:last'
