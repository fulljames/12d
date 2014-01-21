$ ->
  $.scrollTo "0px", "0px"

  countdown = 48
#  countdown = 720
  slides = 12
  secondary = 2

  interval = countdown / slides
  subInterval = interval / secondary

  console.log "interval is #{interval} seconds"
  console.log "subtransition is #{subInterval} seconds"

  $slides = $ '.slides'
  $start = $ '.start'
  $stop = $ '.stop'

  setElementHeights $slides, $start, $stop

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
          else
            $.scrollTo $stop, { duration: 400 }

        if (clock.getTime().time - (subInterval)) % interval is 0
          console.log "#{clock.getTime().time} sub-transition"

          next = $slides.find('.sub:eq(0)')
          next.removeClass 'sub'

  $(window).on 'resize', -> setElementHeights $slides, $start, $stop

  $(window).on 'keyup', (e) ->
    return unless e.which is 39

    if clock.running
      clock.stop()
    else
      clock.start()


setElementHeights = (slides, start, stop) ->
  availableHeight = window.innerHeight
  slides.css('margin-top',availableHeight).find('li').css('height',availableHeight)
  start.css('line-height',"#{availableHeight}px")
  stop.css('height',availableHeight)

  $('h1').fitText 1.2, {maxFontSize: '70px'}