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

  makeTechChart()
  makeWorkChart()
  $('h1').fitText 1.2, {maxFontSize: '70px'}

makeWorkChart = ->
  AmCharts.ready ->
    # SERIAL CHART
    chart = new AmCharts.AmSerialChart()
    chart.dataProvider = workChartData
    chart.categoryField = "year"
    chart.handDrawn = true
    chart.handDrawnThickness = 15

    # AXES
    # Category
    categoryAxis = chart.categoryAxis
    categoryAxis.gridAlpha = 0.07
    categoryAxis.axisColor = "#DADADA"
    categoryAxis.startOnAxis = true

    # Value
    valueAxis = new AmCharts.ValueAxis()
    # this line makes the chart "stacked"
    valueAxis.gridAlpha = 0.07
    chart.addValueAxis(valueAxis)

    #GRAPH
    graph = new AmCharts.AmGraph()
    graph.type = "line"
    graph.title = "Interest"
    graph.valueField = "interest"
    graph.lineAlpha = 1
    graph.fillAlphas = 0.0
    chart.addGraph graph

    # WRITE
    chart.write "workchart"

makeTechChart = ->
  AmCharts.ready ->
    # SERIAL CHART
    chart = new AmCharts.AmSerialChart()
    chart.dataProvider = techChartData
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
    chart.addGraph createGraph("HTML","html")
    chart.addGraph createGraph("CSS","css")
    chart.addGraph createGraph("JS","js")
    chart.addGraph createGraph("Cold Fusion","cfm")
    chart.addGraph createGraph("PHP","php")
    chart.addGraph createGraph("ASP","asp")
    chart.addGraph createGraph("ASP.net","aspnet")
    chart.addGraph createGraph("Node","node")
    chart.addGraph createGraph("Rails","rails")
    chart.addGraph createGraph("Prototype","prototype")
    chart.addGraph createGraph("jQuery","jq")
    chart.addGraph createGraph("Knockout","knockout")
    chart.addGraph createGraph("Backbone","backbone")

    # LEGEND
    legend = new AmCharts.AmLegend()
    legend.valueText = ""
    legend.valueWidth = 100
    legend.valueAlign = "left"
    legend.equalWidths = false
    legend.periodValueText = "" # this is displayed when mouse is not over the chart.
    chart.addLegend(legend)

    # WRITE
    chart.write "techchart"

createGraph = (title, field) ->
  graph = new AmCharts.AmGraph()
  graph.type = "line"
  graph.title = title
  graph.valueField = field
  graph.lineAlpha = 0.8
  graph.fillAlphas = 0.6

  graph

techChartData = [{
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
  "aspnet": 0,
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

workChartData = [{
  "year": "1995",
  "interest": 9
}, {
  "year": "1996",
  "interest": 9
}, {
  "year": "1997",
  "interest": 9
}, {
  "year": "1998",
  "interest": 8
}, {
  "year": "1999",
  "interest": 6
}, {
  "year": "2000",
  "interest": 5
}, {
  "year": "2001",
  "interest": 4
}, {
  "year": "2002",
  "interest": 8
}, {
  "year": "2003",
  "interest": 7
}, {
  "year": "2004",
  "interest": 8
}, {
  "year": "2005",
  "interest": 6
}, {
  "year": "2006",
  "interest": 5
}, {
  "year": "2007",
  "interest": 4
}, {
  "year": "2008",
  "interest": 9
}, {
  "year": "2009",
  "interest": 6
}, {
  "year": "2010",
  "interest": 4
}, {
  "year": "2011",
  "interest": 9
}, {
  "year": "2012",
  "interest": 4
}, {
  "year": "2013",
  "interest": 7
}]