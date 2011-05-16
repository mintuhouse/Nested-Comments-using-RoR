function enable_texteditor(id){
    $( '#comment_form_'+id+'  .micropost_editor' ).ckeditor(function(){
        $('#enable_texteditor input').toggle();
    },{
        toolbar :
        [
            ['Source','Styles'],
            ['Bold', 'Italic', '-', 'NumberedList', 'BulletedList', '-', 'Link', '-', 'About']
        ],
        width: "90%", height: "100px", rows: "5"
    }); 
}

function disable_texteditor(id){
     $( '#comment_form_'+id+'  .micropost_editor' ).ckeditor(function(){
        this.destroy();
        $('#enable_texteditor input').toggle();
     },{});
}
