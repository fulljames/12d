$ ->
  countdown = 48
#  countdown = 720
  slides = 12
  secondary = 2

  interval = countdown / slides
  subInterval = interval / secondary

  console.log "interval is #{interval} seconds"
  console.log "subtransition is #{subInterval} seconds"

  $slides = $ '.slides'
  setSlideHeight $slides

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

          next = $slides.find('li.new:eq(0)')

          if next.length
            next.removeClass 'new'
            $.scrollTo next, { duration: 400 }

        if (clock.getTime().time - (subInterval)) % interval is 0
          console.log "#{clock.getTime().time} sub-transition"

          next = $slides.find('.sub:eq(0)')
          next.removeClass 'sub'

  $(window).on 'resize', -> setSlideHeight $slides

  $(window).on 'keyup', (e) ->
    return unless e.which is 39

    if clock.running
      clock.stop()
    else
      clock.start()


setSlideHeight = (slides) ->
  availableHeight = window.innerHeight
  slides.find('li').css('height',availableHeight)