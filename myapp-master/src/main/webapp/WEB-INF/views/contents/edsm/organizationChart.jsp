<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<c:set var="dt" value="<%=System.currentTimeMillis()%>"/>

<link rel="stylesheet" href="${contextPath}/jstree/dist/themes/proton/style.css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

<style>
.fa-arrow-rotate-right {
  cursor: pointer;
}
</style>

<jsp:include page="../../layout/header.jsp"/>
<div class="main-content">
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-3">
                <div class="card">
                    <div class="header">
                        조직도 
						<i class="fa-solid fa-arrow-rotate-right" onclick="refreshPage()"></i>					
					</div>
                    <div class="content table-responsive table-full-width">
                        <div id="jstree"></div>
                    </div>
                </div>
            </div>
            <div class="col-md-9">
                <div class="card">
                    <div class="header">
                        <h4 class="title">직원 정보</h4>
                    </div>
                    <div class="content">
                        <div class="row">
                            <div class="col-md-12">
                            <div>
								<img class="avatar border-gray" id="profileImage" src="${contextPath}/resources/img/default_thumbnail.png" alt="기본 프로필" style="width: 150px; height: 150px;" />
                            </div>
                                <br><br>                            
                                <div class="form-group">
                                    <label>프로필</label>
                                </div>
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label>이름</label>
                                    <input type="text" class="form-control" placeholder="이름" id="empName" disabled>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label>사번</label>
                                    <input type="text" class="form-control" placeholder="사번" id="empCode" disabled>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label>부서</label>
                                    <input type="text" class="form-control" placeholder="부서" id="deptName" disabled>
                                </div>
                            </div>
                        </div>
            
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label>휴대전화</label>
                                    <input type="text" class="form-control" placeholder="휴대전화" id="mobile" disabled>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label>이메일</label>
                                    <input type="text" class="form-control" placeholder="이메일" id="email" disabled>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label>생년월일</label>
                                    <input type="text" class="form-control" placeholder="생년월일" id="birthdayDate" disabled>
                                </div>
                            </div>
                        </div>
            
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label>우편번호</label>
                                    <input type="text" class="form-control" placeholder="우편번호" id="zipCode" disabled>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label>주소</label>
                                    <input type="text" class="form-control" placeholder="주소" id="address" disabled>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label>상세주소</label>
                                    <input type="text" class="form-control" placeholder="상세주소" id="detailAddress" disabled>
                                </div>
                            </div>
                        </div>
            
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label>직급</label>
                                    <input type="text" class="form-control" placeholder="직급" id="positionName" disabled>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="../../layout/footer.jsp"/>
<script>
window.addEventListener('DOMContentLoaded', function(){
    bIsOrganiChart = true;
});

// 페이지 새로고침 함수 정의
function refreshPage() {
  location.reload();
}

function getEmpDetail(empCode) {
    $.ajax({
        type: 'GET',
        url: fnGetContextPath() + '/admin/detailAjax.do',
        data: 'empCode=' + empCode,
        contentType: "application/json; charset=utf-8;",
        dataType: 'json',
        success: (resData) => {
            console.log(resData);   
            var profileFileName = resData.emp.profileFileName;
            if (profileFileName) {
                $('#profileImage').attr('src', fnGetContextPath() + profileFileName);
            } else {
                $('#profileImage').attr('src', fnGetContextPath() + '/resources/img/default_thumbnail.png');
            }
            $('#empName').val(resData.emp.empName);
            $('#empCode').val(resData.emp.empCode);
            $('#deptName').val(resData.emp.dept.deptName);
            $('#mobile').val(resData.emp.mobile);
            $('#birthdayDate').val(resData.emp.birthdayDate);
            $('#zipCode').val(resData.emp.zipCode);
            $('#address').val(resData.emp.address);
            $('#detailAddress').val(resData.emp.detailAddress);
            $('#positionName').val(resData.emp.position.positionName);
            $('#email').val(resData.emp.email);
        }
    });
}
</script>