<%@ page contentType="text/html;charset=utf-8" %>

<%@ page import="java.sql.*" %>
<%@ page import="test_project.javabean.Member" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.Enumeration" %>
<%
request.setCharacterEncoding("utf-8");
Enumeration enums = request.getParameterNames();
String[] tel = request.getParameterValues("tel");
System.out.println(enums);
%>
<jsp:useBean id="member" class="test_project.javabean.Member" />


<html>
<head><title>로그인 처리</title></head>
<body>
\
</body>
</html>
