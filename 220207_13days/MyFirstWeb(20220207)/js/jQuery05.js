
//  selector는 이쯤에서 정리할꺼예요!
// 이제 method에 대해서 알아볼 차례예요!!
// css(), text(), val(), attr(), remove(), each(), ...
// 기존에 소개했던것에 추가적으로 몇가지만 더 알아보아요!

function my_func() {

    // $('ul > li:eq(1)').css('color','red')
    // $('ul > li:eq(1)').css('background-color',
    //     'yellow')
    // css는 한번에 1개의 style만 적용해서 그림을 그려요!
    $('ul > li:eq(1)').addClass('myStyle')
    // css()는 잘 사용되지 않아요. 주로 addClass()가 사용되요!
    // removeClass()는 class속성을 삭제해요!

}

