# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


init = ->
  $('.form_ajax').on 'ajax:success', (e, data) ->
    $p_add = $('<p>').append $('<input id=add_tag_field type=text>')
                     .append $('<input id=add_tag_btn type=button value=add>')
    $('#tag_form').append $p_add

    $('#add_tag_btn').click ->
      value =  $('#add_tag_field').val()
      $('#add_tag_field').val ''
      $p_remove = $('<p>').append $("<input class=remove_tag_field type=text name=tags[] value=#{value}>")
                          .append $('<input class=remove_tag_btn type=button value=remove>')
      $('#tag_form').append $p_remove

  $(document).on 'click', '.remove_tag_btn',  ->
    $(@).parent().remove()

$(document).ready(init)
$(document).on('page:load', init)
