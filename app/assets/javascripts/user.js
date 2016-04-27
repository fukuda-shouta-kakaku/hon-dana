$(function(){
    $(document).on("click", ".book_botton button", function () {
        var review_id = $(this).data('id');
        $(".modal-footer button").attr('data-id',review_id);
    });

    $(document).on("click","#rewrite_btn", function () {
        var review_id = $(this).data('id');
        review_text = $("#review_info_"+review_id).html();
        $("#review-text").val(review_text);
    });

    $(document).on('click','#dia_rewrite_btn',function(){
        var id = $(this).data("id");
        var text =  $("#review-text").val();

        var list = [];
        var tags = $('[name="tags[]"]').each(function() { list.push(this.value); });

        $.ajax({
            type: 'POST',
            url: "/reviews/update/"+id,
            data: {
                "body": text,
                "tags": list
            },
            success: function(json){
                $("#review_info_"+id).html(json);
                $("#main_content").prepend('<div class="alert alert-success text-center">rewrite success</div>');
                $(".alert").fadeTo(2000, 500).slideUp(500);
            }
        });
        $('#rewrite_dialog').modal('hide');
        return false;
    });


    $(document).on('click','#dia_delete_btn',function(){
        var id = $(this).data("id")
        $.ajax({
            url: "/reviews/"+id,
            type: 'DELETE',
            success: function(json){
                $("#review_"+id).hide();
                $("#main_content").prepend('<div class="alert alert-success text-center">delete success</div>');
                $(".alert").fadeTo(2000, 500).slideUp(500);
            }
        });
        $('#delete_dialog').modal('hide');
        return false;
    });

    $("#add_tag_btn").click(function() {
        var value =  $('#add_tag_field').val()
        $('#add_tag_field').val("")
        $p = $('<div class="form-inline">').append($("<input class='remove_tag_field form-control' type=text name=tags[] readonly value=" + value + ">"))
                     .append($('<span class="remove_tag_btn glyph glyph-red glyphicon glyphicon-remove-sign" aria-hidden="true"></span>'));
        $('#tag_form').append($p)
    });
});
