<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
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
        <script src="js/bootstrap.js"></script>
        <!-- Google fonts-->
        <link href="https://fonts.googleapis.com/css?family=Lora:400,700,400italic,700italic" rel="stylesheet" type="text/css" />
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800" rel="stylesheet" type="text/css" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/styles.css" rel="stylesheet" />
        <link href="css/custom.css" rel="stylesheet" />
        <script type="text/javascript">
        	function registerCheckFunction(){
        		var userID = $('#userID').val();
        		$.ajax({
	        		type: 'POST',
        			url: './UserRegisterCheckServlet',
        			data: {userID: userID},
        			success: function(result) {
        				if(result == 1) {
        					$('#checkMessage').html('사용할 수 있는 아이디입니다.');
        					$('#checkType').attr('class','modal-content panel-success');
        				} else {
        					$('#checkMessage').html('사용할 수 없는 아이디입니다.');
        					$('#checkType').attr('class','modal-content panel-warning');
        				}
        				$('#checkModal').modal("show");
        			}
        		});
        	}
        	function passwordCheckFunction(){
        		var userPW = $('#userPW').val();
        		var userPWC = $('#userPWC').val();
        		if(userPW != userPWC) {
        			$('#passwordCheckMessage').html('비밀번호가 서로 일치하지 않습니다.');
        		} else {
        			$('#passwordCheckMessage').html('');
        		}
        	}	
       </script>
    </head>
    <body>
    	<%
    		String userID = null;
    		if (session.getAttribute("userID") != null) {
    			userID = (String) session.getAttribute("userID");
    		}
    		if(userID != null) {
				session.setAttribute("messageType", "오류 메시지");
				session.setAttribute("messageContent", "현재 로그인이 되어 있는 상태입니다.");
				response.sendRedirect("index.jsp");
				return;
			}
    	%>
        <!-- Navigation-->
        <nav class="navbar navbar-expand-lg navbar-light" id="mainNav">
            <div class="container px-4 px-lg-5">
                <a class="navbar-brand" href="index.html">Start Bootstrap</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
                    Menu
                    <i class="fas fa-bars"></i>
                </button>
                <div class="collapse navbar-collapse" id="navbarResponsive">
                    <ul class="navbar-nav ms-auto py-4 py-lg-0">
                        <li class="nav-item"><a class="nav-link px-lg-3 py-3 py-lg-4" href="index.jsp">Home</a></li>
                        <li class="nav-item"><a class="nav-link px-lg-3 py-3 py-lg-4" href="board.jsp">Board</a></li>
                        <li class="nav-item"><a class="nav-link px-lg-3 py-3 py-lg-4" href="login.jsp">Login</a></li>
                        <li class="nav-item"><a class="nav-link px-lg-3 py-3 py-lg-4" href="#">Join</a></li>
                    </ul>
                </div>
            </div>
        </nav>
        <!-- Page Header-->
         <header class="masthead" style="background-image: url('images/contact-bg.jpg')">
            <div class="container position-relative px-4 px-lg-5">
                <div class="row gx-4 gx-lg-5 justify-content-center">
                    <div class="col-md-10 col-lg-8 col-xl-7">
                        <div class="page-heading">
                            <h1>Sign Up</h1>
                            <span class="subheading">Sign Up Process</span>
                        </div>
                    </div>
                </div>
            </div>
        </header>
        <!-- Main Content-->
        <main class="mb-4">
            <div class="container px-4 px-lg-5">
                <div class="row gx-4 gx-lg-5 justify-content-center">
                    <div class="col-md-10 col-lg-8 col-xl-7">
                        <p>Want to get in touch? Fill out the form below to send me a message and I will get back to you as soon as possible!</p>
                        <div class="my-5">
                            <form method="post" action="./userRegister" id="joinForm">
                                <div class="form-floating">
                                    <input class="form-control" id="userID" name="userID" type="text" maxlength="20" placeholder="Enter your ID..."/>
                                    <label for="userID">ID</label>
                                    <div class="invalid-feedback">A name is required.</div>
                                    <button class="btn btn-primary" onclick="registerCheckFunction();" type="button">중복체크</button>
                                </div>
                                <div class="form-floating">
                                    <input class="form-control" onkeyup="passwordCheckFunction();" id="userPW" name="userPW" type="password" maxlength="20" placeholder="Enter your password..."/>
                                    <label for="userPW">Password</label>
                                    <div class="invalid-feedback">A password is required.</div>
                                </div>
                                <div class="form-floating">
                                    <input class="form-control" onkeyup="passwordCheckFunction();" id="userPWC" name="userPWC" type="password" maxlength="20" placeholder="Enter your password confirm..."/>
                                    <label for="userPWC">Password Confirm</label>
                                    <div class="invalid-feedback">A password is required.</div>
                                </div>
                                <div class="form-floating">
                                    <input class="form-control" id="userName" name="userName" type="text" maxlength="20" placeholder="Enter your name..."/>
                                    <label for="userName">Name</label>
                                    <div class="invalid-feedback">A name is required.</div>
                                </div>
                                <div class="form-floating birthday">
                                	<label class="form">생년월일</label>
									<select id="birth_yy" name="userBirthYear" class="form-control select">
  										<option value='' selected>--연도--</option>
										<% for(int i=2022; i>=1900;i--){ %>
										<option value="<%= i %>"><%= i %></option>
										<% } %>
									</select>&nbsp;
  									<select id="birth_mm" name="userBirthMonth" class="form-control select">
  										<option value='' selected>--월--</option>
  										<% for(int i=1; i<=12;i++){ %>
										<option value="<%= i %>"><%= i %></option>
										<% } %>
  									</select>&nbsp;
  									<select id="birth_dd" name="userBirthDate" class="form-control select">
  										<option value='' selected>--일--</option>
  										<% for(int i=1; i<=31;i++){ %>
										<option value="<%= i %>"><%= i %></option>
										<% } %>
  									</select>
  									<div class="invalid-feedback">A birthday is required.</div>
                                </div>
                                <div class="form-floating">
                                    <input class="form-control" id="userEmail" name="userEmail" type="email" placeholder="Enter your email..."/>
                                    <label for="userEmail">Email address</label>
                                    <div class="invalid-feedback">An email is required.</div>
                                    <div class="invalid-feedback">Email is not valid.</div>
                                </div>
								<div class="form-floating gender">
                                	<label for="gender" class="form-label">gender</label>
                                    <div class="form-control form-check">
                                        <input class="form-check-input" id="gender" name="userGender" value="F" type="radio" checked/>
                                        <label for="gender" class="form-check-label">Female</label>
                                    </div>
                                    <div class="form-control form-check">
                                        <input class="form-check-input" id="gender" name="userGender" value="M" type="radio"/>
                                        <label for="gender" class="form-check-label">Male</label>
                                    </div>
                                    <div class="invalid-feedback">An email is required.</div>
                                </div>
                                <br />
                                <!-- Submit Button-->
                                <!-- <button class="btn btn-primary text-uppsercase" id="submitButton" type="submit">Join</button> -->
                                <input class="btn btn-primary text-uppsercase" type="submit" value="Join">
                                <h5 style="color: red;" id="passwordCheckMessage"></h5>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </main>
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
        
        <%
			String messageContent = null;
			if(session.getAttribute("messageContent") != null) {
				messageContent = (String) session.getAttribute("messageContent");
				System.out.println(messageContent);
			}
			String messageType = null;
			if(session.getAttribute("messageType") != null) {
				messageType = (String) session.getAttribute("messageType");
				System.out.println(messageType);
			}
			if(messageContent != null) {
        %>
        <div class="modal fade" id="messageModal" tabindex="-1" role="dialog" aria-hidden="ture">
			<div class="vertical-alignment-helper">
				<div class="modal-dialog vertical-align-center">
					<div class="modal-content <% if(messageType.equals("오류 메시지")) out.println("panel-warning"); else out.println("panel-success");%>">
						<div class="modal-header panel-heading">
							<button type="button" class="close" data-dismiss="modal">
								<span aria-hidden="true">&times</span>
								<span class="sr-only">Close</span>
							</button>
							<h4 class="modal-title">
								<%= messageType %>
							</h4>
						</div>
						<div class="modal-body">
							<%= messageContent %>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		<script>
			$('#messageModal').modal("show");
		</script>
		<%
			session.removeAttribute("messageContent");
			session.removeAttribute("messageType");
			}
		%>
		<div class="modal fade" id="checkModal" tabindex="-1" role="dialog" aria-hidden="true">
			<div class="vertical-alignment-helper">
				<div class="modal-dialog vertical-align-center">
					<div id="checkType" class="modal-content panel-info">
						<div class="modal-header panel-heading">
							<button type="button" class="close" data-dismiss="modal">
								<span aria-hidden="true">&times</span>
								<span class="sr-only">Close</span>
							</button>
							<h4 class="modal-title">확인 메시지</h4>
						</div>
						<div id="checkMessage" class="modal-body">
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
						</div>
					</div>
				</div>
			</div>
		</div>
    </body>
</html>