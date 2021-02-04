<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="/WEB-INF/partials/head.jsp">
        <jsp:param name="title" value="Welcome to my site!" />
    </jsp:include>
</head>
<body>
<jsp:include page="/WEB-INF/partials/navbar.jsp">
    <jsp:param name="link" value="/drinks"/>
    <jsp:param name="linkTitle" value="Drinks"/>
</jsp:include>


    <div class="container">
        <h1>Welcome to the Comrade Snifter!</h1>
    </div>

    <div class="container">
        <jsp:include page="/WEB-INF/partials/top3-drinks.jsp" />
    </div>


    <jsp:include page="WEB-INF/partials/bootstrap.jsp"/>

</body>
</html>
