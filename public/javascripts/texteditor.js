function enable_texteditor(){
    $( '.micropost_editor' ).ckeditor(function(){
        $('#enable_texteditor input').toggle();
    },{
        toolbar :
        [
            ['Source','Styles'],
            ['Bold', 'Italic', '-', 'NumberedList', 'BulletedList', '-', 'Link', '-', 'About']
        ],
        width: "95%", height: "100px", rows: "5"
    }); 
}

function disable_texteditor(){
     $( '.micropost_editor' ).ckeditor(function(){
        this.destroy();
        $('#enable_texteditor input').toggle();
     },{});
}
