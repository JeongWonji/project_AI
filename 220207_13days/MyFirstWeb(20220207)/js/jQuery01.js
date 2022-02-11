
// 이 파일내에서 jQuery를 이용해서 프로그램을 작성하고 싶어요!
// CDN방식으로 링크를 포함했으니 이제 jQuery를 이용해 보아요!
// jQuery 문법부터 시작해서 어떻게 사용하는지 하나하나 알아보아요!

// jQuery를 이용할꺼예요. 먼저 selector부터 알아보아요!
// selector는 특수한 형태의 문자열이예요!

function my_func() {
    // 1. 현재 HTML안에 있는 모든 Element를 다 선택
    //    이럴때 사용하는게 전체 선택자(universal selector)
    //    기호로는 * 를 이용.
    // $('*').css('color','red');
    // 2. 태그 선택자 (tag selector)
    //    태그명을 이용해서 선택할 수 있어요!
    // text()는 인자가 없으면 태그사이의 문자열을 알아오는거예요!
    // alert($('div').text())
    // text() 메소드에 인자가 있으면 태그사이의 문자열을 변경!
    // $('div').text('호호호')
    // $('li').css('color','blue');
    // 3. ID 선택자 (ID Selector)
    // id attribute를 이용해서 선택할 수 있어요!
    // id selector는 #을 이용
    // $('#seoul').remove()    // 삭제
    // 4. class 선택자(class selector)
    // ID selector와 유사해요. class attribute를 이용해서 선택할 수 있어요!
    // 기호로는 . 을 사용해요!
    // $('.myClass').css('color','yellow')
    // 5. 자식 선택자, 후손 선택자
    //    자식 선택자는 > 기호를 이용
    //    후손 선택자는 공백(space)를 이용
    // $('ul > li').css('color','violet')
    // $('ul li').css('color','violet')
    // 6. 동위 선택자 => 형제에 대해서 선택할 수 있어요!
    //    + : 바로 다음에 나오는 형제를 지칭
    //    ~ : 바로 다음에 나오는 형제부터 그 밑 형제 모두 다
    // $('#seoul + li').css('color','red')
    // $('#seoul ~ li').css('color','red')
    // 7. 속성 선택자 => attribute를 이용해서 선택할 수 있어요!
    //    기호로는 []를 이용해요!
    // $('[value=클릭]').remove()
    // 여기까지가 기본 선택자!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
}