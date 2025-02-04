<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<c:set var="dt" value="<%=System.currentTimeMillis()%>"/>

<!doctype html>
<html lang="en">
<head>
	<meta charset="utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

	<title>GDJ77 #3 CollabWave</title>

	<meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport' />
    <meta name="viewport" content="width=device-width" />


    <!-- Bootstrap core CSS     -->
    <link href="${contextPath}/resources/css/bootstrap.min.css" rel="stylesheet" />

    <!--  Light Bootstrap Dashboard core CSS    -->
    <link href="${contextPath}/resources/css/light-bootstrap-dashboard.css?v=1.4.1" rel="stylesheet"/>

    <!--  CSS for Demo Purpose, don't include it in your project     -->
    <link href="${contextPath}/resources/css/demo.css" rel="stylesheet" />


    <!--     Fonts and icons     -->
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" rel="stylesheet">
    <link href='https://fonts.googleapis.com/css?family=Roboto:400,700,300' rel='stylesheet' type='text/css'>
    <link href="${contextPath}/resources/css/pe-icon-7-stroke.css" rel="stylesheet" />

</head>
<body>

<nav class="navbar navbar-transparent navbar-absolute">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navigation-example-2">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">GDJ77 #3 CollabWave</a>
        </div>
        <div class="collapse navbar-collapse">

            <!--ul class="nav navbar-nav navbar-right">
                <li>
                   <a href="register.html">
                        Register
                    </a>
                </li>
            </ul-->
        </div>
    </div>
</nav>


<div class="wrapper wrapper-full-page">
    <div class="full-page login-page" data-color="blue" data-image="${contextPath}/resources/img/full-screen-image-1.jpg">

    <!--   you can change the color of the filter page using: data-color="blue | azure | green | orange | red | purple" -->
        <div class="content">
            <div class="container">
                <div class="row">
                    <div class="col-md-4 col-sm-6 col-md-offset-4 col-sm-offset-3">
                        <form method="POST" action="/signin.do">

                        <!--   if you want to have the card without animation please remove the ".card-hidden" class   -->
                            <div class="card card-hidden">
                                <div class="header text-center">
                                    ${messageSource.getMessage("login", null, locale)}
                                    <input type="hidden" name="url" value="${url}">
                                </div>
                                <div class="content">
                                    <div class="form-group">
                                        <label>${messageSource.getMessage("empCode", null, locale)}</label>
                                        <c:if test="${cookie.empCode.value != 'undefined_cookie'}">
                                            <input type="text" name="empCode" placeholder='${messageSource.getMessage("empCode", null, locale)}' class="form-control" value="${cookie.empCode.value}">
                                        </c:if>
                                        <c:if test="${cookie.empCode.value == 'undefined_cookie'}">
                                            <input type="text" name="empCode" placeholder='${messageSource.getMessage("empCode", null, locale)}' class="form-control">
                                        </c:if>
                                    </div>
                                    <div class="form-group">
                                        <label>${messageSource.getMessage("password", null, locale)}</label>
                                        <input type="password" name="pw" placeholder="${messageSource.getMessage('password', null, locale)}" class="form-control">
                                    </div>
                                    <div class="form-group">
										<div class="checkbox">
                                            <c:if test="${cookie.empCode.value != 'undefined_cookie'}"><input type="checkbox" id="checkbox" name="rememberId" checked></c:if>
                                            <c:if test="${cookie.empCode.value == 'undefined_cookie'}"><input type="checkbox" id="checkbox" name="rememberId"></c:if>
			  							  	<label for="checkbox">
                                                ${messageSource.getMessage("empCode", null, locale)} ${messageSource.getMessage("save", null, locale)}
			  							  	</label>
			  						  	</div>
                                    </div>
                                </div>
                                <div class="footer text-center">
                                    <button type="submit" class="btn btn-primary btn-fill btn-wd">
                                        ${messageSource.getMessage("login", null, locale)}
                                    </button>
                                </div>
                            </div>

                        </form>

                    </div>
                </div>
            </div>
        </div>

    	<footer class="footer footer-transparent">
            <div class="container">
                <!--nav class="pull-left">
                    <ul>
                        <li>
                            <a href="#">
                                Home
                            </a>
                        </li>
                        <li>
                            <a href="#">
                                Company
                            </a>
                        </li>
                        <li>
                            <a href="#">
                                Portfolio
                            </a>
                        </li>
                        <li>
                            <a href="#">
                               Blog
                            </a>
                        </li>
                    </ul>
                </nav-->
                <p class="copyright pull-right">
                    &copy; <script>document.write(new Date().getFullYear())</script> 
                    <a href="#">GDJ77</a>, made with #3
                </p>
            </div>
        </footer>

    </div>

</div>


</body>

    <!--   Core JS Files  -->
    <script src="${contextPath}/resources/js/jquery.min.js" type="text/javascript"></script>
	<script src="${contextPath}/resources/js/bootstrap.min.js" type="text/javascript"></script>
	<script src="${contextPath}/resources/js/perfect-scrollbar.jquery.min.js" type="text/javascript"></script>


	<!--  Forms Validations Plugin -->
	<script src="${contextPath}/resources/js/jquery.validate.min.js"></script>

	<!--  Plugin for Date Time Picker and Full Calendar Plugin-->
	<script src="${contextPath}/resources/js/moment.min.js"></script>

    <!--  Date Time Picker Plugin is included in this js file -->
    <script src="${contextPath}/resources/js/bootstrap-datetimepicker.min.js"></script>

    <!--  Select Picker Plugin -->
    <script src="${contextPath}/resources/js/bootstrap-selectpicker.js"></script>

	<!--  Checkbox, Radio, Switch and Tags Input Plugins -->
		<script src="${contextPath}/resources/js/bootstrap-switch-tags.min.js"></script>

	<!--  Charts Plugin -->
	<script src="${contextPath}/resources/js/chartist.min.js"></script>

    <!--  Notifications Plugin    -->
    <script src="${contextPath}/resources/js/bootstrap-notify.js"></script>

    <!-- Sweet Alert 2 plugin -->
	<script src="${contextPath}/resources/js/sweetalert2.js"></script>

    <!-- Vector Map plugin -->
	<script src="${contextPath}/resources/js/jquery-jvectormap.js"></script>

    <!--  Google Maps Plugin    -->
    <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=YOUR_KEY_HERE"></script>

	<!-- Wizard Plugin    -->
    <script src="${contextPath}/resources/js/jquery.bootstrap.wizard.min.js"></script>

    <!--  Datatable Plugin    -->
    <script src="${contextPath}/resources/js/bootstrap-table.js"></script>

    <!--  Full Calendar Plugin    --
    <script src="${contextPath}/resources/js/fullcalendar.min.js"></script>

    <!-- Light Bootstrap Dashboard Core javascript and methods -->
	<script src="${contextPath}/resources/js/light-bootstrap-dashboard.js?v=1.4.1"></script>

	<!-- Light Bootstrap Dashboard DEMO methods, don't include it in your project! -->
	<script src="${contextPath}/resources/js/demo.js"></script>

    <script type="text/javascript">
        $().ready(function(){
            lbd.checkFullPageBackgroundImage();

            setTimeout(function(){
                // after 1000 ms we add the class animated to the login/register card
                $('.card').removeClass('card-hidden');
            }, 700)
        });
    </script>

</html>
