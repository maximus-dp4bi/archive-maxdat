<%@ include file="/common/taglibs.jsp" %>

<html>
<head>
    <title><fmt:message key="errorPage.title"/></title>
</head>
<body id="error">
    <div class="container">
        <h1><fmt:message key="errorPage.heading"/></h1>
        <%@ include file="/common/messages.jsp" %>

        <p><fmt:message key="errorPage.message"/></p>
		<a href="home" onclick="history.back();return false">&#171; Back</a>
		
		<div style="color:white"><c:out value="${requestScope.exception.message}"/></div>
		
    </div>
</body>
</html>


