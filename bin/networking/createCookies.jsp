<%@ page contentType="text/html;charset=utf-8" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.util.Date" %>

<%
	
    Cookie cookie = new Cookie("name", URLEncoder.encode("jspbook 쿠키 테스트"));
    Cookie cookie2 = new Cookie("date", URLEncoder.encode(new Date().toString()));
    
    response.addCookie(cookie);
    response.addCookie(cookie2);
%>
<html>
<head><title>쿠키생성</title></head>
<body>
쿠키 이름: <%= cookie.getName() %><br/>
쿠키 값: <%= cookie.getValue() %><br/>
<br/>
쿠키 이름: <%= cookie2.getName() %><br/>
쿠키 값: <%= cookie2.getValue() %>
<p><a href="getCookies.jsp">Next Page to view the cookie value</a></p>
</body>
</html>

