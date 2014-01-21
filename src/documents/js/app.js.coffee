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
  $charts = $ '.chart'

  setElementHeights $slides, $start, $stop, $charts

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

  $(window).on 'resize', -> setElementHeights $slides, $start, $stop, $charts

  $(window).on 'keyup', (e) ->
    return unless e.which is 39

    if clock.running
      clock.stop()
    else
      clock.start()


setElementHeights = (slides, start, stop, charts) ->
  availableHeight = window.innerHeight
  slides.css('margin-top',availableHeight).find('li').css('height',availableHeight)
  start.css('line-height',"#{availableHeight}px")
  stop.css('height',availableHeight)
  charts.css('height',availableHeight-200)

  makeChart()
  $('h1').fitText 1.2, {maxFontSize: '70px'}


makeChart = ->
  AmCharts.ready ->
    # SERIAL CHART
    chart = new AmCharts.AmSerialChart()
    chart.dataProvider = chartData
    chart.categoryField = "year"

    # AXES
    # Category
    categoryAxis = chart.categoryAxis
    categoryAxis.gridAlpha = 0.07
    categoryAxis.axisColor = "#DADADA"
    categoryAxis.startOnAxis = true

    # Value
    valueAxis = new AmCharts.ValueAxis()
    # this line makes the chart "stacked"
    valueAxis.stackType = "100%"
    valueAxis.gridAlpha = 0.07
    chart.addValueAxis(valueAxis)

    # GRAPHS
    graph = new AmCharts.AmGraph()
    graph.type = "line" # it's simple line graph
    graph.title = "HTML"
    graph.valueField = "html"
    graph.lineAlpha = 0
    graph.fillAlphas = 0.6 # setting fillAlphas to > 0 value makes it area graph
    chart.addGraph(graph)

    graph = new AmCharts.AmGraph()
    graph.type = "line"
    graph.title = "CSS"
    graph.valueField = "css"
    graph.lineAlpha = 0
    graph.fillAlphas = 0.6
    chart.addGraph(graph)

    graph = new AmCharts.AmGraph()
    graph.type = "line"
    graph.title = "Javascript"
    graph.valueField = "js"
    graph.lineAlpha = 0
    graph.fillAlphas = 0.6
    chart.addGraph(graph)

    graph = new AmCharts.AmGraph()
    graph.type = "line"
    graph.title = "DHTML"
    graph.valueField = "dhtml"
    graph.lineAlpha = 0
    graph.fillAlphas = 0.6
    chart.addGraph(graph)

    graph = new AmCharts.AmGraph()
    graph.type = "line"
    graph.title = "Cold Fusion"
    graph.valueField = "cfm"
    graph.lineAlpha = 0
    graph.fillAlphas = 0.6
    chart.addGraph(graph)

    graph = new AmCharts.AmGraph()
    graph.type = "line"
    graph.title = "PHP"
    graph.valueField = "php"
    graph.lineAlpha = 0
    graph.fillAlphas = 0.6
    chart.addGraph(graph)

    graph = new AmCharts.AmGraph()
    graph.type = "line"
    graph.title = "ASP"
    graph.valueField = "asp"
    graph.lineAlpha = 0
    graph.fillAlphas = 0.6
    chart.addGraph(graph)

    graph = new AmCharts.AmGraph()
    graph.type = "line"
    graph.title = "ASP.net"
    graph.valueField = "aspnet"
    graph.lineAlpha = 0
    graph.fillAlphas = 0.6
    chart.addGraph(graph)

    graph = new AmCharts.AmGraph()
    graph.type = "line"
    graph.title = "Node.js"
    graph.valueField = "node"
    graph.lineAlpha = 0
    graph.fillAlphas = 0.6
    chart.addGraph(graph)

    graph = new AmCharts.AmGraph()
    graph.type = "line"
    graph.title = "Rails"
    graph.valueField = "rails"
    graph.lineAlpha = 0
    graph.fillAlphas = 0.6
    chart.addGraph(graph)

    graph = new AmCharts.AmGraph()
    graph.type = "line"
    graph.title = "Prototype"
    graph.valueField = "prototype"
    graph.lineAlpha = 0
    graph.fillAlphas = 0.6
    chart.addGraph(graph)

    graph = new AmCharts.AmGraph()
    graph.type = "line"
    graph.title = "jQuery"
    graph.valueField = "jq"
    graph.lineAlpha = 0
    graph.fillAlphas = 0.6
    chart.addGraph(graph)

    graph = new AmCharts.AmGraph()
    graph.type = "line"
    graph.title = "Knockout"
    graph.valueField = "knockout"
    graph.lineAlpha = 0
    graph.fillAlphas = 0.6
    chart.addGraph(graph)

    graph = new AmCharts.AmGraph()
    graph.type = "line"
    graph.title = "Backbone"
    graph.valueField = "backbone"
    graph.lineAlpha = 0
    graph.fillAlphas = 0.6
    chart.addGraph(graph)

    # LEGEND
    legend = new AmCharts.AmLegend()
    legend.valueText = ""
    legend.valueWidth = 100
    legend.valueAlign = "left"
    legend.equalWidths = false
    legend.periodValueText = "" # this is displayed when mouse is not over the chart.
    chart.addLegend(legend)

    # WRITE
    chart.write "chartdiv"

