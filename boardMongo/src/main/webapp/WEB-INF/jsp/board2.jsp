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
					var contents = data.list[i].contents;
					contents = contents.replace(/\n/gi, '\\n');
					var txt = "<tr onclick=\"detail('"+data.list[i].id+"','"+data.list[i].title+"','"+contents+"','"+data.list[i].fname+"');\">";
					txt += "<td>" + data.list[i].title + "<span style=\"float:right\">" + data.list[i].date +"<td/>";
					txt += "</tr>"
					$('#list').append(txt);
					
				}
		})
		.fail(function(jqXHR, textStatus, errorThrown){
			alert("오류");
		});
}
function detail(id, title, contents, fname){
	//alert(title);
	//alert(contents);
	$('#id').val(id);
	$('#title').val(title);
	$('#contents').val(contents);
	$('#file').val("");

	setTimeout(getImg(fname), 500);
}
function getImg(fname){
	//var formData = new FormData();
	//formData.append('fname', fname);
	//get은 폼데이터가 안날아가는모양이에유
	$.ajax({
		url : "<c:url value='/img.do'/>?fname="+fname,
		processData : false, //0529 processDate -> processData
		contentType : false,
		method : "GET",
		cache : false,
		data : ''//formData
		//data : $("#form1").serialize()	//폼데이터 넘기는 법. #form1은 폼의 id
	})
	.done(function(data){
		if( data == "" ){	//액박처리, TODO:0613먹히지않음
			$('#img').attr("src", "");
		}
		else{
			$('#img').attr("src", "data:image/jpeg;base64," + data);
		}
	})
	.fail(function(jqXHR, textStatus, errorThrown){
		alert("오류");
	});
}
function save(){
	//alert('save');
	if(!confirm("저장 하시겠습니까?")){
		return;
	}
	//var formData = $('#form1').serialize();
	//var $ = jQuery;
	var formData = new FormData();
	formData.append('id', $('#id').val());
	formData.append('title', $('#title').val());  
	formData.append('contents', $('#contents').val());
	formData.append('file', $('#file')[0].files[0]);

	var url = "<c:url value='/add.do'/>";

	if($('#id').val() == ''){
		url = "<c:url value='/add.do'/>";
	}else{
		url = "<c:url value='/mod.do'/>";
	}

	$.ajax({
			url : url,
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
				alert("정상적으로 저장되었습니다.");
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
	$('#title').val('');
	$('#contents').val('');
}
function del(){
	var url = "<c:url value='/del.do'/>";

	if($('#id').val() == ''){
		alert("삭제할 대상이 존재하지 않습니다.");
		return;
	}
	if(!confirm("삭제 하시겠습니까?")){
		return;
	}
	
	var formData = new FormData();
	formData.append('id', $('#id').val());
	formData.append('title', $('#title').val());  
	formData.append('contents', $('#contents').val());
	
	$.ajax({
		url : "<c:url value='/del.do'/>",
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
			alert("정상적으로 삭제되었습니다.");
		}
		else{
			alert(data.returnDesc);
		}
	})
	.fail(function(jqXHR, textStatus, errorThrown){
		alert("오류");
	});
}
function picDelete(){
	if($('#id').val() == ''){
		alert("삭제할 대상이 존재하지 않습니다.");
		return;
	}
	if(!confirm("그림을 삭제 하시겠습니까?")){
		return;
	}
	
	var formData = new FormData();
	formData.append('id', $('#id').val());
	formData.append('title', $('#title').val());  
	formData.append('contents', $('#contents').val());
	
	$.ajax({
		url : "<c:url value='/delImg.do'/>",
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
			alert("정상적으로 삭제되었습니다.");
		}
		else{
			alert(data.returnDesc);
		}
	})
	.fail(function(jqXHR, textStatus, errorThrown){
		alert("오류");
	});
}
</script>
</head>
<body>
<div class="card">
	<div class="card-header">
		<ul class="nav nav-tabs">
			<li class="nav-item">
				<a class="nav-link" href="<c:url value='/board.do'/>">싱글이미지 게시판</a>
			</li>
			<li class="nav-item">
				<a class="nav-link active" href="<c:url value='/board2.do'/>">멀티이미지 게시판</a>
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
								<input type="file"  id="file"  class="form-control" multiple name="file" style="width:80%"/>
							</div>
						</div>
						<input type="hidden" id="id" name="id" />
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
				<div class="card bg-light text-dark" style="min-height:500px;max-height:1000px">
					<img src="" id="img" alt="image" style="max-width:100%">
				</div>
			</div>
		</div>
	</div>
	<div class="card-footer">SpringBoot 게시판만들기</div>
</div>
</body>
</html>