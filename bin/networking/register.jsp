<%@ page contentType="text/html;charset=utf-8" %>
<%@ page import="test_project.javabean.ConnectionContext" %>
<%@ page import="java.sql.*" %>
<%@ page import="test_project.javabean.Member" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.Enumeration" %>
<%
request.setCharacterEncoding("utf-8");
Enumeration enums = request.getParameterNames();
String[] tel = request.getParameterValues("tel");

%>
<jsp:useBean id="member" class="test_project.javabean.Member" />
<jsp:setProperty name="member" property="id" param="id" />
<jsp:setProperty name="member" property="name" param="name" />
<jsp:setProperty name="member" property="password" param="password" />
<jsp:setProperty name="member" property="sex" param="sex" />
<jsp:setProperty name="member" property="introduction" param="introduction" />
<%
//Major 구분

while (enums.hasMoreElements()) { 
	   String name = (String)enums.nextElement();
	   String[] value = request.getParameterValues(name);
	   if (name.matches("tel")){
		   String tels="";
		   for(int i =0;i<value.length;i++){
				 tels += value[i];
			   }
			   member.setTel(tels);
	   }
	   
	   if (name.matches("reg")){
		   String regs="";
		   for(int i =0;i<value.length;i++){
				 regs += value[i];
			   }
			   member.setReg(regs);
	   }
	   
	   if (name.matches("job")){
		   String jobs="";
		   for(int i =0;i<value.length;i++){
				 jobs += value[i];
			   }
			   member.setJob(jobs);
	   }
	   
	   if (name.matches("hobby")){
		   String hobbys="";
		   for(int i =0;i<value.length;i++){
			   hobbys += value[i];
			   }
			   member.setHobby(hobbys);
	   }
}


%>
<%
//db동작
   Connection conn = ConnectionContext.getConnection();
	PreparedStatement pstmt0 = conn.prepareStatement("SELECT count(*) AS recordCount FROM register2 WHERE ID=?");  // SELECT   질의를 지닌 PreparedStatement 객체 생성
	pstmt0.setString(1, member.getId());
	ResultSet rs = pstmt0.executeQuery();  // PreparedStatement 객체의 질의 수행 
   while(rs.next()){
      int recordCount = rs.getInt("recordCount");
      if (recordCount != 1) {  // ID가 200910001인 레코드가 존재하지 않으면 true
         PreparedStatement pstmt = conn.prepareStatement("INSERT INTO register2 (ID, Name, Sex, Hobby, Job, Password, Reg, Tel, Introduction) VALUES (?, ?, ?, ?,?,?,?,?,?);");  //  INSERT 질의 지닌 PreparedStatement 객체 생성
         pstmt.setString(1, member.getId());
         pstmt.setString(2, member.getName());
         pstmt.setString(3, member.getSex());
         pstmt.setString(4, member.getHobby());
         pstmt.setString(5, member.getJob());
         pstmt.setString(6, member.getPassword());
         pstmt.setString(7, member.getReg());
         pstmt.setString(8, member.getTel());
         pstmt.setString(9, member.getIntroduction());
         pstmt.executeUpdate();  // PreparedStatement 객체의 질의 수행 
         pstmt.close();
      } else {
    	  PreparedStatement pstmt = conn.prepareStatement("UPDATE register2 SET Name=?, Sex=?, Hobby=?, Job=?, Password=?, Reg=?, Tel=?, Introduction=? WHERE ID=?;");  //  INSERT 질의 지닌 PreparedStatement 객체 생성
    	  pstmt.setString(1, member.getId());
          pstmt.setString(2, member.getName());
          pstmt.setString(3, member.getSex());
          pstmt.setString(4, member.getHobby());
          pstmt.setString(5, member.getJob());
          pstmt.setString(6, member.getPassword());
          pstmt.setString(7, member.getReg());
          pstmt.setString(8, member.getTel());
          pstmt.setString(9, member.getIntroduction());
          pstmt.executeUpdate();  // PreparedStatement 객체의 질의 수행
          pstmt.close();
      }
   }
   rs.close();
   pstmt0.close();
   %>

<html>
<head><title>로그인 처리</title></head>
<body>
당신이 입력한 정보입니다 <br/>
<b>ID:</b> <jsp:getProperty name="member" property="id" /><br/>
<b>Password:</b> <jsp:getProperty name="member" property="password" /><br/>
<b>Name:</b> <jsp:getProperty name="member" property="name" /><br/>
<b>Sex:</b> <jsp:getProperty name="member" property="sex" /><br/>
<b>Job:</b> <jsp:getProperty name="member" property="jobr" /><br/>
<b>Introduction:</b> <jsp:getProperty name="member" property="introduction" /><br/>
<b>Hobby:</b> <jsp:getProperty name="member" property="hobby" /><br/>
<b>Tel:</b> <jsp:getProperty name="member" property="tel" /><br/>
<b>Reg:</b> <jsp:getProperty name="member" property="reg" /><br/>

</body>
</html>
