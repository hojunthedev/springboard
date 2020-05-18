<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/css/bootstrap.min.css">
<script src="<c:url value='/js/jquery-3.5.1.min.js'/>"></script>
<script src="/js/bootstrap.min.js"></script>
<script type="text/javascript" language="javascript" defer="defer">
function save(){
	alert('save');
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
	<div class="card-header">SpringBoot + MongoDB + Bootstrap4</div>
	<div class="card-body">
		<div class="row">
			<div class="col-lg-4">
				<div class="card" style="min-height:500px;max-height:1000px">
					<table class="table">
						<thead>
							<tr>
								<th>°Ô½Ã¹° ¸®½ºÆ®</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>¾È³çÇÏ¼¼¿ä</td>
							</tr>
							<tr>
								<td>¹Ý°©½À´Ï´Ù</td>
							</tr>
							<tr>
								<td>°í¸¿½À´Ï´Ù</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="col-lg-5">
				<div class="card bg-light text-dark" style="min-height:500px;max-height:1000px">
					<form action="">
						<div class="form-group">
							<label class="control-label" for="title">Á¦¸ñ</label>
							<div>
								<input type="text" class="form-control" id="title" placeholder="Á¦¸ñÀ» ÀÔ·ÂÇÏ¼¼¿ä">
							</div>
						</div>
						<div class="form-group">
							<label class="control-label" for="contents">³»¿ë</label>
							<div>
								<textarea class="form-control" rows="15" id="contents"></textarea>
							</div>
						</div>
						<div class="form-group">
							<label class="control-label" for="contents">ÀÌ¹ÌÁöÃ·ºÎ</label>
							<div>
								<input type="file" className="form-control" name="file" style="width:80%"/>
							</div>
						</div>
					</form>
					<div style="text-align:center">
						<div class=btn-group>
							<button type="button" class="btn btn-primary" onclick="save()">ÀúÀå</button>
							<button type="button" class="btn btn-default" onclick="cancel()">Ãë¼Ò</button>
							<button type="button" class="btn btn-default" onclick="del()">»èÁ¦</button>
							<button type="button" class="btn btn-default" onclick="picDelete()">±×¸²»èÁ¦</button>
							
						</div>
					</div>
				</div>
			</div>
			<div class="col-lg-3">
				<div class="card bg-light text-dark" style="min-height:500px;max-height:1000px">ÀÌ¹ÌÁö ¹Ì¸®º¸±â</div>
			</div>
		</div>
	</div>
	<div class="card-footer"><a href="http://www.naver.com" target="_blank">±êÇãºê ÀÚ·á</a></div>
</div>
</body>
</html>