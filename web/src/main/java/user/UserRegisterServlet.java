package user;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/UserRegisterServlet")
public class UserRegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String userID = request.getParameter("userID");
		String userPW = request.getParameter("userPW");
		String userPWC = request.getParameter("userPWC");
		String userName = request.getParameter("userName");
		String userBirthYear = request.getParameter("userBirthYear");
		String userBirthMonth = request.getParameter("userBirthMonth");
		String userBirthDate = request.getParameter("userBirthDate");
		String userEmail = request.getParameter("userEmail");
		String userGender = request.getParameter("userGender");
		String userProfile = request.getParameter("userProfile");
		if(userID == null || userID.equals("") || userPW == null || userPW.equals("") || 
				userPWC == null || userPWC.equals("") || userName == null || userName.equals("") || 
				userBirthYear == null || userBirthYear.equals("") || userBirthMonth == null || userBirthMonth.equals("") || userBirthDate == null || userBirthDate.equals("") ||
				userEmail == null || userEmail.equals("") || userGender == null || userGender.equals("")) {
			request.getSession().setAttribute("messageType", "오류메시지");
			request.getSession().setAttribute("messageContent", "모든 내용을 입력하세요.");
			response.sendRedirect("join.jsp");
			return;
		}
		if(!userPW.equals(userPWC)) {
			request.getSession().setAttribute("messageType", "오류메시지");
			request.getSession().setAttribute("messageContent", "비밀번호가 서로 다릅니다.");
			response.sendRedirect("join.jsp");
			return;
		}
		int result = new UserDAO().register(userID, userPW, userName, userBirthYear, userBirthMonth, userBirthDate, userEmail, userGender, "");
		if(result == 1) {
			request.getSession().setAttribute("userID", userID);
			request.getSession().setAttribute("messageType", "성공메시지");
			request.getSession().setAttribute("messageContent", "회원가입에 성공했습니다.");
			response.sendRedirect("index.jsp");
			return;
		} else {
			request.getSession().setAttribute("messageType", "오류메시지");
			request.getSession().setAttribute("messageContent", "이미 존재하는 회원입니다.");
			response.sendRedirect("join.jsp");
			return;
		}
	}
}
