오픈소스 SW 개론 과제
-	12223695 권용현


사용자에게 메뉴를 제공, 선택에 따라 영화 파일('u.item', 'u.data', 'u.user')를 다루는 작업 수행. 

1. 영화 데이터 가져오기 ('movie id'로 식별)

사용자에게 특정 'movie id'를 입력하라고 요청.
awk를 사용하여 해당 'movie id'에 해당하는 파일의 줄을 찾고 출력.

2. 'action' 장르 영화 데이터 가져오기

'action' 장르 영화 데이터를 가져올지 사용자에게 물어본다.
'y'를 입력하면 awk를 사용하여 파일에서 'action' 장르에 해당하는 영화만 출력하고, 상위 10개만 보여준다.
'n'을 입력하면 continue

3. 특정 'movie id'의 평균 'rating' 계산

사용자로부터 'movie id'를 입력받는다.
awk를 사용하여 해당 'movie id'의 모든 평점을 찾아 평균을 계산하고 출력.

4. 'IMDb URL' 삭제하기
   
사용자에게 'IMDb URL'을 파일에서 삭제할지 물어봄.
'y'를 입력하면, sed를 사용하여 해당 URL을 포함한 문자열을 제거합니다.
'n'을 입력하면 continue
정규 표현식 사용

5. 사용자 데이터 가져오기

사용자에게 파일에서 데이터를 출력할지 물어본다.
'y'를 입력하면, 파일에서 사용자 정보를 읽고, 형식을 변경하여 출력.
'n'을 입력하면 continue
정규 표현식 사용

6. 'release date' 형식 수정하기

사용자에게 파일 내의 'release date' 형식을 MMDDYYYY 형식으로 수정할 것인지 물어본다.
'y'를 입력하면, sed를 사용하여 날짜 형식을 변경하여 출력.
'n'을 입력하면 continue
정규 표현식 사용

7. 특정 'user id'가 평가한 영화 데이터 가져오기

사용자에게 'user id'를 입력하도록 요청.
'u.data' 파일에서 해당 'user id'에 의해 평가된 모든 영화의 ID를 찾고, 그 목록을 출력.

8. 20~29세 'programmer'의 평균 영화 평점 계산

사용자에게 이 특정 집단에 대한 데이터를 가져올지 물어본다.
'y'를 입력하면, 해당 사용자를 찾고, 그들의 영화 평점을 평균내어 출력.
'n'을 입력하면 continue

9. 스크립트 종료

사용자가 9번을 선택하면 "Bye!"를 출력하고 스크립트를 종료.

