
// event handler
function my_func() {
    $('ul > li').each(function(idx,item) {
        $(item).on('mouseenter',function() {
            $(this).css('color','red')
        })
        $(item).on('mouseleave',function() {
            $(this).css('color','black')
        })
    })
}