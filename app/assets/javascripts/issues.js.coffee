# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $('form').on 'click', '.remove_fields', (event) ->
    $(@).prev('input[type=hidden]').val('1')
    $(@).closest('fieldset').hide()
    event.preventDefault()

  $( "#sortable" ).sortable
  	update: -> $.post($(this).data('update-url'), $(this).sortable('serialize'))
    	

  $( "#sortable").disableSelection()
  


  $('form').on 'click', '.add_fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(@).data('id'), 'g')
    $(@).before($(@).data('fields').replace(regexp, time))
    event.preventDefault()
