# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


init = ->
  $('#form_ajax').on 'ajax:success', (e, data) ->
    $p_add = $('<div class="form-inline">')
                          .append $('<input id=add_tag_field class="form-control add_tag_field" type=text>')
                          .append $('<span id="add_tag_btn" class="glyph glyph-green glyphicon glyphicon-plus-sign" aria-hidden="true"></span>')
    $('#tag_form').append $p_add

    $('#add_tag_btn').click ->
      value =  $('#add_tag_field').val()
      $('#add_tag_field').val ''
      $p_remove = $('<div class="form-inline">')
                          .append $("<input class='remove_tag_field form-control' type=text name=tags[] readonly value=#{value}>")
                          .append $('<span class="remove_tag_btn glyph glyph-red glyphicon glyphicon-remove-sign" aria-hidden="true"></span>')
      $('#tag_form').append $p_remove

  $("form").on "submit", ->
    $("#spinner-wrapper").append(
      $ "<div></div>"
        .addClass "loader"
        .html "loading..."
    )
    $("#url-submit")
      .addClass "disabled"
    $("#search")
      .prop "readonly", true

  $(document).on 'click', '.remove_tag_btn',  ->
    $(@).parent().remove()

$(document).ready(init)
$(document).on('page:load', init)
