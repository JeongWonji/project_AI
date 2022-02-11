
function my_func() {
    // attr(), removeAttr()
    // $('[type=text]').val('소리없는 아우성!!')
    // $('[type=text]').attr('value','변경변경!')
    // $('[type=text]').attr('disabled','disabled')
    // $('[type=text]').removeAttr('disabled')
    // 삭제에 대한 method는 2개가 있어요!
    // remove(), empty()
    // remove() : 자기자신과 자신의 후손을 모두 삭제해요!
    // empty() : 자기자신은 삭제하지 않고 후손만 삭제해요!
    // $('ul').remove()
    // $('ul').empty()
    // 지금까지는..selector를 이용해서 Element를 선택하고 method를
    // 적용하는 방식!!
    // 새로운 Element를 만들려면 어떻게 해야 하나요?
    // 일단 selector를 사용하지 않아요!
    // $('<li></li>').text('신사임당')
    // element => <li>신사임당</li>
    // $('<img />').attr('src',
    //     'img/lion.png')
    // <img src="img/lion.png">
    // 이렇게 Element를 생성을 하면.
    // method를 통해서 화면에 추가할 수 있어요!
    // 붙이기 위한 method를 알아야 붙이겠죠.
    // append(), prepend(), after(), before()
    // append() : 자식으로 추가하고 맨 마지막 자식으로 추가해요!
    let li = $('<li></li>').text('신사임당')
    // $('ul').append(li)
    // prepend() : 자식으로 추가하고 맨 처음 자식으로 추가해요!
    // $('ul').prepend(li)
    // after() : 형제로 추가하고 바로 뒤에 추가해요!
    // before() : 형제로 추가하고 바로 앞에 추가해요!
    // $('ul > li:last').before(li)
    $('ul > li:eq(1)').after(li)

}

// Event Handler

function my_func2() {
    // this : event handler안에서 의미를 가지는 객체
    //        event source에 대한 문서객체(document object)를 지칭.
    // $(selector or document object) => jQuery객체로 변환
    // alert($(this).text()) => jQuery Event에서만 사용이 가능.
}












