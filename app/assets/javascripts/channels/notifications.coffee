$(document).on 'turbolinks:load', ->
  return if App.cable.notifications_channel
  return unless $('#navbarDropdownMenuLink').length

  App.sound = new Audio('/sounds/notification.mp3')

  App.cable.notifications_channel = App.cable.subscriptions.create { channel: "NotificationsChannel" },

    received: (data) ->
      console.log(data)
      @processNotification(data)

    playSound: ->
      App.sound.play()

    processNotification: (notification) ->
      switch notification.type
        when 'follower' then @newFollower(notification.data)
        when 'comment' then @newComment(notification.data)

    newFollower: (followerData) ->
      params =
        icon: 'fa fa-user-plus'
        title: 'New follower!'
        message: "#{followerData.name} is now following you"
        image: followerData.avatar
        buttons: [ [
          '<button>Profile</button>'
          (instance, toast) ->
            window.open followerData.url, '_self'
        ] ]
        timer: 30000
      @showNotification(params)

    newComment: (commentData) ->
      params =
        icon: 'fa fa-comment'
        title: 'New comment'
        message: "#{commentData.name} left a comment on your photo"
        image: commentData.avatar
        buttons: [ [
          '<button>View</button>'
          (instance, toast) ->
            window.open commentData.url, '_self'
        ] ]
        timer: 10000
      @showNotification(params)

    showNotification: (params) ->
      iziToast.show
        class: 'mytoast'
        color: 'dark'
        icon: params.icon
        title: params.title
        message: params.message
        position: 'bottomRight'
        transitionIn: 'flipInX'
        transitionOut: 'flipOutX'
        progressBarColor: '#4eacfd'
        image: params.image
        imageWidth: 57
        layout: 1
        iconColor: '#4eacfd'
        timeout: params.timer
        buttons: params.buttons
      @playSound()
