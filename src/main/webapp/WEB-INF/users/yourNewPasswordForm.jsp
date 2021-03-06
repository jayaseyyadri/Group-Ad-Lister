<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <jsp:include page="/WEB-INF/partials/head.jsp">
        <jsp:param name="title" value="Your New Password" />
    </jsp:include>
</head>
<body>

<div class="container" style="margin-top: 15px">
    <form action="/createYourNewPassword" method="post">
            <div class="form-group">
                <label for="newPassword">Enter New Password</label>
                <input id="newPassword" name="newPassword" class="form-control" type="password">
                <c:if test="${sessionScope.newPasswordPoorQuality}">
                    <small class="errorMessage"> * Password must be between 8-20 characters and Include a number, capital letter, and special character</small>
                </c:if>
            </div>
            <div class="form-group">
                <label for="confirmNewPassword">Confirm Password</label>
                <input id="confirmNewPassword" name="confirmNewPassword" class="form-control" type="password">
                <c:if test="${sessionScope.newPasswordDoesNotMatch}">
                    <small class="errorMessage"> * Passwords Do Not Match</small>
                </c:if>
            </div>
<input type="submit" class="btn btn-danger btn-block">
</form>
</div>

</body>
</html>
