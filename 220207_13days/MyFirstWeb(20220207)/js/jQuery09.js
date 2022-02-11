
// $(document).on('ready', function() {
//     $('ul > li').each(function(idx,item) {
//         $(item).on('mouseenter',function() {
//             $(this).css('color','red')
//         })
//         $(item).on('mouseleave',function() {
//             $(this).css('color','black')
//         })
//     })
// })

// 위의 코드가 길어요.. 축약형태로 사용. $() : document ready
$(function() {
    $('ul > li').each(function(idx,item) {
        $(item).on('mouseenter',function() {
            $(this).css('color','red')
        })
        $(item).on('mouseleave',function() {
            $(this).css('color','black')
        })
    })
})
