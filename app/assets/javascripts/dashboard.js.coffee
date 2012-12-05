# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  warning_section = $(".recipients_warnings")
  recipients = $(".recipients_warnings ul.warnings")

  if recipients.length == 0
    warning_section.hide()
