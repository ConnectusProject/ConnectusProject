<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>커뮤니티</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet"
		integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT" crossorigin="anonymous">
	<link rel="stylesheet" href="${path}/css/header.css">
	<link rel="stylesheet" href="${path}/css/list.css">
	<link rel="stylesheet" href="${path}/css/comment.css">
	<script src="${path}/js/jquery-3.6.0.min.js"></script>
	<script>

	$(function () {
        let sessionId = '<%=session.getAttribute("sessionid")%>';
        let list = [];

        $.ajax({
           url: "boarddetail/" + ${ param.seq } + "/getAllComment",
           data: { seq: ${ param.seq }},
        type: 'post',
        dataType: 'json',
        success: function (res) {
           list = res;

           $.each(list, function (i, item) {
              $("#comment").append("<li></li>");
              $("#commentNum").html("댓글 " + (i + 1));

              $("#comment li:last-child").addClass("commentListAll");
              $("#comment li:last-child").addClass("commentList" + i);
              $(".commentList" + i).append(
                 "<span class='writer'>" + item.writer + "</span>"
                 + "<span class='date'>" + item.writingtime + "</span>"
                 + "<span class='isSecret'>" + (item.secret == 1 ? "비밀글입니다" : "") + "</span>"

                 + (item.secret == 1 && sessionId == item.writer ? "<p class='contents'>" + item.contents + "</p>"
                    : (item.secret != 1 ? "<p class='contents'>" + item.contents + "</p>" : ""))

                 + "<input class='commentSeq' type='hidden' name='commentSeq' value=" + item.comment_seq + ">"

                 /* + "<input class='updateContents type='hidden' name='updateContents' value=" + item.updateContents +">" */
                 + (sessionId == item.writer ? "<input class='updateBtn' type='button' value='수정'><input class='deleteBtn' type='button' value='삭제'><input type=hidden id=comment_seq value=" + item.comment_seq + ">" : "")


                 //ajax비동기 부분 추가 새로고침 건너고







              );
           });
        },
        error: function (request, status, error) {
           /*    alert(${param.seq});
               alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);*/
        }
  })
})


		$(document).ready(function () {

			$("#submitBtn").on("click", function () {
				let secret;
				let sessionId = '<%=session.getAttribute("sessionid")%>';
				let seq = '<%=request.getParameter("seq")%>';
				if ($("#contents").val() != '') {
					if ($("#secretCheckBtn").is(":checked") == true) { secret = 1 } else { secret = 0 };


					$.ajax({
						url: "boarddetail/" + ${ param.seq } + "/insertComment",
						data: { writer: sessionId, contents: $("#contents").val(), secret: secret, seq: seq },
						type: 'post',
						dataType: 'json',
						success: function (res) {
							$("#comment").append("<li></li>");
							let listNum = document.querySelectorAll("#comment li").length;

							$("#comment li:last-child").addClass("commentList" + listNum);
							$(".commentList" + listNum).append(
								"<span class='writer'>" + res.writer + "</span>"
								+ "<span class='date'>" + res.writingtime + "</span>"
								+ "<span class='isSecret'>" + (res.secret == 1 ? "비밀글입니다" : "") + "</span>"

								+ (res.secret == 1 && sessionId == res.writer ? "<p class='contents'>" + res.contents + "</p>"
									: (res.secret != 1 ? "<p class='contents'>" + res.contents + "</p>" : ""))

								+ "<input class='commentSeq' type='hidden' name='commentSeq' value=" + res.commentSeq + ">"
// === 여기 수정삭제 버튼 입니다 ===
								+ (sessionId == res.writer ? "<input class='updateBtn' type='button' value='수정'><input class='deleteBtn' type='button' value='삭제'>" : "")
							);
							$("#commentNum").html("댓글 " + listNum);
							$("#contents").val('');
							setTimeout(()=>{location.reload()}, 5)
						}
			})
		} else {
			alert("내용을 입력해 주세요.");
		}
	})

		$("#comment").on("click", "input", function (e) {
			if ($(e.target).hasClass("updateBtn")) {						// 수정
				let contents = $(e.target).prevAll(".contents").text();
				let secret = $(e.target).prevAll(".isSecret").text();

				let isSecret;
				if (secret == "비밀글입니다") { isSecret = "checked" } else { isSecret = '' };

				if ($(e.target).next().next().attr("id") == "#updateform") {
					return false;
				}

				$(e.target).parents("li").append(
					"<form id='#updateform'><textarea width='300px' id='updateContents' name='updateContents'>" + contents + "</textarea>"
					+ "<div class='commentBtn'><input class='completeBtn' type='button' value='완료'>"
					+ "<div class='secret'><span>비밀글 </span><input id='secretUpdateBtn' type='checkbox' name='updateSecret' " + isSecret + "></div></div></form>");


			} else if ($(e.target).hasClass("completeBtn")) {		// 수정완료
				alert($("#updateContents").val());
				let updateSecret;
				if ($("#secretUpdateBtn").is(":checked") == true) { updateSecret = 1 } else { updateSecret = 0 };

				$.ajax({
					url: "boarddetail/" + ${ param.seq } + "/updateComment",
					data: { updateContents: $("#updateContents").val(), updateSecret: updateSecret, commentSeq: $(".commentSeq").val() },
					type: 'post',
					dataType: 'json',
					success: function (res) {
						$(e.target).parents("li").html(
							"<span class='writer'>" + res.writer + "</span>"
							+ "<span class='date'>" + res.writingtime + "</span>"
							+ "<span class='isSecret'>" + (res.secret == 1 ? "비밀글입니다" : "") + "</span>"
							+ "<p class='contents'>" + res.contents + "</p>"
							+ "<input class='commentSeq' type='hidden' name='commentSeq' value=" + res.commentSeq + ">"
							+ "<input class='updateBtn' type='button' value='수정'>"
							+ "<input class='deleteBtn' type='button' value='삭제'>");

					}
			}) 
			
			
		} else if ($(e.target).hasClass("deleteBtn")) {		// 삭제
			//let commentSeq = $(e.target).prevAll(".commentSeq").val();
			alert($("#comment_seq").val());
			$.ajax({
				url: "boarddetail/" + ${ param.seq } + "/deleteComment",
				data: {commentSeq: $("#comment_seq").val()},
				type: 'post',
				success: function (res) {
					$(e.target).parents("li").remove();

					let listNum = document.querySelectorAll("#comment li").length;
					$("#commentNum").html("댓글 " + listNum);
				}
			}) 
		} 
	})
});


	</script>