chartData = [{
  "year": "1995",
  "html": 100,
  "css": 0,
  "js": 0
}, {
  "year": "1996",
  "html": 50,
  "css": 50,
  "js": 0,
  "cfm": 0
}, {
  "year": "1997",
  "html": 25,
  "css": 25,
  "js": 25,
  "cfm": 25
}, {
  "year": "1998",
  "html": 25,
  "css": 25,
  "js": 25,
  "cfm": 25,
  "dhtml": 0
}, {
  "year": "1999",
  "html": 20,
  "css": 20,
  "js": 20,
  "cfm": 20,
  "dhtml": 20,
  "php": 0
}, {
  "year": "2000",
  "html": 16,
  "css": 16,
  "js": 16,
  "cfm": 16,
  "dhtml": 16,
  "php": 16
}, {
  "year": "2001",
  "html": 20,
  "css": 20,
  "js": 20,
  "cfm": 0,
  "dhtml": 20,
  "php": 20
}, {
  "year": "2002",
  "html": 20,
  "css": 20,
  "js": 20,
  "dhtml": 20,
  "php": 20
}, {
  "year": "2003",
  "html": 20,
  "css": 20,
  "js": 20,
  "dhtml": 20,
  "php": 20,
  "asp": 0,
  "prototype": 0
}, {
  "year": "2004",
  "html": 16,
  "css": 16,
  "js": 16,
  "dhtml": 0,
  "php": 16,
  "asp": 16,
  "prototype": 16
}, {
  "year": "2005",
  "html": 20,
  "css": 20,
  "js": 20,
  "php": 0,
  "asp": 20,
  "prototype": 20
}, {
  "year": "2006",
  "html": 20,
  "css": 20,
  "js": 20,
  "php": 0,
  "asp": 20,
  "aspnet": 0
  "prototype": 20,
  "jq": 0,
}, {
  "year": "2007",
  "html": 16,
  "css": 16,
  "js": 16,
  "php": 0,
  "asp": 0,
  "aspnet": 16
  "prototype": 16,
  "jq": 16,
}, {
  "year": "2008",
  "html": 16,
  "css": 16,
  "js": 16,
  "php": 16,
  "aspnet": 16
  "prototype": 0,
  "jq": 16,
}, {
  "year": "2009",
  "html": 16,
  "css": 16,
  "js": 16,
  "php": 16,
  "aspnet": 16,
  "prototype": 0,
  "jq": 16,
  "knockout": 0
}, {
  "year": "2010",
  "html": 14,
  "css": 14,
  "js": 14,
  "php": 14,
  "aspnet": 14,
  "node": 0,
  "jq": 14,
  "knockout": 14
}, {
  "year": "2011",
  "html": 12,
  "css": 12,
  "js": 12,
  "php": 12,
  "aspnet": 12,
  "node": 12,
  "jq": 12,
  "knockout": 12
}, {
  "year": "2012",
  "html": 14,
  "css": 14,
  "js": 14,
  "php": 0,
  "aspnet": 14,
  "node": 14,
  "rails": 0,
  "jq": 14,
  "knockout": 14,
  "backbone": 0
}, {
  "year": "2013",
  "html": 12,
  "css": 12,
  "js": 12,
  "aspnet": 0,
  "node": 12,
  "rails": 12,
  "jq": 12,
  "knockout": 12,
  "backbone": 12
}, {
  "year": "2014",
  "html": 12,
  "css": 12,
  "js": 12,
  "node": 12,
  "rails": 12,
  "jq": 12,
  "knockout": 12,
  "backbone": 12
}];