tokenizer 구현하기
 참고할 곳: https://blog.beezwax.net/writing-a-markdown-compiler/
 순서 있는/없는 리스트 같이 여러 줄이 한 요소인 경우 참고 자료에선 토큰 변환 어떤 식으로 하는지 테스트 및 확인하기
 참고 자료 기반으로 tokenizer 구현하기

수동 배포하기
 원문에서 단락 정리하기
 css 적용하기
  너비 줄이기
 탐색 페이지 생성
  글 제목마다 줄바꿈하기
저장소 업데이트
 저장소의 글 목록 및 내용과 새로 빌드한 글의 상태가 다르면 저장소를 업데이트한다
탐색 페이지 글 목록 포맷팅 다듬기

css
 각 블로그 글에 css 적용하기
 글 폰트 설정하기
markdown -> html 변환하기
 tokenizer 구현
 parser 구현
 변환 메서드 일괄 적용하기
 각 줄마다 변환하기
  파일 내용 전체에 적용하기보다는 마크다운 키워드로 감싼 부분에 적용해야 한다
 x 헤더: 문장이 #으로 시작하는 경우 <hx></hx>로 감싼다
 x 굵게
 단락: 하나 이상의 빈 줄로 구분되어 있으면 단락으로 본다
  x \n을 기준으로 글을 분리한다
  x 먼저 \n이 여러번 나오는 경우도 일괄적으로 \n으로 변환하자
  변환 후에도 \n의 갯수가 유지되어야 한다
  리스트인 경우는 무시해야 한다
 리스트
  ol이나 ul이 없어도 li 태그만 있으면 html 렌더링이 된다면 일단은 한줄씩만 변환하는 걸로 구현해놓으면 어떨까?
  순서 있는 리스트
   "^-"으로 시작하는 줄부터 시작해서 "^-"으로 시작하지 않는 줄까지를 범위로 잡고 변환한다
   "번호."로 시작하는 줄을 <li>content</li>로 변환한다
   <li> 태그로 감싸진 줄을 <ol>, </ol>로 감싼다
  순서 없는 리스트
   "^-"으로 시작하는 줄부터 시작해서 "^-"으로 시작하지 않는 줄까지를 범위로 잡고 변환한다
   -로 시작하는 줄을 <li>content</li>로 변환한다
   <li> 태그로 감싸진 줄을 <ul>, </ul>로 감싼다
 테스트 방식 개선하기
  kramdown에서 쓰는 테스트 방식 활용하기
  입력으로 쓸 마크다운 파일과 예상 출력으로 쓸 html 파일 만들기
  파일명이 같은 .md 파일과 .html 파일을 테스트 입력 및 출력으로 받기
 코드블록
 이미지
 코드 블록
변환 결과로 얻은 html에 적용할 레이아웃 html
 블로그 글마다 각자 적용할 레이아웃 html을 설정할 수 있는 게 좋을 것 같다
 적절하다고 생각하는 위치는 해당 블로그 글의 마크다운 파일 내부
 마크다운 내에 일정한 형식으로 레이아웃 파일의 경로를 적으면, Post 객체로 변환할 때 이 정보를 읽어와서 attribute로 두고
 레이아웃 적용 메서드 호출 시 쓰면 될 것 같다


파일 생성은 어떻게 테스트하나?
markdown -> html 변환하기
 파일 내용 전체에 적용하기보다는 마크다운 키워드로 감싼 부분에 적용해야 한다
 헤더: 문장이 #으로 시작하는 경우 <hx></hx>로 감싼다
 굵게
 단락: 하나 이상의 빈 줄로 구분되어 있으면 단락으로 본다
 리스트
 코드블록
 \n -> &nbsp
dest 디렉토리 구조
 블로그 글만 저장할 디렉토리를 만들고, rake clean task가 이 디렉토리를 삭제
