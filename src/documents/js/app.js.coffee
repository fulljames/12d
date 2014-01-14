$ ->
  clock = $('.clock').FlipClock 720,
    countdown: true
    autoStart: false
    clockFace: 'MinuteCounter'

  clock.start ->
    if (clock.getTime().time + 2) % 60 is 0
      console.log "#{clock.getTime().time} transition"
