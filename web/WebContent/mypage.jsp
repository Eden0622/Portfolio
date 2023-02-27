<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.URLDecoder" %>
<%@ page import="user.UserDTO" %>
<%@ page import="user.UserDAO" %>
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
		UserDTO user = new UserDAO().getUser(userID);
		String userProfile = new UserDAO().getProfile(userID);
	%>
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Clean Blog - Start Bootstrap Theme</title>
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <!-- Font Awesome icons (free version)-->
        <script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
        <!-- jQuery-->
        <script src="https://code.jquery.com/jquery-3.6.1.js"></script>
        <!-- Google fonts-->
        <link href="https://fonts.googleapis.com/css?family=Lora:400,700,400italic,700italic" rel="stylesheet" type="text/css" />
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800" rel="stylesheet" type="text/css" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/styles.css" rel="stylesheet" />
        <link href="css/custom.css" rel="stylesheet" />
        <script type="text/javascript">
			function passwordCheckFunction(){
				var userPW = $('#userPW').val();
				var userPWC = $('#userPWC').val();
				if(userPW != userPWC) {
					$('#passwordCheckMessage').html('비밀번호가 서로 일치하지 않습니다.');
				} else {
					$('#passwordCheckMessage').html('');
				}
			}
			
			<%-- function addImg() {
				$('#imgProfile').append(
						'<div class="media" style="border:3px solid red;">' +
						'<img class="media-object img-circle" style="width: 30px; height: 30px;" src="<%= userProfile %>" alt="">' +
						'</div>'
				);
			} --%>
		</script>
    </head>
    <body>
        <!-- Navigation-->
        <nav class="navbar navbar-expand-lg navbar-light" id="mainNav">
            <div class="container px-4 px-lg-5">
                <a class="navbar-brand" href="index.jsp">Start Bootstrap</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
                    Menu
                    <i class="fas fa-bars"></i>
                </button>
                <div class="collapse navbar-collapse" id="navbarResponsive">
                    <ul class="navbar-nav ms-auto py-4 py-lg-0">
                        <li class="nav-item"><a class="nav-link px-lg-3 py-3 py-lg-4" href="index.jsp">Home</a></li>
                        <li class="nav-item"><a class="nav-link px-lg-3 py-3 py-lg-4" href="board.jsp">Board</a></li>
                        <li class="nav-item"><a class="nav-link px-lg-3 py-3 py-lg-4" href="logoutAction.jsp">Logout</a></li>
                        <li class="nav-item"><a class="nav-link px-lg-3 py-3 py-lg-4" href="mypage.jsp">My Page</a></li>
                    </ul>
                </div>
            </div>
        </nav>
        <!-- Page Header-->
        <header class="masthead" style="background-image: url('images/post-bg.jpg')">
            <div class="container position-relative px-4 px-lg-5">
                <div class="row gx-4 gx-lg-5 justify-content-center">
                    <div class="col-md-10 col-lg-8 col-xl-7">
                        <div class="post-heading">
                            <h1>Man must explore, and this is exploration at its greatest</h1>
                            <h2 class="subheading">Problems look mighty small from 150 miles up</h2>
                            <span class="meta">
                                Posted by
                                <a href="#!">Start Bootstrap</a>
                                on August 24, 2022
                            </span>
                        </div>
                    </div>
                </div>
            </div>
        </header>
        <!-- Post Content-->
        <article class="mb-4">
            <div class="container px-4 px-lg-5">
                <div class="row gx-4 gx-lg-5 justify-content-center">
                    <div class="col-md-10 col-lg-8 col-xl-7">
                             <form method="post" action="./userUpdate" id="updateForm" class="mypage-form" enctype="multipart/form-data">
                                <div class="form-floating mypage-update">
                                	<h5><%= user.getUserID() %></h5>
                                    <label for="userID">ID</label>
                                </div>
                                <div class="form-floating mypage-update">
                                	<h5><%= user.getUserPW() %></h5>
                                    <input class="form-control" onkeyup="passwordCheckFunction();" id="userPW" name="userPW" type="password" maxlength="20" placeholder="Enter your password..." data-sb-validations="required" />
                                    <label for="userPW">Password</label>
                                    <div class="invalid-feedback" data-sb-feedback="password:required">A password is required.</div>
                                </div>
                                <div class="form-floating mypage-update">
                                    <input class="form-control" onkeyup="passwordCheckFunction();" id="userPWC" name="userPWC" type="password" maxlength="20" placeholder="Enter your password confirm..." data-sb-validations="required" />
                                    <label for="userPWC">Password Confirm</label>
                                    <div class="invalid-feedback" data-sb-feedback="password:required">A password is required.</div>
                                </div>
                                <div class="form-floating mypage-update">
                                	<h5><%= user.getUserName() %></h5>
                                    <input class="form-control" id="userName" name="userName" type="text" maxlength="20" placeholder="Enter your name..." data-sb-validations="required" />
                                    <label for="userName">Name</label>
                                    <div class="invalid-feedback" data-sb-feedback="userName:required">A name is required.</div>
                                </div>
                                <div class="form-floating mypage-update birthday">
                                	<label class="form">생년월일</label>
                                	<p><%= user.getUserBirthYear() + ". " + user.getUserBirthMonth() + ". " + user.getUserBirthDate() %></p>
                                	<br>
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
                                </div>
                                <div class="form-floating mypage-update">
                                	<h5><%= user.getUserEmail() %></h5>
                                    <input class="form-control" id="userEmail" name="userEmail" type="email" placeholder="Enter your email..." data-sb-validations="required,email" />
                                    <label for="userEmail">Email address</label>
                                </div>
								<div class="form-floating mypage-update gender">
                                	<label for="gender" class="form-label">gender</label>
                                    <div class="form-control form-check gender-item">
                                        <input type="radio" class="form-check-input" id="gender" name="userGender" autocomplete="off" value="F" <% if(user.getUserGender().equals("F")) out.print("checked"); %>/>
                                        <label for="gender" class="form-check-label">Female</label>
                                    </div>
                                    <div class="form-control form-check gender-item">
                                        <input type="radio" class="form-check-input" id="gender" name="userGender" autocomplete="off" value="M" <% if(user.getUserGender().equals("M")) out.print("checked"); %>/>
                                        <label for="gender" class="form-check-label">Male</label>
                                    </div>
                                </div>
                                <div class="form-floating mypage-update mypage-img">
                                  <label for="profile">images</label>
                                  <img class="media-object img-circle" src="<%= userProfile %>" alt="">
                                  <input type="file" name="userProfile" class="file">
                                  <div class="input-group profile-input">
                              		<span><i class="glyphicon glyphicon-picture"></i></span>
                                    <input type="text" class="form-control" disabled placeholder="이미지를 업로드하세요.">
                                    <span>
                                    	<button class="browse btn" type="button"><i class="fa-solid fa-magnifying-glass"></i></button>
                                    </span>
                                  </div>
                               	</div>
                                <br />
                                <!-- Submit Button-->
                                <!-- <button class="btn btn-primary text-uppsercase" id="submitButton" type="submit">Edit</button> -->
                                <input class="btn btn-primary text-uppsercase" type="submit" value="Edit">
                                <h5 style="color: red;" id="passwordCheckMessage"></h5>
                            </form>
                    </div>
                </div>
            </div>
        </article>
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
        <!--  JS-->
        <script type="text/javascript">
			$(document).on("click", ".browse", function(){
				var file = $(this).parent().parent().parent().find('.file');
				file.trigger('click');
			});
			$(document).on('change', 'file', function(){
				$(this).parent().find('.form-control').val($(this).val().replace(/C:\\fakepath\\/i, ''));
			});
        </script>
    </body>
</html>