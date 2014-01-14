$ ->
  countdown = 720
  slides = 36

  interval = countdown / slides

  $slides = $ '.slides'

  _(slides).times (n) ->
    $slides.append "<li class='new'>#{n}</li>"

  clock = $('.clock').FlipClock countdown,
    countdown: true
    autoStart: false
    clockFace: 'MinuteCounter'
    callbacks:
      start: -> console.log 'clock start'
      stop: -> console.log 'clock stop'
      interval: ->
        if clock.getTime().time % interval is 0
          console.log "#{clock.getTime().time} transition"

          $slides.find('li.new:eq(0)').removeClass 'new'

  $(window).on 'keyup', (e) ->
    return unless e.which is 32

    if clock.running
      clock.stop()
    else
      clock.start()