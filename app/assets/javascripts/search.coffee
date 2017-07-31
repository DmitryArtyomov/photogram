$(document).on 'turbolinks:load', ->
  $('#search-query').val('')
  $('span.typeahead__cancel-button').remove()

  $.typeahead
    input: '#search-query'
    emptyTemplate: "Nothing found for <strong>{{query}}</strong>"
    source:
      'Albums':
        ajax:
          url: '/search'
          data:
            q: '{{query}}'
          path: 'albums'
        display: 'name'
        href: '/users/{{user.id}}/albums/{{id}}'
        template: (query, album) ->
          """
          <div class="row">
            <div class="col-12 vertical-center">
              <div>{{name}}</div>
              <div class='text-muted'>Owner: {{user.first_name}} {{user.last_name}}</div>
              <div class='text-muted'>Photos: #{album.photos_count}</div>
            </div>
          </div>
          """

      'Tags':
        ajax:
          url: '/search'
          data:
            q: '{{query}}'
          path: 'tags'
        display: 'text'
        href: (tag) ->
          "/tags/#{tag.text.replace('#', '')}"
        template: (query, tag) ->
          """
          <div class="row">
            <div class="col-12 vertical-center">
              <div>{{text}}</div>
              <div class='text-muted'>Items: #{tag.items_count}</div>
            </div>
          </div>
          """
      'Users':
        ajax:
          url: '/search'
          data:
            q: '{{query}}'
          path: 'users'
          callback:
            done: (data, textStatus, jqXHR) ->
              data.users = data.users.map (user) ->
                user.full_name = "#{user.first_name} #{user.last_name}"
                user.reverse_full_name = "#{user.last_name} #{user.first_name}"
                user
              data

        display: ['full_name', 'reverse_full_name']
        template: (query, user) ->
          """
          <div class="row">
            <div class="col-3">
              <img class="rounded-circle img-fluid" src="{{avatar}}">
            </div>
            <div class="col-9 username">
              <div>{{full_name}}</div>
              <div class='text-muted'>Followers: #{user.followers}</div>
            </div>
          </div>
          """
        href: '/users/{{id}}'

    dynamic: true
    group: true
    callback:
      onNavigateAfter: (node, lis, a, item, query, event) ->
        window.Typeahead['#search-query'].currentResult = item

  $('#search-query').keydown (event) ->
    if event.which == 13 && result = window.Typeahead['#search-query'].currentResult
      window.location.href = result.href