</head>

<body>

	<div class="main-container">
		<!-- header-section -->
		<jsp:include page="/WEB-INF/views/header.jsp">
			<jsp:param value="false" name="mypage" />
		</jsp:include>
		<!-- content-section -->
		<div class="content-container">
			<div class="list-container">


				<div class="detail-box">
					<div class="detail-delete-box">
					<form action="boardupdate/${seqList.seq}">
						<input type="submit" value="수정" id="updatebtn">
					</form>
					<form action="boarddelete">
						<input type="hidden" name="seq" value="${seqList.seq}">
						<input type="submit" value="삭제" id="deletebtn" >
					</form>
					</div>
					<div class="detail-title-box">
						<div class="detail-title mt-1">
							${seqList.title}
						</div>
						<div>
							<span>${seqList.writer} </span>|
							<span>조회수 ${seqList.viewcount } </span>|
							<span>${seqList.writingtime }</span>
							<span id="commentNum">댓글 0</span>
						</div>
					</div>
					<div class="detail-content-box">
						<div>
							<img alt="사진이 없어요" width=200 height=200 src="/upload/${seqList.img }">
						</div>
						
						${seqList.contents }
					</div>

				</div>
				<!-- Comments Form -->


				<div class="detail-comment-container mt-5">
					<div id="commentNum" class="close">댓글 0</div>

					<form class="detail-comment-box" action="${param.seq }" method="post">
						<% if (session.getAttribute("sessionid") !=null) { %>
							<textarea placeholder="댓글을 작성해주세요." width="300px" id="contents" name="contents"></textarea>
							<div class="commentBtn">
								
									<div class="secret">
									<span>비밀글 </span><input id="secretCheckBtn" type="checkbox" name="secret">
									<input class="comment-button" id="submitBtn" type="button" value="댓글달기">
								</div>
								<input id="boardSeq" type="hidden" name="boardSeq" value="${param.seq}"> <input
									id="writer" type="hidden" name="writer" value="${param.writer}">
								</div>
						
							<% } else { %>
								<textarea placeholder="로그인 후 작성해주세요." width="300px" readonly></textarea>
								<% } %>

								
					</form>
					<ul id="comment" class="detail-comment-box2 mt-3"></ul>
					
				</div>


			</div>

		</div>
		</div>



	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"
		integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3"
		crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.min.js"
		integrity="sha384-7VPbUDkoPSGFnVtYi0QogXtr74QeVeeIs99Qfg5YCF+TidwNdjvaKZX19NZ/e6oz"
		crossorigin="anonymous"></script>

</body>

</html>