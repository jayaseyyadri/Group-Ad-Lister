<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <jsp:include page="../partials/head.jsp">
        <jsp:param name="title" value="Register For Our Site!" />
    </jsp:include>
    <style>
        <%@include file="/resources/css/footer.css"%>
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/partials/navbar.jsp">
    <jsp:param name="linkV" value="/login"/>
    <jsp:param name="linkVisitor" value="Login"/>
</jsp:include>
    <div class="container" style="margin-top: 15px">
        <h1>Please fill in your information.</h1>
        <form action="/register" method="post">
            <div class="form-group">
                <label for="username">Username</label>
                <input id="username" name="username" class="form-control" type="text">
                <c:if test="${sessionScope.currentUserExists}">
                    <small class="errorMessage"> * Username Already Exists, Please Try Again</small>
                </c:if>
                <c:if test="${sessionScope.missingUsername}">
                    <small class="errorMessage"> * Username Can not be blank, Please Try Again</small>
                </c:if>
            </div>
            <div class="form-group">
                <label for="email">Email</label>
                <input id="email" name="email" class="form-control" type="email">
                <c:if test="${sessionScope.missingEmail}">
                    <small class="errorMessage"> * Email Can not be blank, Please Try Again</small>
                </c:if>
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input id="password" name="password" class="form-control" type="password">
                <c:if test="${sessionScope.poorQualityPassword}">
                    <small class="errorMessage"> * Password must be between 8-20 characters and Include a number, capital letter, and special character</small>
                </c:if>
            </div>
            <div class="form-group">
                <label for="confirm_password">Confirm Password</label>
                <input id="confirm_password" name="confirm_password" class="form-control" type="password">
                <c:if test="${sessionScope.passwordsDoNotMatch}">
                    <small class="errorMessage"> * Passwords Do Not Match</small>
                </c:if>
            </div>
            <input type="submit" class="btn btn-danger btn-block">
        </form>
    </div>

    <div class="footer"></div>
<script>
<%@include file="/resources/js/styling.js"%>
</script>
<jsp:include page="../partials/bootstrap.jsp"/>
</body>
</html>
