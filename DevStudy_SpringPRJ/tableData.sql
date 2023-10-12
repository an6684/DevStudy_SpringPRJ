# tb_user_01 data 추가
INSERT INTO tb_user_01 (userId,userPass,userName,userEmail,userRank,userFlag,regdate,`update`,userHpnum) VALUES
	 ('abcdef','ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f','123','ddddddddd@dddddddd','3','Y','2023-09-07 14:36:13',NULL,NULL),
	 ('admin','8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918','admin','admin@admin.com','1','Y','2023-09-06 14:40:09',NULL,NULL),
	 ('ffff','ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f','ddasd','abc@naver.com','3','Y','2023-09-06 15:48:27',NULL,NULL),
	 ('gabin','a5b83d4cd8c921e74a4705cc579d93937b5d3900ff828943ae4212ec056af545','이가빈','cccqksksk@nate.com','3','Y','2023-09-06 16:55:20',NULL,NULL),
	 ('rimtory','8bb0cf6eb9b17d0f7d22b456f121257dc1254e1f01665370476383ea776df414','rimtory','rimtory@naver.com','3','Y','2023-09-08 15:05:14',NULL,NULL),
	 ('sonny','9af15b336e6a9619928537df30b2e6a2376569fcf9d7e773eccede65606529a0','sonny','nboinkm@naver.com','1','Y','2023-09-06 14:34:51',NULL,NULL),
	 ('test01','c9fe854ea69fc0a252340e152864b539b116c36cf1ac419652e1826c3071d5ed','테스트용','test01@gmail.com','3','N','2023-09-11 11:05:04',NULL,NULL),
	 ('test02','c9fe854ea69fc0a252340e152864b539b116c36cf1ac419652e1826c3071d5ed','테스트용2','test02@gmail.com','3','N','2023-09-11 12:00:10',NULL,NULL),
	 ('test03','c9fe854ea69fc0a252340e152864b539b116c36cf1ac419652e1826c3071d5ed','테스트용3','test03@gmail.com','3','N','2023-09-11 12:01:34',NULL,NULL),
	 ('tleowjdtls','2558a34d4d20964ca1d272ab26ccce9511d880579593cd4c9e01ab91ed00f325','tleowjdtls1111','tleowjdtls@naver.com','3','Y','2023-09-11 13:21:27',NULL,NULL);
     
     INSERT INTO tb_user_01 (userId,userPass,userName,userEmail,userRank,userFlag,userHpnum) VALUES
	 ('teacher1',SHA2('teacher1', 256),'teacher1','teacher1@naver.com','2','Y','010-1111-1111'),
	 ('teacher2',SHA2('teacher2', 256),'teacher2','teacher2@naver.com','2','Y','010-2222-2222'),
	 ('teacher3',SHA2('teacher3', 256),'teacher3','teacher3@naver.com','2','Y','010-3333-3333'),
	 ('user1',SHA2('user1', 256),'user1','user1@naver.com','3','Y','010-1234-5678'),
	 ('user2',SHA2('user2', 256),'user2','user2@naver.com','3','Y','010-2345-6789');

# tb_video_categories data 추가
INSERT INTO tb_subject_categories (sbj_nm)
VALUES ('HTML/CSS'), ('JAVASCRIPT'), ('DATABASE'), ('JSP'), ('SPRING');

# tb_video table_dummy data
INSERT INTO tb_video (video_title, video_description, video_url, video_uploader_id, category_id)
VALUES
('CSS란 무엇일까?', 'CSS의 의미, 정의를 알아보고 선택자, 스타일링, 헷갈리는 컨셉, Flex box에 대해서 알아봅시다!', 'gGebK7lWnCk', 'teacher1', 1),
('CSS 레이아웃 정리', 'display, position의 기본값과 속성값들을 알아봅시다! ', 'jWh3IbgMUPI', 'teacher1', 1),
('CSS 한번에 끝내기!!', '웹 페이지 스타일 정의를 다양한 예제와 함께 따라하면서 배우기', 'J3ef9c-sZ14', 'teacher3', 1),
('CSS 30분 요약!', '간단하고 빠르게 CSS를 학습하세요!', '_PeEALPPauk', 'teacher1', 1),
('초보자를 위한 CSS 기초', '완전 초심자를 위해서 천천히 재밌게 CSS를 알려드립니다!', 'sZXr_4fmz5o', 'teacher1', 1),
('HTML 한번에 끝내기!!', 'HTML의 개념과 구조부터 각종 태그를 사용하며 배워보세요!', 'VozMYcCYvtg', 'teacher1', 1),

