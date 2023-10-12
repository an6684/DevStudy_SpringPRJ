# tb_user_01 table
CREATE TABLE tb_user_01 (
  userId varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '사용자ID',
  userPass varchar(100) COLLATE utf8mb4_bin NOT NULL COMMENT '사용자PASSWORD',
  userName varchar(100) COLLATE utf8mb4_bin NOT NULL COMMENT '사용자명',
  userEmail varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '사용자email',
  userRank varchar(3) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '사용자등급',
  userFlag varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT 'Y' COMMENT '계정 사용여부',
  regdate timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일',
  `update` timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일',
  userHpnum varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '사용자 연락처',
  PRIMARY KEY (userId)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='사용자 정보 테이블';

# tb_video_categories table
CREATE TABLE tb_subject_categories (
  sbj_id INT(11) NOT NULL AUTO_INCREMENT,
  sbj_nm VARCHAR(50) COLLATE utf8mb4_bin NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (sbj_id)
);

DROP TABLE tb_subject_categories;
select * from tb_subject_categories;

# tb_video table
CREATE TABLE tb_video (
  video_id INT(11) NOT NULL AUTO_INCREMENT COMMENT '동영상 id',
  video_title VARCHAR(255) COLLATE utf8mb4_bin NOT NULL COMMENT '동영상 title',
  video_description TEXT COLLATE utf8mb4_bin NOT NULL COMMENT '동영상 description',
  video_url VARCHAR(255) COLLATE utf8mb4_bin NOT NULL COMMENT '동영상 url',
  video_uploader_id varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '업로더 id',
  video_uploaded_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '업로드 날짜',
  useFlag varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT 'Y' COMMENT '동영상 사용여부',
  category_id INT(11) NOT NULL COMMENT 'subject id',
  PRIMARY KEY (video_id),
  FOREIGN KEY (video_uploader_id) REFERENCES tb_user_01(userId),
  FOREIGN KEY (category_id) REFERENCES tb_subject_categories(sbj_id)
);

#공지사항 테이블 
CREATE TABLE `tb_notice_01` (
  `content_id` INT(11) NOT NULL AUTO_INCREMENT COMMENT '작성글ID',
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '작성글제목',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '작성글내용',
  `regdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '작성글등록일',
  `useFlag` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT 'Y' COMMENT '작성글사용여부',
  `writedid` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '작성글작성자ID',
  `filepath` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '첨부파일경로',
  PRIMARY KEY (`content_id`),
  FOREIGN KEY (writedid) REFERENCES tb_user_01(userId)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

select * from tb_notice_01;
DROP TABLE tb_notice_01;


# 공지사항 댓글 테이블
CREATE TABLE `tb_notice_02` (
  `comment_id` INT(11) NOT NULL AUTO_INCREMENT COMMENT '작성댓글번호',
  `content_id` int NOT NULL COMMENT '게시글글번호',
  `writedid` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '댓글작성자ID',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '댓글내용',
  `useFlag` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT 'Y' COMMENT '작성글사용여부',
  `regdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '댓글등록일',
  PRIMARY KEY (`comment_id`),
  KEY `tb_notice_02_FK` (`content_id`),
  CONSTRAINT `tb_notice_02_FK` FOREIGN KEY (`content_id`) REFERENCES `tb_notice_01` (`content_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin; 

#게시판 테이블 
CREATE TABLE `tb_board_01` (
  `content_id` INT(11) NOT NULL AUTO_INCREMENT COMMENT '작성글ID',
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '작성글제목',
  `content` LONGTEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '작성글내용',
  `regdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '작성글등록일',
  `useFlag` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT 'Y' COMMENT '작성글사용여부',
  `writedid` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '작성글작성자ID',
  `filepath` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '첨부파일경로',
  PRIMARY KEY (`content_id`),
  FOREIGN KEY (writedid) REFERENCES tb_user_01(userId)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

# 게시판 댓글 테이블
CREATE TABLE `tb_board_02` (
  `comment_id` INT(11) NOT NULL AUTO_INCREMENT COMMENT '작성댓글번호',
  `content_id` int NOT NULL COMMENT '게시글글번호',
  `writedid` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '댓글작성자ID',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '댓글내용',
  `useFlag` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT 'Y' COMMENT '작성글사용여부',
  `regdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '댓글등록일',
  PRIMARY KEY (`comment_id`),
  KEY `tb_board_02_FK` (`content_id`),
  CONSTRAINT `tb_board_02_FK` FOREIGN KEY (`content_id`) REFERENCES `tb_board_01` (`content_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin; 

# 관심목록 테이블
CREATE TABLE tb_cart (
  cart_id INT NOT NULL AUTO_INCREMENT COMMENT '관심목록 번호',
  video_id int NOT NULL COMMENT '비디오 번호',
  user_id varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '사용자ID',
  regdate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '관심목록 추가 날짜',
  PRIMARY KEY (cart_id),
  FOREIGN KEY (user_id) REFERENCES tb_user_01(userId),
  FOREIGN KEY (video_id) REFERENCES tb_video(video_id)
);
