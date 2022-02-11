

// 버튼을 누르면 체크박스에서 선택된 사람이
// 콘솔에 한줄에 한명씩 출력되면 되요!

function my_func() {
    // console.log($('[type=checkbox]:checked + span').text())
    // 아하..이렇게 하니 선택된 element를 하나하나 따로 처리할 방법이 없네요!
    // $('selector').each()  선택된 Element가 여러개이면 그 각각에 대해서
    // each안에 들어있는 람다함수를 호출하게 되요!
    $('[type=checkbox]:checked + span').each(
        function(idx,item) {
        // idx는 0부터 1씩 증가하는 index값.
        // item은 현재 선택된 Element의 document object(jQuery객체가 아니예요)
        console.log($(item).text())
    })
}