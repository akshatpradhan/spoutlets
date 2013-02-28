# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $("#entry_happiness_level").change ->
    data = $("#entry_happiness_level").val()
    $("#happiness-bar .bar").width((parseInt(data) * 20) + "%")
  $("#entry_happiness_level").change()