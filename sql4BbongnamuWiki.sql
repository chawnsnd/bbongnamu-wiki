-- [ BbongnamuWiki 프로젝트 테이블 구조 ]

--회원 정보 테이블
create table tbl_user (
	num			number			primary key,				--식별번호
	id			varchar2(20) 	unique			not null,	--회원ID
	password	varchar2(100) 	not null,					--비밀번호
	salt		varchar2(5)		not null,					--비밀번호솔트
	type		varchar2(20)	default 'GENERAL'	not null--회원타입
		check (type in ('GENERAL', 'ADMIN', 'WITHDRAWAL'))
);
create sequence seq_user;

-- 위키 정보 테이블
create table tbl_wiki (
	num			number			primary key,	--식별번호
	title		varchar2(200)	not null		--제목
);
create sequence seq_wiki;

-- 위키 역사 정보 테이블
create table tbl_history (
	num			number			primary key,	--식별번호
	wikinum		number			not null,		--위키 식별번호
	usernum		number			not null,		--작성자 식별번호
	content		clob,							--내용
	explanation	varchar2(200),					--추가 설명
	writedate	date			default sysdate	not null,
	type		varchar2(20)	not null		--역사타입
		check (type in ('CREATE', 'UPDATE', 'REVERT', 'DELETE')),
	revertnum	number,							--롤백시 롤백한 위키의 넘버
	constraint history_fk_wiki foreign key(wikinum)
		references tbl_wiki(num) on delete cascade,
	constraint history_fk_user foreign key(usernum)
		references tbl_user(num) on delete set null,
	constraint histroy_fk_revert foreign key(revertnum)
		references tbl_history(num) on delete set null
);
create sequence seq_history;
Insert into TBL_USER (NUM,ID,PASSWORD,SALT,TYPE) values (2,'test','91510caf37c63c29ba21ed90325867e3908600a4a293d67d01cf51a9c1bca51b','vt','GENERAL');
Insert into TBL_USER (NUM,ID,PASSWORD,SALT,TYPE) values (1,'admin','3233907b626311166f6c33a1f4306563242709788db8a3f4d00d935833f3ac8d','2A','GENERAL');

Insert into TBL_WIKI (NUM,TITLE) values (1,'뽕나무위키:대문');
Insert into TBL_WIKI (NUM,TITLE) values (2,'뽕나무위키:사용법');

Insert into TBL_HISTORY (NUM,WIKINUM,USERNUM,CONTENT,EXPLANATION,WRITEDATE,TYPE,REVERTNUM) values (1,1,2,'<p><strong>여러분이 가꾸어 나가는 지식의 뽕나무</strong></p><p><br />뽕나무위키에 오신 것을 환영합니다!<br />뽕나무위키는 누구나 기여할 수 있는 위키입니다.<br />검증되지 않았거나 편향된 내용이 있을 수 있습니다.</p>',null,to_date('20/03/07','RR/MM/DD'),'CREATE',null);
Insert into TBL_HISTORY (NUM,WIKINUM,USERNUM,CONTENT,EXPLANATION,WRITEDATE,TYPE,REVERTNUM) values (2,2,2,'<p>1. 검색 키워드가 일치하는 위키문서가 있을 경우 바로 위키문서를 보여줍니다.<br />2. 검색 키워드와 일치하는 위키문서가 없을 경우 제목이나 내용에 키워드를 포함한 위키문서들의 목록이 검색됩니다.<br />3. 검색 키워드와 일치하는 위키문서가 없을 경우에만 새로운 위키문서를 작성할 수 있습니다.<br />4. 위키문서의 등록 및 수정, 삭제는 로그인한 회원만 가능합니다.<br />5. 각 위키문서의 [역사]탭을 통해 해당 위키문서가 변경된 이력을 볼 수 있으며, [이 리비전으로 되돌리기]기능을 통해 이전 역사로 되돌릴 수 있습니다.<br />6. 위키문서의 편집은 HTML 태그로 작성할 수 있습니다.</p>',null,to_date('20/03/07','RR/MM/DD'),'CREATE',null);
commit;