<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<c:set var="dt" value="<%=System.currentTimeMillis()%>"/>

<style>
.ck-editor__editable {
  min-height: 500px;
}
.button-container {
    text-align: right;
}
.button-container .btn {
    margin-left: 10px; 
}
</style>

<div class="card">
    <div class="content table-responsive table-full-width">
    
    <form id="frm-post-register"
    	  method="POST"
    	  enctype="multipart/form-data"
          action="${contextPath}/community/registerPost.do">
          
        <input type="hidden" name="brdCode" id="brdCode" value="REFE">
        <table class="table table-hover table-striped">
            <tbody>
                <tr>
                    <th>구분</th>
                    <td>자료실 글쓰기</td>
                </tr>
                <tr>
                    <th style="width:100px">작성자</th>
                    <td>${sessionScope.emp.empName}</td>
                </tr>
                <tr>
                    <th>제목</th>
                    <td>
                        <input type="text" name="postTitle" id="postTitle" class="form-control" placeholder="제목을 입력해주세요">
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <textarea name="postContent" id="editor"  placeholder="내용을 입력해주세요"></textarea>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <input type="file" name="files" id="files" multiple>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                    	<div id="attach-list"></div>
                    </td>
                </tr>
                <tr >
                	<th>중요공지여부</th>
                	<td>
	                    <input type="checkbox" id="postOpenYn" name="postOpenYn" value="${postOpenYn}">
                	</td>
                </tr>
                <tr>
                    <td colspan="2">
                      <input type="hidden" name="empCode" id="empCode" value="${sessionScope.emp.empCode}">
                      <input type="hidden" name="empName" id="empName" value="${sessionScope.emp.empName}">
                      <input type="hidden" name="deptCode" id="deptCode" value="${emp.deptCode}">
                      <input type="hidden" name="postState" id="postState" value="1">
                      <div class="button-container">
	                      <button type="submit" class="btn btn-info btn-fill" id="submit" onclick="confirmSubmit()">작성</button>
	                      <button onclick="history.back()" type="button" class="btn btn-danger btn-fill" id="cancel">취소</button>
                      </div>
                    </td>
                </tr>
            </tbody>
        </table>
    </form>
    </div>
</div>


<script src="${contextPath}/ckeditor5/ckeditor.js"></script>
<script src="${contextPath}/ckeditor5/script.js"></script>
<script>
let editor;
ClassicEditor
.create( document.querySelector( '#editor' ) )
.then( newEditor => {
    editor = newEditor;
} )
.catch( error => {
    console.error( error );
} );


// 제목 입력 필수
function validateForm(evt) {
    if (document.getElementById('postTitle').value === '') {
        alert('제목 입력은 필수입니다.');
        evt.preventDefault();
        return;
    }
}

//등록
function register() {
	
    document.getElementById('frm-post-register').addEventListener('submit', validateForm);
    document.getElementById('postOpenYn').addEventListener('change', function() {
        this.value = this.checked ? 'Y' : 'N';
    });
}

//등록 확인
function confirmSubmit() {
    const confirmSubmission = confirm('글을 작성하시겠습니까?');

    if (confirmSubmission) {
        document.getElementById('frm-post-register').submit();
    }
}

//크기 제한 스크립트 + 첨부 목록 출력 스크립트
const fnAttachCheck = () => {
  document.getElementById('files').addEventListener('change', (evt) => {
    const limitPerSize = 1024 * 1024 * 10;
    const limitTotalSize = 1024 * 1024 * 100;
    let totalSize = 0;
    const files = evt.target.files;
    const attachList = document.getElementById('attach-list');
    attachList.innerHTML = '';
    for(let i = 0; i < files.length; i++){
      if(files[i].size > limitPerSize){
        alert('각 첨부 파일의 최대 크기는 10MB입니다.');
        evt.target.value = '';
        attachList.innerHTML = '';
        return;
      }
      totalSize += files[i].size;
      if(totalSize > limitTotalSize){
        alert('전체 첨부 파일의 최대 크기는 100MB입니다.');
        evt.target.value = '';
        attachList.innerHTML = '';
        return;
      }
      attachList.innerHTML += '<div>' + files[i].name + '</div>';
    }
  })
}


// 호출
register();
fnAttachCheck();

</script>