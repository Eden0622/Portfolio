<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="user.UserDTO" %>
<%@ page import="board.BoardDAO" %>
<%@ page import="board.BoardDTO" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		if(userID == null) {
			session.setAttribute("messageType", "오류 메시지");
			session.setAttribute("messageContent", "현재 로그인이 되어 있지 않습니다.");
			response.sendRedirect("index.jsp");
			return;
		}
		String pageNumber = "1";
		if(request.getParameter("pageNumber") != null) {
			pageNumber = request.getParameter("pageNumber");
		}
		try {
			Integer.parseInt(pageNumber);
		} catch (Exception e) {
			session.setAttribute("messageType", "오류 메시지");
			session.setAttribute("messageContent", "페이지 번호가 잘못되었습니다.");
			response.sendRedirect("boardView.jsp");
			return;
		}
		ArrayList<BoardDTO> boardList = new BoardDAO().getList(pageNumber);
	%>
<head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Clean Blog - Start Bootstrap Theme</title>
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <!-- Font Awesome icons (free version)-->
        <script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js"></script>
        <!-- jQuery-->
        <script src="https://code.jquery.com/jquery-3.6.1.js"></script>
        <!-- Google fonts-->
        <link href="https://fonts.googleapis.com/css?family=Lora:400,700,400italic,700italic" rel="stylesheet" type="text/css" />
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800" rel="stylesheet" type="text/css" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/styles.css" rel="stylesheet" />
        <link href="css/custom.css" rel="stylesheet" />
		<!-- Bootdey theme CSS -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/boxicons/2.1.0/css/boxicons.min.css" integrity="sha512-pVCM5+SN2+qwj36KonHToF2p1oIvoU3bsqxphdOIWMYmgr4ZqD3t5DjKvvetKhXGc/ZG5REYTT6ltKfExEei/Q==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/MaterialDesign-Webfont/5.3.45/css/materialdesignicons.css" integrity="sha256-NAxhqDvtY0l4xn+YVa6WjAcmd94NNfttjNsDmNatFVc=" crossorigin="anonymous" />
