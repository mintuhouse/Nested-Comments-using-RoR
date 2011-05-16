function show_comment_form(id){
    $("#comment_form_"+id).show("fast");
    $("#comment_"+id+' div#enable_comment input').toggle();
}
function hide_comment_form(id){
    $("#comment_form_"+id).hide("fast");
    $("#comment_"+id+' div#enable_comment input').toggle();
}
