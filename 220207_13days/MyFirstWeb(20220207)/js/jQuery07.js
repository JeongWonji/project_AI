
// event handler
function my_func() {
    // <li>김연아</li>를 찾아서
    // Event 처리를 등록(jQuery방식으로)
    // Event 처리를 등록하려면 on method를 이용.
    $('ul > li:eq(1)').on('click',function() {
        // this를 사용할 수 있어요!
        alert($(this).text())
    })
}