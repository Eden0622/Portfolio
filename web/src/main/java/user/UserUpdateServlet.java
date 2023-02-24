package user;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

@WebServlet("/UserUpdateServlet")
public class UserUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		MultipartRequest multi = null;
		int fileMaxSize = 10 * 1024 * 1024;
		String savePath = request.getRealPath("/upload").replaceAll("\\\\", "/");
		try {
			multi = new MultipartRequest(request, savePath, fileMaxSize, "UTF-8", new DefaultFileRenamePolicy());
		} catch (Exception e) {
			request.getSession().setAttribute("messageType", "오류메시지");
			request.getSession().setAttribute("messageContent", "파일 크기는 100MB를 넘을 수 없습니다.");
			response.sendRedirect("mypage.jsp");
			return;
		}
		String userID = multi.getParameter("userID");
		HttpSession session = request.getSession();
		/*
		 * if(!userID.equals((String) session.getAttribute("userID"))) {
		 * session.setAttribute("messageType", "오류 메시지");
		 * session.setAttribute("messageContent", "접근할 수 없습니다.");
		 * response.sendRedirect("index.jsp"); return; }
		 */
		String userPW = multi.getParameter("userPW");
		String userPWC = multi.getParameter("userPWC");
		String userName = multi.getParameter("userName");
		String userBirthYear = multi.getParameter("userBirthYear");
		String userBirthMonth = multi.getParameter("userBirthMonth");
		String userBirthDate = multi.getParameter("userBirthDate");
		String userEmail = multi.getParameter("userEmail");
		String userGender = multi.getParameter("userGender");
		//String userProfile = multi.getParameter("userProfile");
		if(userID == null || userID.equals("") || userPW == null || userPW.equals("") || 
				userPWC == null || userPWC.equals("") || userName == null || userName.equals("") || 
				userBirthYear == null || userBirthYear.equals("") || userBirthMonth == null || userBirthMonth.equals("") || userBirthDate == null || userBirthDate.equals("") ||
				userEmail == null || userEmail.equals("") || userGender == null || userGender.equals("")) {
			request.getSession().setAttribute("messageType", "오류메시지");
			request.getSession().setAttribute("messageContent", "모든 내용을 입력하세요.");
			response.sendRedirect("mypage.jsp");
			return;
		}
		if(!userID.equals((String) session.getAttribute("userID"))) {
			session.setAttribute("messageType", "오류 메시지");
			session.setAttribute("messageContent", "접근할 수 없습니다.");
			response.sendRedirect("index.jsp");
			return;
		}
		if(!userPW.equals(userPWC)) {
			request.getSession().setAttribute("messageType", "오류메시지");
			request.getSession().setAttribute("messageContent", "비밀번호가 서로 다릅니다.");
			response.sendRedirect("mypage.jsp");
			return;
		}
		String fileName = "";
		File file = multi.getFile("userProfile");
		if(file != null) {
			String ext = file.getName().substring(file.getName().lastIndexOf(".") + 1);
			if(ext.equals("jpg") || ext.equals("png") || ext.equals("gif")) {
				String prev = new UserDAO().getUser(userID).getUserProfile();
				File prevFile = new File(savePath + "/" + prev);
				if(prevFile.exists()) {
					prevFile.delete();
				}
				fileName = file.getName();
			} else {
				if(file.exists()) {
					file.delete();
				}
				session.setAttribute("messageType", "오류 메시지");
				session.setAttribute("messageContent", "이미지 파일만 업로드 가능합니다.");
				response.sendRedirect("mypage.jsp");
				return;
			}
		}
		new UserDAO().profile(userID, fileName);
		int result = new UserDAO().update(userID, userPW, userPWC, userName, userBirthYear, userBirthMonth, userBirthDate, userEmail, userGender);
		if(result == 1) {
			request.getSession().setAttribute("userID", userID);
			request.getSession().setAttribute("messageType", "성공메시지");
			request.getSession().setAttribute("messageContent", "회원정보 수정에 성공했습니다.");
			response.sendRedirect("index.jsp");
			return;
		} else {
			request.getSession().setAttribute("messageType", "오류메시지");
			request.getSession().setAttribute("messageContent", "데이터베이스 오류가 발생했습니다.");
			response.sendRedirect("mypage.jsp");
			return;
		}
	}

}
