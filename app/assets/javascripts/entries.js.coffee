# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $('input.slider').slider
    step: 1
    max: 5
    value: 0

  $('button[data-action="been-there"]').toggleBeenThere()

# for jasmine testing it's better to use a jQuery plugin for this functionality
$.fn.toggleBeenThere = ->
  # 'this' here returns an array, I need to attach the functionality to each item
  this.each ->
    $(this).on "click", ->
      target = $(this).closest('.well').find('span[data-id="been-there"]')

      operation = if $(this).hasClass('active') then -1 else +1
      target.text(parseInt(target.text()) + operation) if target.length
      $(this).toggleClass("active") # if element has class "active" remove it otherwise add it

