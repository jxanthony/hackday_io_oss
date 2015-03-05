ready = ->
  $(".multiple-select").select2
    placeholder: 'Pick a Judge'
  $('.has-tooltip').tooltip
  $('.has-popover').popover
    placement: 'top',
    html: true
$(document).ready(ready)
$(document).on('page:load', ready)