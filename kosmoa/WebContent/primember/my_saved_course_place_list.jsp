<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="reset.css" />
</head>
<style>
	#my-saved-manage { 
		display:flex;
		margin-top : 120px;
		width:1200px; height:1600px;
	} 
	/* 네비 영역 */
	#left-navi { 
			 width:300px; height:1500px;
			border:1px solid black;
			border-radius : 40px 40px 40px 40px;
			margin-top: 60px; margin-right: 20px; margin-left: 100px;
	}
	li { margin:40px; }
	.li-indent { text-indent: 1em; }
	.tab01, .tab02 { display:inline-block; width:100px; height:50px; }
	.tab03 { display:inline-block; width:400px; height:50px; text-align:right; }

	/* 저장한 장소 영역 */
	#boardBox { 
		width:800px;
		position:relative;	margin:100px 8px 35px 50px;	height:155px;
	} 

	#courList {
		width:800px; 
	}
	/* 처음에는 코스영역만 보여줌 */
	#plaList{
		width:800px; display:none;
	}
	
	/* 코스 이미지 */	
	.cour-img { width:150px; height:150px; }
	.courList { display:flex; }
	.cour-name { width:300px; height:150px; }
	.chkDel { width:130px; height:150px; text-align:right; }
	
	/* 페이징 영역 */
	.more { width:800px; text-align:center; }
	.more a { display:inline-block; width:20px; margin-right:20px; }
	
	</style>
	
	<script>
	function tab(chk){
	var cour = document.getElementById("courList");
	var place = document.getElementById("plaList");
		if (chk == "c"){
			place.style.display="none";
			cour.style.display="block";
		}else {
			place.style.display="block";
			cour.style.display="none";
		}
	}
	</script>
<body>
<div id="my-saved-manage">
	<div id="left-navi">	<!-- 왼쪽 네비 영역 -->
	<ul>
		<li>정보 보기</li>
			<ul><li class="li-indent">- 내 정보 보기</li></ul>
		<li>예약 관리</li>
			<ul><li class="li-indent">- 예약 현황</li></ul>
		<li>후기 및 댓글 관리</li>
			<ul><li class="li-indent">- 내가 쓴 후기</li></ul>
			<ul><li class="li-indent">- 내가 쓴 댓글</li></ul>
		<li>저장된 코스 및 장소 관리</li>
		<li> 내 코스 관리 </li>
	</ul>
	</div>

	<div id="boardBox">
	<form name="saveFrmDel" action="" method="post">
		<input type="hidden" value="n" name="del" /> 	<!-- 하단 삭제 버튼 누를시 value가 변해야 함  -->
		<span class="tab01" onclick="tab('c');">저장한 코스</span> <span class="tab02" onclick="tab('p');">저장한 장소</span> 
		<span class="tab03"><input type="button" name="isDelbtn" value="삭제하기" onclick ="this.form.del.value='y'; "/></span>
		<div id="courList">
			<div class="courList">
				<p class="cour-img">
					<img src="" alt="코스이미지" />
				</p>
				<p class="cour-name">
					<a href="#">코스 이름</a>
				</p>
				<p class="chkDel">
					<input type="checkbox" value="y" />
				</p>
			</div>
			<div class="courList">
				<p class="cour-img">
					<img src="" alt="코스이미지" />
				</p>
				<p class="cour-name">
					<a href="#">코스 이름</a>
				</p>
				<p class="chkDel">
					<input type="checkbox" value="y" />
				</p>
			</div>
			<div class="courList">
				<p class="cour-img">
					<img src="" alt="코스이미지" />
				</p>
				<p class="cour-name">
					<a href="#">코스 이름</a>
				</p>
				<p class="chkDel">
					<input type="checkbox" value="y" />
				</p>
			</div>
		</div>
			
		<div id="plaList">
			<div class="courList">
				<p class="cour-img">
					<img src="" alt="장소이미지" />
				</p>
				<p class="cour-name">
					<a href="#">장소 이름</a>
				</p>
				<p class="chkDel">
					<input type="checkbox" value="y" />
				</p>
			</div>
			<div class="courList">
				<p class="cour-img">
					<img src="" alt="장소이미지" />
				</p>
				<p class="cour-name">
					<a href="#">장소 이름</a>
				</p>
				<p class="chkDel">
					<input type="checkbox" value="y" />
				</p>
			</div>
			<div class="courList">
				<p class="cour-img">
					<img src="" alt="장소이미지" />
				</p>
				<p class="cour-name">
					<a href="#">장소 이름</a>
				</p>
				<p class="chkDel">
					<input type="checkbox" value="y" />
				</p>
			</div>
		</div>
		<p class="more">
			<a href="#">1</a><a href="#">2</a><a href="#">3</a>
		</p>
	</div>
	</form>
</div>
</body>
</html>