# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

data =
ready = ->
  $('[data-tooltip]').tooltip()
  $(".tag-select").select2
    tags: []
$(document).ready(ready)
$(document).on('page:load', ready)