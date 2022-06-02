<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>      
<c:set var="ctx" value="${pageContext.request.contextPath}"/>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <script type="text/javascript">
     function add(){
    	// form의 데이터 유효성 체크..
    	document.form1.action="<c:url value='/memberInsert.do'/>"; 
    	document.form1.submit();
     }
     function frmreset(){
   	  document.form1.reset();
     }
     function doublecheck(){
    	 if($("#id").val()==''){
    		 alert("아이디를 입력하세요.");
    		 $("#id").focus();
    		 return;
    	 }
    	 var id=$("#id").val();
    	 $.ajax({ 
    		 url : "<c:url value='/memberDbcheck.do'/>",
    		 type : "POST",
    		 data : {"id" : id},
    		 success : dbCheck,  //함수(callback)
    		 error : function(){ alert("error"); }    		 
    	 });
     }     
     function dbCheck(data){    	
    	 if(data !="NO"){
    		 alert("중복된 아이디 입니다.");
    		 $("#id").focus();
    	 }else{
    		 alert("사용가능한 아이디 입니다.");
    		 $("#id").focus();
    	 }    	 
     }
     function add2(){
    	 if($("#file").val()!=''){ // 파일이 첨부가 된 경우...
    		 var formData=new FormData();
    	     formData.append("file", $("input[name=file]")[0].files[0]);
    		 $.ajax({
    			 url : "<c:url value='/fileAdd.do'/>", // fileAdd.do(파일업로드)
    			 type : "post",
    			 data : formData,
    			 processData : false,
    			 contentType : false,
    			 success : function(data){  //업로드된 실재파일 이름을 전달 받기
    				// alert(data);
    				$('#filename').val(data);  
    			    document.form1.action="<c:url value='/memberInsert.do'/>?mode=fadd"; // text데이터를 저장하는 부분
    			    document.form1.submit();//id, pass, name, age, email, phone, filename
    			 },
    			 error : function(){ alert("error"); }
    		 });    		 
    	 }else{ // 파일이 첨부 되지 않은 경우...
    		 document.form1.action="<c:url value='/memberInsert.do'/>?mode=add"; 
			 document.form1.submit();//id, pass, name, age, email, phone, X
    	 }
     }
  </script>
</head>
<body>
<div class="container">
  <h2>회원가입화면</h2>
  <div class="panel panel-default">
    <div class="panel-heading">
      <c:if test="${sessionScope.userId!=null && sessionScope.userId!=''}">
       <label>${sessionScope.userName}님이 로그인 하셨습니다.</label>
      </c:if>
      <c:if test="${sessionScope.userId==null || sessionScope.userId==''}">
      <label>안녕하세요</label>
      </c:if> 
    </div>
    <div class="panel-body">
     <form id="form1" name="form1" class="form-horizontal" method="post">
	  <div class="form-group">
	    <label class="control-label col-sm-2" for="id">아이디:</label>
	    <div class="col-sm-10">
	      <table>
	        <tr>
	          <td><input type="text" class="form-control" id="id" name="id" placeholder="아이디를 입력하세요"></td>
	          <td><input type="button" value="중복체크" onclick="doublecheck()" class="btn btn-warning"></td>
	        </tr>	        
	      </table>
	    </div>
	  </div>
	  <div class="form-group">
	    <label class="control-label col-sm-2" for="pass">비밀번호:</label>
	    <div class="col-sm-10">
	      <input type="password" class="form-control" id="pass" name="pass" placeholder="비밀번호를 입력하세요" style="width: 30%">
	    </div>
	  </div>
	   <div class="form-group">
	    <label class="control-label col-sm-2" for="name">이름:</label>
	    <div class="col-sm-10">
	      <input type="text" class="form-control" id="name" name="name" placeholder="이름을 입력하세요" style="width: 30%">
	    </div>
	  </div>
	    <div class="form-group">
	    <label class="control-label col-sm-2" for="age">나이:</label>
	    <div class="col-sm-10">
	      <input type="text" class="form-control" id="age" name="age" placeholder="나이입력" style="width: 10%">
	    </div>
	  </div>
	    <div class="form-group">
	    <label class="control-label col-sm-2" for="email">이메일:</label>
	    <div class="col-sm-10">
	      <input type="text" class="form-control" id="email" name="email" placeholder="이메일을 입력하세요" style="width: 30%">
	    </div>
	  </div>
	    <div class="form-group">
	    <label class="control-label col-sm-2" for="pass">전화번호:</label>
	    <div class="col-sm-10">
	      <input type="text" class="form-control" id="phone" name="phone" placeholder="전화번호를 입력하세요" style="width: 30%">
	    </div>
	  </div>
	  <div class="form-group">
	    <label class="control-label col-sm-2" for="">첨부파일:</label>
	    <div class="col-sm-10">
	      <input type="file" class="control-label" id="file" name="file">
	    </div>
	  </div>	  	
	    <input type="hidden" name="filename" id="filename" value="">
	 </form>
    </div>
    <div class="panel-footer" style="text-align: center;">       
       <c:if test="${sessionScope.userId==null || sessionScope.userId==''}"> 
         <input type="button" value="등록" class='btn btn-primary' onclick="add2()"/>
       </c:if>
       <c:if test="${sessionScope.userId!=null && sessionScope.userId!=''}"> 
          <input type="button" value="등록" class='btn btn-primary' onclick="add()" disabled="disabled"/>
       </c:if>
    
       <input type="button" value="취소" class='btn btn-warning' onclick="frmreset()"/>
       <input type="button" value="리스트" onclick="location.href='${ctx}/memberList.do'" class='btn btn-success'/>
    </div>
  </div>
</div>
</body>
</html>