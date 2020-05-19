<jsp:forward page="/board.do"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>index jsp</title>
<script type="text/javascript" language="javascript" defer="defer">
function main(){
	//location.href="board.html";
	location.href="/board.do"; //controller -> find requestmapping(board.do)
}
setTimeout(main, 3000);
</script>
</head>
<body>
hi
<h3>index jsp DESU</h3>
</body>
</html>