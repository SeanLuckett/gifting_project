# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  warning_section = $(".recipient-warnings")

  warning_section.each (index, rec) ->
    if $(this).find('ul').length == 0
      $(this).hide()
