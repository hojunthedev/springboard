<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>board jsp</title>
<link rel="stylesheet" href="/css/bootstrap.min.css">
<script src="/js/jquery-3.5.1.min.js"></script>
<script src="/js/bootstrap.min.js"></script>
<script type="text/javascript" language="javascript" defer="defer">
$( document ).ready(function(){
	list();
});
function list(){
	$.ajax({
			url : "<c:url value='/list.do'/>",
			processData : false,
			contentType : false,
			method : "GET",
			cache : false,
			data : ''
		})
		.done(function(data){
			//alert(data.list.length);
			$('#list').children().remove();
			for(var i=0;i<data.list.length;i++)
				{
					var txt = "<tr onclick=\"detail('"+data.list[i].title+"','"+data.list[i].contents+"');\">";
					txt += "<td>" + data.list[i].title + "<span style=\"float:right\">" + data.list[i].date +"<td/>";
					txt += "</tr>"
					$('#list').append(txt);
				}
		})
		.fail(function(jqXHR, textStatus, errorThrown){
			alert("오류");
		});
}
function detail(title, contents){
	alert(title);
	alert(contents);
}
function save(){
	alert('save');
	//var formData = $('#form1').serialize();
	//var $ = jQuery;
	var formData = new FormData();
	//formData.appen('title', this.refs.title.value);
	formData.append('title', $('#title').val());  
	formData.append('contents', $('#contents').val());
	
	$.ajax({
			url : "<c:url value='/add.do'/>",
			processData : false, //0529 processDate -> processData
			contentType : false,
			method : "POST",
			cache : false,
			data : formData
			//data : $("#form1").serialize()	//폼데이터 넘기는 법. #form1은 폼의 id
		})
		.done(function(data){
			if(data.returnCode =='success'){
				list();
			}
			else{
				alert(data.returnDesc);
			}
		})
		.fail(function(jqXHR, textStatus, errorThrown){
			alert("오류");
		});
}
function cancel(){
	alert('cancel');
}
function del(){
	alert('delete');
}
function picDelete(){
	alert('delete image');
}
</script>
</head>
<body>
<div class="card">
	<div class="card-header">
		<ul class="nav nav-tabs">
			<li class="nav-item">
				<a class="nav-link active" href="#">싱글이미지 게시판</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="#">멀티이미지 게시판</a>
			</li>
		</ul>
	</div>
	<div class="card-body">
		<div class="row">
			<div class="col-lg-4">
				<div class="card" style="min-height:500px;max-height:1000px">
					<table class="table">
						<thead>
							<tr>
								<th>게시물 리스트</th>
							</tr>
						</thead>
						<tbody id="list">
							<tr>
								<td>안녕하세요</td>
							</tr>
							<tr>
								<td>반갑습니다</td>
							</tr>
							<tr>
								<td>그럼2만</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="col-lg-5">
				<div class="card bg-light text-dark" style="min-height:500px;max-height:1000px">
					<form id="form1" name="form1" action="">
						<div class="form-group">
							<label class="control-label" for="title">제목</label>
							<div>
								<input type="text" class="form-control" id="title" placeholder="제목을 입력하세요">
							</div>
						</div>
						<div class="form-group">
							<label class="control-label" for="contents">내용</label>
							<div>
								<textarea class="form-control" rows="15" id="contents"></textarea>
							</div>
						</div>
						<div class="form-group">
							<label class="control-label">이미지 첨부</label>
							<div>
								<input type="file" class="form-control" name="file" style="width:80%"/>
							</div>
						</div>
					</form>
					<div style="text-align:center">
						<div class=btn-group>
							<button type="button" class="btn btn-primary" onclick="save()">저장</button>
							<button type="button" class="btn btn-secondary" onclick="cancel()">취소</button>
							<button type="button" class="btn btn-danger" onclick="del()">삭제</button>
							<button type="button" class="btn btn-info" onclick="picDelete()">그림삭제</button>
						</div>
					</div>
				</div>
			</div>
			<div class="col-lg-3">
				<div class="card bg-light text-dark" style="min-height:500px;max-height:1000px">이미지 미리보기</div>
			</div>
		</div>
	</div>
	<div class="card-footer">SpringBoot 게시판만들기</div>
</div>
</body>
</html>