### 소개
- 블로그를 만들어주는 프로그램

### 사용 방법
1) [md2html](https://github.com/rogarithm/md2html) 라이브러리 설치 (마크다운을 html로 변환하는 데 필요)
```
$> git clone https://github.com/rogarithm/md2html
$> cd path/to/md2html
$> gem build md2html.gemspec
$> gem install md2html
```

2) 프로젝트 내 source 디렉토리와 dest 디렉토리를 만들고, 마크다운 포맷 파일을 source 디렉토리에 추가
3) 마크다운 포맷 파일을 만들 때, 파일 상단에 메타 데이터를 입력해야 함
```
title: stash 대신 patch를 써보자
published_at: 2024/11/21
draft: no
***meta-info-ends***
## stash 대신 patch를 써보자

git으로 버전 관리 하다보면 stash할 일이 종종 생긴다...
```
* `***meta-info-ends***` 뒷줄부터 마크다운 형식으로 본문을 작성
* 아직 발행할 글이 아닌 경우, `draft: no` 대신 `draft: yes`로 작성
4) 터미널에서 `cd /path/to/autoblog && rake publish` 명령 실행 시 dest 디렉토리에 블로그 사이트를 구성하는 정적 파일이 생성됨
5) 터미널에서 `cd /path/to/autoblog && rake draft` 명령 실행 시 /tmp 디렉토리에 초안인 글만 갖는 블로그 사이트를 구성하는 정적 파일이 생성됨
