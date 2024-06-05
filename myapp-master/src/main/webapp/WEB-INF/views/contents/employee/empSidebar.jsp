<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<c:set var="dt" value="<%=System.currentTimeMillis()%>"/>

<style>
.subtab > li {
    padding-top: 10px;
}    
.subtab2 li {
    padding-left: 30px;
}
</style>

<div class="card">
    <div class="header">
        인사 관리 메뉴
    </div>
    <div class="content">
        <ul class="list-unstyled subtab">
            <li><b><a href="/employee/management.page">직원관리</a></b></li>
                <ul class="list-unstyled subtab2">
                    <li><a href="">직원등록</a></li>
                    <li><a href="">직원수정</a></li>
                </ul>
            <li><b><a href="/employee/departManage.page">부서관리</a></b></li>
                <ul class="list-unstyled subtab2">
                    <li><a href="">부서등록</a></li>
                    <li><a href="">부서수정</a></li>
                </ul>
            <li><b>직급관리</b></li>
            <li><b>퇴사자관리</b></li>
        </ul>
    </div>
</div>