</head>
<body class="board-body">
        <!-- Navigation-->
        <nav class="navbar navbar-expand-lg navbar-light" id="mainNav">
            <div class="container px-4 px-lg-5">
                <a class="navbar-brand" href="index.jsp">Start Bootstrap</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
                    Menu
                    <i class="fas fa-bars"></i>
                </button>
                <%
                	if (userID == null) {
                %>
                <div class="collapse navbar-collapse" id="navbarResponsive">
                    <ul class="navbar-nav ms-auto py-4 py-lg-0">
                        <li class="nav-item"><a class="nav-link px-lg-3 py-3 py-lg-4" href="index.jsp">Home</a></li>
                        <li class="nav-item"><a class="nav-link px-lg-3 py-3 py-lg-4" href="board.jsp">Board</a></li>
                        <li class="nav-item"><a class="nav-link px-lg-3 py-3 py-lg-4" href="login.jsp">Login</a></li>
                        <li class="nav-item"><a class="nav-link px-lg-3 py-3 py-lg-4" href="join.jsp">Join</a></li>
                    </ul>
                </div>
                <%
                	} else {
                %>
                <div class="collapse navbar-collapse" id="navbarResponsive">
                    <ul class="navbar-nav ms-auto py-4 py-lg-0">
                        <li class="nav-item"><a class="nav-link px-lg-3 py-3 py-lg-4" href="index.jsp">Home</a></li>
                        <li class="nav-item"><a class="nav-link px-lg-3 py-3 py-lg-4" href="board.jsp">Board</a></li>
                        <li class="nav-item"><a class="nav-link px-lg-3 py-3 py-lg-4" href="logoutAction.jsp">Logout</a></li>
                        <li class="nav-item"><a class="nav-link px-lg-3 py-3 py-lg-4" href="mypage.jsp">My Page</a></li>
                    </ul>
                </div>
                <%
                	}
                %>
            </div>
        </nav>
        <!-- Page Header-->
        <header class="masthead" style="background-image: url('images/about-bg.jpg')">
            <div class="container position-relative px-4 px-lg-5">
                <div class="row gx-4 gx-lg-5 justify-content-center">
                    <div class="col-md-10 col-lg-8 col-xl-7">
                        <div class="page-heading">
                            <h1>Community</h1>
                            <span class="subheading">This is what I do.</span>
                        </div>
                    </div>
                </div>
            </div>
        </header>
        <!-- Main Content-->
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-6">
                    <div class="mb-3">
                        <h5 class="card-title">Board List <span class="text-muted fw-normal ms-2">(<%= boardList.size() %>)</span></h5>
                    </div>
                </div>
                <a href="boardWrite.jsp" class="router-link-active router-link-exact-active nav-link">
                	<i class="fa-solid fa-pen-to-square"></i>
            	</a>
            </div>
            <div class="row">
                <div class="col-lg-12">
                    <div>
                        <div class="table-responsive">
                            <table class="table project-list-table table-nowrap align-middle table-borderless">
                                <thead>
                                    <tr>
                                        <th scope="col" class="ps-4" style="width: 50px;">
                                            <div class="form-check font-size-16"><input type="checkbox" class="form-check-input" id="contacusercheck" /><label class="form-check-label" for="contacusercheck"></label></div>
                                        </th>
                                        <th scope="col">No.</th>
                                        <th scope="col">Name</th>
                                        <th scope="col">Title</th>
                                        <th scope="col">Date</th>
                                        <th scope="col">Views</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <%
									for(int i=0; i<boardList.size(); i++) {
										BoardDTO board = boardList.get(i);
								%>
                                    <tr>
                                        <th scope="row" class="ps-4">
                                            <div class="form-check font-size-16"><input type="checkbox" class="form-check-input" id="contacusercheck1" /><label class="form-check-label" for="contacusercheck1"></label></div>
                                        </th>
                                        <td><%= board.getBoardID()%></td>
                                        <td><img src="" alt="" class="avatar-sm rounded-circle me-2" /><%= board.getUserID() %></td>
                                        <td><a href="boardShow.jsp?boardID=<%= board.getBoardID() %>"><%= board.getBoardTitle() %></a></td>
                                        <td><%= board.getBoardDate() %></td>
                                        <td><%= board.getBoardHit() %></td>
                                    </tr>
                                    <%
										}
                                    %>
                                    <tr>
                                        <th scope="row" class="ps-4">
                                            <div class="form-check font-size-16"><input type="checkbox" class="form-check-input" id="contacusercheck1" /><label class="form-check-label" for="contacusercheck1"></label></div>
                                        </th>
                                        <td>0</td>
                                        <td><img src="https://bootdey.com/img/Content/avatar/avatar1.png" alt="" class="avatar-sm rounded-circle me-2" /><a href="boardShow.jsp" class="text-body">Simon Ryles</a></td>
                                        <td><span class="badge badge-soft-success mb-0">Full Stack Developer</span></td>
                                        <td>2023-02-21</td>
                                        <td>125</td>
                                    </tr>
                                    <tr>
                                        <th scope="row" class="ps-4">
                                            <div class="form-check font-size-16"><input type="checkbox" class="form-check-input" id="contacusercheck2" /><label class="form-check-label" for="contacusercheck2"></label></div>
                                        </th>
                                        <td>1</td>
                                        <td><img src="https://bootdey.com/img/Content/avatar/avatar1.png" alt="" class="avatar-sm rounded-circle me-2" /><a href="#" class="text-body">Marion Walker</a></td>
                                        <td><span class="badge badge-soft-info mb-0">Frontend Developer</span></td>
                                        <td>2023-02-21</td>
                                        <td>132</td>
                                    </tr>
                                    <tr>
                                        <th scope="row" class="ps-4">
                                            <div class="form-check font-size-16"><input type="checkbox" class="form-check-input" id="contacusercheck3" /><label class="form-check-label" for="contacusercheck3"></label></div>
                                        </th>
                                        <td>2</td>
                                        <td>
                                            <div class="avatar-sm d-inline-block me-2">
                                                <div class="avatar-title bg-soft-primary rounded-circle text-primary"><i class="mdi mdi-account-circle m-0"></i></div>
                                            </div>
                                            <a href="#" class="text-body">Frederick White</a>
                                        </td>
                                        <td><span class="badge badge-soft-danger mb-0">UI/UX Designer</span></td>
                                        <td>2023-02-21</td>
                                        <td>112</td>
                                    </tr>
                                    <tr>
                                        <th scope="row" class="ps-4">
                                            <div class="form-check font-size-16"><input type="checkbox" class="form-check-input" id="contacusercheck4" /><label class="form-check-label" for="contacusercheck4"></label></div>
                                        </th>
                                        <td>3</td>
                                        <td><img src="https://bootdey.com/img/Content/avatar/avatar1.png" alt="" class="avatar-sm rounded-circle me-2" /><a href="#" class="text-body">Shanon Marvin</a></td>
                                        <td><span class="badge badge-soft-primary mb-0">Backend Developer</span></td>
                                        <td>2023-02-21</td>
                                        <td>121</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row g-0 align-items-center pb-4">
                <div class="col-sm-6">
                    <div><p class="mb-sm-0">Showing 1 to 10 of <%= boardList.size() %> entries</p></div>
                </div>
                <div class="col-sm-6">
                    <div class="float-sm-end">
                        <ul class="pagination mb-sm-0">
                        	<%
								int startPage = (Integer.parseInt(pageNumber) / 10) * 10 + 1;
								if(Integer.parseInt(pageNumber) % 10 == 0) startPage -= 10;
								int targetPage = new BoardDAO().targetPage(pageNumber);
								if(startPage != 1) {
							%>
                            <li class="page-item">
                                <a href="board.jsp?pageNumber=<%= startPage - 1%>" class="page-link"><i class="mdi mdi-chevron-left"></i></a>
                            </li>
                            <%
                            	} else {
                            %>
                            <li class="page-item"><a href="#" class="page-link"><i class="mdi mdi-chevron-left"></i></a></li>
                            <%
                            	}
								for(int i = startPage; i < Integer.parseInt(pageNumber); i++) {
                            %>
                            <li class="page-item"><a href="board.jsp?pageNumber=<%= i %>" class="page-link"><%= i %></a></li>
                            <%
								}
                            %>
                            <li class="page-item"><a href="board.jsp?pageNumber=<%= pageNumber %>" class="page-link"><%= pageNumber %></a></li>
                            <%
        						for(int i = Integer.parseInt(pageNumber) + 1; i <= targetPage + Integer.parseInt(pageNumber); i++) {
    							if(i< startPage + 10) {
                            %>
                            <li class="page-item"><a href="board.jsp?pageNumber=<%= i %>" class="page-link"><%= i %></a></li>
                            <%
    								}
        						}
                            	if(targetPage + Integer.parseInt(pageNumber) > startPage + 9) {
                            %>
                            <li class="page-item"><a href="board.jsp?pageNumber=<%= startPage + 10 %>" class="page-link"><i class="mdi mdi-chevron-right"></a></li>
                            <%
                            	} else {
                            %>
                            <li class="page-item"><a href="#" class="page-link"><i class="mdi mdi-chevron-right"></i></a></li>
							<%
                            	}
							%>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <!-- Footer-->
        <footer class="border-top">
            <div class="container px-4 px-lg-5">
                <div class="row gx-4 gx-lg-5 justify-content-center">
                    <div class="col-md-10 col-lg-8 col-xl-7">
                        <ul class="list-inline text-center">
                            <li class="list-inline-item">
                                <a href="#!">
                                    <span class="fa-stack fa-lg">
                                        <i class="fas fa-circle fa-stack-2x"></i>
                                        <i class="fab fa-twitter fa-stack-1x fa-inverse"></i>
                                    </span>
                                </a>
                            </li>
                            <li class="list-inline-item">
                                <a href="#!">
                                    <span class="fa-stack fa-lg">
                                        <i class="fas fa-circle fa-stack-2x"></i>
                                        <i class="fab fa-facebook-f fa-stack-1x fa-inverse"></i>
                                    </span>
                                </a>
                            </li>
                            <li class="list-inline-item">
                                <a href="#!">
                                    <span class="fa-stack fa-lg">
                                        <i class="fas fa-circle fa-stack-2x"></i>
                                        <i class="fab fa-github fa-stack-1x fa-inverse"></i>
                                    </span>
                                </a>
                            </li>
                        </ul>
                        <div class="small text-center text-muted fst-italic">Copyright &copy; Your Website 2022</div>
                    </div>
                </div>
            </div>
        </footer>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>
</body>
</html>