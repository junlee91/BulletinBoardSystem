<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page"></jsp:useBean>
<jsp:setProperty property="userID" name="user"/>
<jsp:setProperty property="userPassword" name="user"/>
<jsp:setProperty property="userName" name="user"/>
<jsp:setProperty property="userGender" name="user"/>
<jsp:setProperty property="userEmail" name="user"/>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP Bulletin Website</title>
</head>
<body>
	<%
		
		String userID = null;
	
		if(session.getAttribute("userID") != null){
			userID = (String)session.getAttribute("userID");
		}
	
		if(userID != null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('Already signed in')");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}	

		if(user.getUserID() == null || user.getUserPassword() == null || user.getUserName() == null ||
			user.getUserGender() == null || user.getUserEmail() == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('All fields have to be filled!')");
			script.println("history.back()");
			script.println("</script>");
		} else {
			
			UserDAO userDAO = new UserDAO();
			int result = userDAO.join(user);
			
			if(result == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('UserID duplication!')");
				script.println("history.back()");
				script.println("</script>");;
			}
			else{
				session.setAttribute("userID", user.getUserID());
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = 'main.jsp'");
				script.println("</script>");
			}
		}
	
	%>
	
</body>
</html>