$ ->
  clock = $('.clock').FlipClock 720,
    countdown: true
    autoStart: false
    clockFace: 'MinuteCounter'
    callbacks:
      start: -> console.log 'clock start'
      stop: -> console.log 'clock stop'
      interval: ->
        if clock.getTime().time % 20 is 0
          console.log "#{clock.getTime().time} transition"

  clock.start()
