// MARK: - Book 구조체

struct Book {
    let id: Int
    let title: String
    let author: String
    let genre: Int             // 100: 소설, 200: 에세이, 300: 자기계발, 400: 역사, 500: 과학, 600: 시/문학, 700: 경제/경영
    let publishYear: Int
    let price: Int
    let rating: Double
    let pageCount: Int
    let isBestseller: Bool
}

// MARK: - 더미 데이터 (100개)

let books: [Book] = [
    // 1-10: 소설 (genre: 100)
    Book(id: 1, title: "달러구트 꿈 백화점", author: "이미예", genre: 100, publishYear: 2020, price: 13800, rating: 4.5, pageCount: 296, isBestseller: true),
    Book(id: 2, title: "아몬드", author: "손원평", genre: 100, publishYear: 2017, price: 12000, rating: 4.7, pageCount: 264, isBestseller: true),
    Book(id: 3, title: "불편한 편의점", author: "김호연", genre: 100, publishYear: 2021, price: 14000, rating: 4.3, pageCount: 268, isBestseller: true),
    Book(id: 4, title: "파친코", author: "이민진", genre: 100, publishYear: 2022, price: 16800, rating: 4.6, pageCount: 512, isBestseller: true),
    Book(id: 5, title: "작별인사", author: "김영하", genre: 100, publishYear: 2022, price: 15000, rating: 4.2, pageCount: 324, isBestseller: true),
    Book(id: 6, title: "밤의 문이 열린다", author: "박서련", genre: 100, publishYear: 2027, price: 14500, rating: 0.0, pageCount: 288, isBestseller: false),
    Book(id: 7, title: "종의 기원", author: "정유정", genre: 100, publishYear: 2016, price: 14000, rating: 4.4, pageCount: 356, isBestseller: true),
    Book(id: 8, title: "해가 지는 곳으로", author: "최진영", genre: 100, publishYear: 2023, price: 15500, rating: 4.1, pageCount: 312, isBestseller: false),
    Book(id: 9, title: "시선으로부터", author: "정세랑", genre: 100, publishYear: 2020, price: 14000, rating: 4.3, pageCount: 284, isBestseller: false),
    Book(id: 10, title: "지구 끝의 온실", author: "김초엽", genre: 100, publishYear: 2021, price: 14800, rating: 4.5, pageCount: 332, isBestseller: true),
    
    // 11-20: 소설 (genre: 100) 계속
    Book(id: 11, title: "설자은 살인사건", author: "김별", genre: 100, publishYear: 2028, price: 16000, rating: 0.0, pageCount: 340, isBestseller: false),
    Book(id: 12, title: "여름의 빌라", author: "이수현", genre: 100, publishYear: 2024, price: 13500, rating: 4.0, pageCount: 256, isBestseller: false),
    Book(id: 13, title: "검은 꽃", author: "김영하", genre: 100, publishYear: 2003, price: 13000, rating: 4.2, pageCount: 328, isBestseller: false),
    Book(id: 14, title: "82년생 김지영", author: "조남주", genre: 100, publishYear: 2016, price: 13800, rating: 4.1, pageCount: 190, isBestseller: true),
    Book(id: 15, title: "아버지의 해방일지", author: "정지아", genre: 100, publishYear: 2022, price: 15000, rating: 4.4, pageCount: 376, isBestseller: true),
    Book(id: 16, title: "눈먼 자들의 도시", author: "주제 사라마구", genre: 100, publishYear: 1995, price: 15800, rating: 4.6, pageCount: 432, isBestseller: false),
    Book(id: 17, title: "1984", author: "조지 오웰", genre: 100, publishYear: 1949, price: 12500, rating: 4.7, pageCount: 368, isBestseller: true),
    Book(id: 18, title: "동물농장", author: "조지 오웰", genre: 100, publishYear: 1945, price: 10800, rating: 4.5, pageCount: 152, isBestseller: true),
    Book(id: 19, title: "멋진 신세계", author: "올더스 헉슬리", genre: 100, publishYear: 1932, price: 13500, rating: 4.4, pageCount: 324, isBestseller: false),
    Book(id: 20, title: "호밀밭의 파수꾼", author: "J.D. 샐린저", genre: 100, publishYear: 1951, price: 12000, rating: 4.3, pageCount: 288, isBestseller: true),
    
    // 21-35: 에세이 (genre: 200)
    Book(id: 21, title: "죽고 싶지만 떡볶이는 먹고 싶어", author: "백세희", genre: 200, publishYear: 2018, price: 14000, rating: 4.3, pageCount: 248, isBestseller: true),
    Book(id: 22, title: "언어의 온도", author: "이기주", genre: 200, publishYear: 2016, price: 13800, rating: 4.4, pageCount: 296, isBestseller: true),
    Book(id: 23, title: "나는 나로 살기로 했다", author: "김수현", genre: 200, publishYear: 2016, price: 13800, rating: 4.2, pageCount: 272, isBestseller: true),
    Book(id: 24, title: "보통의 존재", author: "김영민", genre: 200, publishYear: 2023, price: 16800, rating: 4.1, pageCount: 328, isBestseller: false),
    Book(id: 25, title: "어른의 어휘력", author: "유선경", genre: 200, publishYear: 2021, price: 15800, rating: 4.0, pageCount: 312, isBestseller: false),
    Book(id: 26, title: "매일 감사 일기", author: "박현우", genre: 200, publishYear: 2027, price: 14500, rating: 0.0, pageCount: 224, isBestseller: false),
    Book(id: 27, title: "그릭요거트 같은 하루", author: "최다은", genre: 200, publishYear: 2025, price: 13000, rating: 4.5, pageCount: 198, isBestseller: false),
    Book(id: 28, title: "인생은 짧고 여행은 길다", author: "김민주", genre: 200, publishYear: 2024, price: 17000, rating: 4.2, pageCount: 352, isBestseller: false),
    Book(id: 29, title: "어쩌다 어른", author: "한수민", genre: 200, publishYear: 2019, price: 14800, rating: 4.1, pageCount: 264, isBestseller: false),
    Book(id: 30, title: "서른의 반격", author: "손미나", genre: 200, publishYear: 2017, price: 15000, rating: 4.3, pageCount: 288, isBestseller: true),
    Book(id: 31, title: "나를 돌보는 시간", author: "이정은", genre: 200, publishYear: 2023, price: 16500, rating: 4.0, pageCount: 276, isBestseller: false),
    Book(id: 32, title: "퇴근길 인문학 수업", author: "백상경제연구원", genre: 200, publishYear: 2018, price: 14000, rating: 4.1, pageCount: 312, isBestseller: false),
    Book(id: 33, title: "오늘 밤, 세계에서 이 사랑이 사라진다 해도", author: "이치조 미사키", genre: 200, publishYear: 2021, price: 14800, rating: 4.6, pageCount: 304, isBestseller: true),
    Book(id: 34, title: "당신이 옳다", author: "정혜신", genre: 200, publishYear: 2018, price: 15800, rating: 4.4, pageCount: 316, isBestseller: true),
    Book(id: 35, title: "내가 틀릴 수도 있습니다", author: "비욘 나티코 린데블라드", genre: 200, publishYear: 2022, price: 16800, rating: 4.5, pageCount: 248, isBestseller: true),
    
    // 36-50: 자기계발 (genre: 300)
    Book(id: 36, title: "역행자", author: "자청", genre: 300, publishYear: 2022, price: 17500, rating: 4.2, pageCount: 368, isBestseller: true),
    Book(id: 37, title: "아주 작은 습관의 힘", author: "제임스 클리어", genre: 300, publishYear: 2019, price: 16000, rating: 4.6, pageCount: 360, isBestseller: true),
    Book(id: 38, title: "데일 카네기 인간관계론", author: "데일 카네기", genre: 300, publishYear: 1936, price: 15800, rating: 4.5, pageCount: 384, isBestseller: true),
    Book(id: 39, title: "미라클 모닝", author: "할 엘로드", genre: 300, publishYear: 2016, price: 14800, rating: 4.3, pageCount: 256, isBestseller: true),
    Book(id: 40, title: "부자 아빠 가난한 아빠", author: "로버트 기요사키", genre: 300, publishYear: 1997, price: 15800, rating: 4.4, pageCount: 336, isBestseller: true),
    Book(id: 41, title: "생각 정리의 기술", author: "박소연", genre: 300, publishYear: 2028, price: 16000, rating: 0.0, pageCount: 288, isBestseller: false),
    Book(id: 42, title: "완벽한 공부법", author: "고영성", genre: 300, publishYear: 2017, price: 17000, rating: 4.1, pageCount: 432, isBestseller: false),
    Book(id: 43, title: "하버드 새벽 4시 반", author: "웨이슈잉", genre: 300, publishYear: 2014, price: 14500, rating: 4.0, pageCount: 296, isBestseller: true),
    Book(id: 44, title: "나는 4시간만 일한다", author: "팀 페리스", genre: 300, publishYear: 2007, price: 15000, rating: 4.2, pageCount: 468, isBestseller: false),
    Book(id: 45, title: "몰입", author: "황농문", genre: 300, publishYear: 2008, price: 16800, rating: 4.4, pageCount: 424, isBestseller: true),
    Book(id: 46, title: "더 해빙", author: "이서윤", genre: 300, publishYear: 2020, price: 16000, rating: 4.3, pageCount: 308, isBestseller: true),
    Book(id: 47, title: "마인드셋", author: "캐롤 드웩", genre: 300, publishYear: 2006, price: 18000, rating: 4.5, pageCount: 392, isBestseller: true),
    Book(id: 48, title: "그릿", author: "앤절라 더크워스", genre: 300, publishYear: 2016, price: 16800, rating: 4.3, pageCount: 416, isBestseller: true),
    Book(id: 49, title: "자기 혁명 3.0", author: "최동석", genre: 300, publishYear: 2027, price: 18500, rating: 0.0, pageCount: 344, isBestseller: false),
    Book(id: 50, title: "언스크립티드", author: "엠제이 드마코", genre: 300, publishYear: 2017, price: 18000, rating: 4.2, pageCount: 512, isBestseller: false),
    
    // 51-65: 역사 (genre: 400)
    Book(id: 51, title: "총균쇠", author: "재레드 다이아몬드", genre: 400, publishYear: 1997, price: 28000, rating: 4.6, pageCount: 752, isBestseller: true),
    Book(id: 52, title: "사피엔스", author: "유발 하라리", genre: 400, publishYear: 2011, price: 24000, rating: 4.7, pageCount: 636, isBestseller: true),
    Book(id: 53, title: "역사의 쓸모", author: "최태성", genre: 400, publishYear: 2019, price: 16000, rating: 4.3, pageCount: 308, isBestseller: true),
    Book(id: 54, title: "조선왕조실록", author: "박영규", genre: 400, publishYear: 1996, price: 22000, rating: 4.4, pageCount: 584, isBestseller: false),
    Book(id: 55, title: "나의 문화유산답사기", author: "유홍준", genre: 400, publishYear: 1993, price: 16800, rating: 4.5, pageCount: 432, isBestseller: true),
    Book(id: 56, title: "세계사를 바꾼 37가지 물고기 이야기", author: "오치 도시유키", genre: 400, publishYear: 2021, price: 17500, rating: 4.0, pageCount: 328, isBestseller: false),
    Book(id: 57, title: "로마인 이야기", author: "시오노 나나미", genre: 400, publishYear: 1992, price: 15000, rating: 4.6, pageCount: 376, isBestseller: true),
    Book(id: 58, title: "호모 데우스", author: "유발 하라리", genre: 400, publishYear: 2015, price: 24000, rating: 4.4, pageCount: 584, isBestseller: true),
    Book(id: 59, title: "한국사 편지", author: "박은봉", genre: 400, publishYear: 2002, price: 11800, rating: 4.3, pageCount: 268, isBestseller: false),
    Book(id: 60, title: "21세기를 위한 21가지 제언", author: "유발 하라리", genre: 400, publishYear: 2018, price: 22000, rating: 4.2, pageCount: 488, isBestseller: false),
    Book(id: 61, title: "문명과 바다", author: "주경철", genre: 400, publishYear: 2009, price: 18000, rating: 4.1, pageCount: 412, isBestseller: false),
    Book(id: 62, title: "역사란 무엇인가", author: "E.H. 카", genre: 400, publishYear: 1961, price: 12000, rating: 4.4, pageCount: 256, isBestseller: false),
    Book(id: 63, title: "2030 미래의 역사", author: "김난도", genre: 400, publishYear: 2027, price: 19800, rating: 0.0, pageCount: 356, isBestseller: false),
    Book(id: 64, title: "조선의 미식가들", author: "이한", genre: 400, publishYear: 2023, price: 17500, rating: 4.1, pageCount: 296, isBestseller: false),
    Book(id: 65, title: "백범일지", author: "김구", genre: 400, publishYear: 1947, price: 10800, rating: 4.7, pageCount: 324, isBestseller: true),
    
    // 66-80: 과학 (genre: 500)
    Book(id: 66, title: "코스모스", author: "칼 세이건", genre: 500, publishYear: 1980, price: 22000, rating: 4.8, pageCount: 584, isBestseller: true),
    Book(id: 67, title: "이기적 유전자", author: "리처드 도킨스", genre: 500, publishYear: 1976, price: 20000, rating: 4.6, pageCount: 512, isBestseller: true),
    Book(id: 68, title: "시간의 역사", author: "스티븐 호킹", genre: 500, publishYear: 1988, price: 15000, rating: 4.5, pageCount: 248, isBestseller: true),
    Book(id: 69, title: "부분과 전체", author: "베르너 하이젠베르크", genre: 500, publishYear: 1969, price: 18000, rating: 4.3, pageCount: 368, isBestseller: false),
    Book(id: 70, title: "파인만의 물리학 강의", author: "리처드 파인만", genre: 500, publishYear: 1963, price: 35000, rating: 4.7, pageCount: 824, isBestseller: false),
    Book(id: 71, title: "김상욱의 양자 공부", author: "김상욱", genre: 500, publishYear: 2017, price: 16000, rating: 4.2, pageCount: 312, isBestseller: false),
    Book(id: 72, title: "우주의 끝을 찾아서", author: "이강환", genre: 500, publishYear: 2022, price: 18500, rating: 4.1, pageCount: 344, isBestseller: false),
    Book(id: 73, title: "세계를 바꾼 17가지 방정식", author: "이언 스튜어트", genre: 500, publishYear: 2012, price: 18000, rating: 4.4, pageCount: 456, isBestseller: false),
    Book(id: 74, title: "오리진", author: "루이스 다트넬", genre: 500, publishYear: 2019, price: 22000, rating: 4.3, pageCount: 488, isBestseller: false),
    Book(id: 75, title: "인터스텔라의 과학", author: "킵 손", genre: 500, publishYear: 2014, price: 25000, rating: 4.5, pageCount: 412, isBestseller: true),
    Book(id: 76, title: "통찰의 시대", author: "에릭 캔델", genre: 500, publishYear: 2012, price: 28000, rating: 4.2, pageCount: 624, isBestseller: false),
    Book(id: 77, title: "AI 2041", author: "리카이푸", genre: 500, publishYear: 2021, price: 22000, rating: 4.1, pageCount: 536, isBestseller: false),
    Book(id: 78, title: "생명이란 무엇인가", author: "에르빈 슈뢰딩거", genre: 500, publishYear: 1944, price: 13000, rating: 4.4, pageCount: 192, isBestseller: false),
    Book(id: 79, title: "2030 뇌과학의 미래", author: "최성윤", genre: 500, publishYear: 2028, price: 21000, rating: 0.0, pageCount: 384, isBestseller: false),
    Book(id: 80, title: "엘레강트 유니버스", author: "브라이언 그린", genre: 500, publishYear: 1999, price: 20000, rating: 4.3, pageCount: 512, isBestseller: false),
    
    // 81-90: 시/문학 (genre: 600)
    Book(id: 81, title: "꽃을 보듯 너를 본다", author: "나태주", genre: 600, publishYear: 2015, price: 10000, rating: 4.6, pageCount: 144, isBestseller: true),
    Book(id: 82, title: "서시", author: "윤동주", genre: 600, publishYear: 1948, price: 9800, rating: 4.8, pageCount: 128, isBestseller: true),
    Book(id: 83, title: "사랑하지 않으면", author: "이정하", genre: 600, publishYear: 2024, price: 13500, rating: 4.3, pageCount: 168, isBestseller: false),
    Book(id: 84, title: "모든 요일의 기록", author: "신달자", genre: 600, publishYear: 2020, price: 14000, rating: 4.1, pageCount: 184, isBestseller: false),
    Book(id: 85, title: "너에게 가는 길", author: "정호승", genre: 600, publishYear: 2019, price: 13000, rating: 4.4, pageCount: 176, isBestseller: false),
    Book(id: 86, title: "풀꽃", author: "나태주", genre: 600, publishYear: 2016, price: 12000, rating: 4.5, pageCount: 152, isBestseller: true),
    Book(id: 87, title: "백석 시집", author: "백석", genre: 600, publishYear: 1936, price: 11000, rating: 4.7, pageCount: 136, isBestseller: false),
    Book(id: 88, title: "2028 시선집", author: "한국시인협회", genre: 600, publishYear: 2028, price: 15000, rating: 0.0, pageCount: 224, isBestseller: false),
    Book(id: 89, title: "봄날", author: "김소월", genre: 600, publishYear: 1925, price: 10500, rating: 4.6, pageCount: 112, isBestseller: false),
    Book(id: 90, title: "사랑은 언제나", author: "류시화", genre: 600, publishYear: 2018, price: 14500, rating: 4.2, pageCount: 192, isBestseller: false),
    
    // 91-100: 경제/경영 (genre: 700)
    Book(id: 91, title: "넛지", author: "리처드 탈러", genre: 700, publishYear: 2008, price: 22000, rating: 4.3, pageCount: 488, isBestseller: true),
    Book(id: 92, title: "생각에 관한 생각", author: "대니얼 카너먼", genre: 700, publishYear: 2011, price: 25000, rating: 4.5, pageCount: 624, isBestseller: true),
    Book(id: 93, title: "제로 투 원", author: "피터 틸", genre: 700, publishYear: 2014, price: 16000, rating: 4.4, pageCount: 280, isBestseller: true),
    Book(id: 94, title: "린 스타트업", author: "에릭 리스", genre: 700, publishYear: 2011, price: 18000, rating: 4.2, pageCount: 356, isBestseller: false),
    Book(id: 95, title: "돈의 심리학", author: "모건 하우절", genre: 700, publishYear: 2020, price: 18000, rating: 4.5, pageCount: 336, isBestseller: true),
    Book(id: 96, title: "원씽", author: "게리 켈러", genre: 700, publishYear: 2012, price: 14000, rating: 4.3, pageCount: 272, isBestseller: true),
    Book(id: 97, title: "스틱", author: "칩 히스", genre: 700, publishYear: 2007, price: 16800, rating: 4.1, pageCount: 328, isBestseller: false),
    Book(id: 98, title: "타이탄의 도구들", author: "팀 페리스", genre: 700, publishYear: 2016, price: 25000, rating: 4.2, pageCount: 736, isBestseller: false),
    Book(id: 99, title: "2029 경제 대전망", author: "김경준", genre: 700, publishYear: 2028, price: 19500, rating: 0.0, pageCount: 368, isBestseller: false),
    Book(id: 100, title: "블랙스완", author: "나심 탈레브", genre: 700, publishYear: 2007, price: 23000, rating: 4.4, pageCount: 568, isBestseller: true)
]
