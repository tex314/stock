# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).on "click", "#quantity_plus", ->
  $("#item_quantity").val(parseInt($("#item_quantity").val()) + 1)
  false

$(document).on "click","#quantity_minus", ->
  $("#item_quantity").val(parseInt($("#item_quantity").val()) - 1)
  false