('자바스크립트 기초 30분 완성!', 'JAVA와 Javascript의 차이와 자바스크립트의 역할, 변수, 함수, 조건문, 반복문을 배워보세요!', 'E-PzX2mKGUQ', 'teacher1', 2),
('100분만에 끝내는 자바스크립트 기초', '자바스크립트의 기초를 자세하고 완벽하게 알려드립니다.', 'KF6t61yuPCY', 'teacher2', 2),
('140분만에 끝내는 자바스크립트 중급', '자바스크립트의 어느정도 지식을 알고 있으신분들이 들으면 좋은 강의입니다.', '4_WLS9Lj6n4', 'teacher1', 2),
('제대로 파는 자바스크립트 끝.장.내.기!', '자바스크립트의 문법, 객체지향 등 클린하고 깨끗하게 코딩하는 방법을 알려드립니다.', 'RHoPpjKRT38', 'teacher2', 2),
('30분에 끝내는 자바스크립트', '30분에 빠르게 자바스크립트에 대해서 배우는게 가능합니다!', 'NQZZyVM8ksw', 'teacher1', 2),

('왕초보용! 데이터베이스 강좌', '비전공자도 알 수 있게 편하게 배우는게 가능한 강좌입니다.', 'dgpBXNa9vJc', 'teacher3', 3),
('데이터 베이스 SQL문', 'SQL이 완전 처음이신 분들께 처음부터 쉽게 설명 드립니다.', 'muOKnEIUA8Y', 'teacher2', 3),
('한시간에 끝내는 SQL입문', 'SQL문에서 여러가지 데이터를 검색하는 방법을 알려드립니다.', '1lmfJ8LHquw', 'teacher1', 3),
('SQL 초보자가 꼭 알아야 하는 10가지 문법!', 'SQL초보자가 꼭 알아야하는 기초 문법을 자세하게 설명드립니다.', 'ZsYnTSSuSiw', 'teacher3', 3),
('회사에서 많이 쓰는 기초 SQL문', '회사에서 데이터분석가로 근무하면서 자주 사용하는 SQL문을 알려드립니다.', 'XN4iXklAnQw', 'teacher2', 3),

('[JSP] 서블릿 개념 핥기!', 'JSP파일 요청 처리, Servelet 요청 처리에 대해서 다룬 영상입니다.', 'g5KmJAIIEeI', 'teacher3', 4),
('Cookie를 이용해 상태값 유지하기', '쿠키가 왜 필요한가? 어떻게 사용하는가?  보기 쉽게 정리한 영상입니다.', 'ONtMvVocGy8', 'teacher2', 4),
('Session(세션) 이해하기', '세션이란 무엇인가? 세션과 쿠키는 뭐가 다른건가? 세션 쿠키는 뭘까에 대해서 다룬 영상입니다.', 'VrWK1VPW5Qg', 'teacher3', 4),
('JSP의 동작 원리', 'JSP는 도대체 어떤 동작 원리를 갖고 서비스가 이뤄지는지 JSP와 서블릿의 관계에 대해서 알아봅시다. ', '54j-78_LcXE', 'teacher2', 4),
('세션 잘라 먹기 실습!', '강의 시청과 직접 실습을 통해서 따라해보세요!', 'gN6ifi6FJTk', 'teacher3', 4),

('한시간에 끝내는 스프링 부트 기본기', '스프링과 스프링 부트의 차이와 기본 지식을 탄탄하게 알려드립니다.', 'AalcVuKwBUM', 'teacher3', 5),
('스프링 부트 기초 강의', '인터페이스부터 기초, GoF의 디자인 패턴 예외 처리등 한편에 모든것을 담았습니다.', '7t6tQ4KV37g', 'teacher2', 5),
('스프링과 스프링 부트의 차이', '스프링과 스프링 부트의 차이를 알려드리고, 프레임워크의 특징과 제공하는 기능에 대해서 알아보겠습니다.', 'YSsl5-q2BR4', 'teacher3', 5),
('SPRING Boot 개요', '스프링 부트의 기본 개념에 대해서 완벽하게 파헤치는 강의!', 'MFT2s6ijTws', 'teacher2', 5),
('프로젝트 생성부터 구조 살펴보기!', '스프링 부트의 프로젝트를 만들어보고 기본 구조가 어떻게 되어있는지 살펴봅시다.', 'rHJgMRimJ4Y', 'teacher3', 5);

#공지사항 테이블 dummy data
INSERT INTO tb_notice_01 (title, content, writedid)
VALUES
('반갑습니다 teacher1 입니다.', '반갑습니다. teacher1 공지사항 내용입니다.', 'teacher1'),
('반갑습니다 teacher2 입니다.', '반갑습니다. teacher2 공지사항 내용입니다.', 'teacher2'),
('반갑습니다 teacher3 입니다.', '반갑습니다. teacher3 공지사항 내용입니다.', 'teacher3'),
('반갑습니다 관리자 입니다.', '반갑습니다. 관리자 공지사항 내용입니다.', 'admin');

INSERT INTO tb_notice_01 (title, content, writedid)
VALUES
('반갑습니다 teacher2 입니다.', '반갑습니다. teacher2 공지사항 내용입니다.', 'teacher2'),
('반갑습니다 teacher3 입니다.', '반갑습니다. teacher3 공지사항 내용입니다.', 'teacher3');