<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>자유게시판  글 보기</title>
<tag:free_header/>

</head>

<body>

	<div class="container">
		<div class="page-header">
			<h3>
				자유게시판  <small>글 보기</small>
			</h3>
		</div>
		<table class="table table-striped table-bordered">
			<tbody>
				<tr>
					<th>글번호</th>
					<td>${board.boNo }</td>
				</tr>
				<tr>
					<th>글분류</th>
					<td>${board.boCate }</td>
				</tr>
				<tr>
					<th>글제목</th>
					<td>${board.boTitle }</td>
				</tr>
				<tr>
					<th>작성자명</th>
					<td>${board.boWriter }</td>
				</tr>
				<!-- 비밀번호는 보여주지 않음  -->
				<tr>
					<th>내용</th>
					<td><textarea rows="10" name="boContent" class="form-control input-sm" readonly="readonly">
					${board.boContent }
				</textarea></td>
				</tr>
				<tr>
					<th>조회수</th>
					<td>${board.boHit }</td>
				</tr>
				<tr>
					<th>최근등록일자</th>
					<td>${board.boModDate eq null ? board.boRegDate : board.boModDate}</td>
				</tr>
				<tr>
					<th>삭제여부</th>
					<td>${board.boDelYn }</td>
				</tr>
				<tr>
					<td colspan="2">
						<div class="pull-left">
							<a href="boardList.wow" class="btn btn-default btn-sm"> <span class="glyphicon glyphicon-list" aria-hidden="true"></span> &nbsp;&nbsp;목록
							</a>
						</div>
						<div class="pull-right">
							<a href="boardEdit.wow?boNo=${board.boNo }" class="btn btn-success btn-sm"> <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span> &nbsp;&nbsp;수정
							</a>
						</div>
					</td>
				</tr>
			</tbody>
		</table>
	</div>

		<!-- 댓글 영역 -->
	<div class="container">
		<!-- // START : 댓글 등록 영역  -->
		<div class="panel panel-default">
			<div class="panel-body form-horizontal">
			
				<form name="frm_reply" action="<c:url value='/reply/replyRegist' />" method="post" onclick="return false;">
					<input type="text" name="reBoNo" value="${board.boNo}" hidden="">
					<div class="form-group">
						<label class="col-sm-2  control-label">댓글</label>
						<div class="col-sm-8">
							<textarea rows="3" name="reContent" class="form-control"></textarea>
						</div>
						<div class="col-sm-2">
							<button id="btn_reply_regist" type="button" class="btn btn-sm btn-info">등록</button>
						</div>
					</div>
				</form>
				
				
			</div>
		</div>
		<!-- // END : 댓글 등록 영역  -->
		<!-- // START : 댓글 목록 영역  -->
		<div id="id_reply_list_area"></div>

		<div class="row text-center" id="id_reply_list_more">
			<a id="btn_reply_list_more" class="btn btn-sm btn-default col-sm-10 col-sm-offset-1">
			 <span class="glyphicon glyphicon-chevron-down" aria-hidden="true"></span> 더보기
			</a>
		</div>
		<!-- // END : 댓글 목록 영역  -->

		<!-- START : 댓글 수정용 Modal -->
		<div class="modal fade" id="id_reply_edit_modal" role="dialog">
			<div class="modal-dialog">
				<!-- Modal content-->
				<div class="modal-content">
					<form name="frm_reply_edit" action="<c:url value='/reply/replyModify' />" method="post" onclick="return false;">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">×</button>
							<h4 class="modal-title">댓글수정</h4>
						</div>
						<div class="modal-body">
							<input type="hidden" name="reNo" value="">
							<textarea rows="3" name="reContent" class="form-control"></textarea>
						</div>
						<div class="modal-footer">
							<button id="btn_reply_modify" type="button" class="btn btn-sm btn-info">저장</button>
							<button type="button" class="btn btn-default btn-sm" data-dismiss="modal">닫기</button>
						</div>
					</form>
				</div>
			</div>
		</div>
		<!-- END : 댓글 수정용 Modal -->

	</div>
	<!-- reply container -->

	<!-- START : 댓글 처리 스크립트 -->
<script type="text/javascript">
// 상단에 전역변수 - 공통함수 - 이벤트 함수 - 초기화처리  
var replyParam = {
		"curPage":1, "rowSizePerPage":5, "reBoNo":${board.boNo}
}

// 댓글목록을 구하는 함수
function fn_reply_list(){
	
	$.ajax({ 
		  type :"POST"
		, url : '<c:url value="/reply/replyList" />' 		
		, dataType : 'json' 
		, data : replyParam	
		, success : function(data) {
				// console.log('data', data);
				if(data.result){				
					// find : (.+)   repl : str += '$1';
					$reply_list_area = $('#id_reply_list_area');
					$.each(data.data, function(i, el) {    
						console.log(i, el);
						// console.log('${sessionScope.USER_INFO.userId}');
						var str = '<div class="row"  data-re-no="'+el.reNo+'">';
						str += '<div class="col-sm-2 text-right">' + el.reWriter + '</div>';
						str += '<div class="col-sm-6">';
						str += '<pre>' + el.reContent + '</pre>';
						str += '</div>';
						str += '<div class="col-sm-2">' + el.reRegDate + '</div>';
						if ('${sessionScope.MEM_INFO.memId}' == el.reMemId) {
							str += '<div class="col-sm-2">';
							str += '<button name="btn_reply_edit" type="button" class=" btn btn-sm btn-info" data-bs-toggle="modal" data-bs-target="#id_reply_edit_modal">수정</button>';
							str += '<button name="btn_reply_delete" type="button" class="btn btn-sm btn-danger">삭제</button>';
							str += '</div>';
						}
						str += '</div>';
						
						$reply_list_area.append(str); //id_reply_list_area영역에  추가 
					});
					replyParam.curPage += 1;
					// 더보기 버튼 처리  
					if(data.count < replyParam.rowSizePerPage ){
						$('#btn_reply_list_more').hide();
					}
				}
		  }  
		, error : function(req, st, err) {
				console.log('----------------------------');
				console.log('request', req);
				console.log('status', st);
				console.log('errors', err);
				console.log('----------------------------');
			}	 	
	}); // ajax
} // fn_reply_list

$(document).ready(function() {
	
	// 수정버튼 클릭
	$('#id_reply_list_area').on('click','button[name=btn_reply_edit]',function(e){
		// 모달창 띄우기 , 현재 클릭한 버튼의 영역에서 reNo, reContext 를
		// this : javascript 객체 -> jQuery 객체 $(this) 
		$btn = $(this);
		$div = $btn.closest('div.row');
// 		$div = $btn.closest('[data-re-no']);
		// 모달창 내의 폼에 복사 
		// var f = document.forms.frm_reply_edit;
		// f.reNo.value = $div.data('re-no');
		console.log($div.data );
		$('form[name=frm_reply_edit] input[name=reNo]').val($div.data('re-no'));
		$('form[name=frm_reply_edit] textarea[name=reContent]').val($div.find('div pre').text());
		$('#id_reply_edit_modal').modal();
		
	}); // btn_reply_edit.click
	
	// 모달창의 (수정)저장버튼 btn_reply_modify 클릭
	$("#btn_reply_modify").click(function(e) {
		e.preventDefault();		// 이벤트 전파방지. 엔터 등으로 서브밋 되는 것 방지
		$btn = $(this);
		$div = $btn.closest('div.row');
// 		$divn = $btn.closest('div.modal_body input[name=reNo]');
		
		res = confirm("글을 수정하시겠습니까?");
		if(res){
			params = $('form[name=frm_reply_edit]').serialize();
			$.ajax({
				type :"POST" 						// 전송 방식 설정 (Defaut : GET)
		      , url : '<c:url value="/reply/replyModify" />'			// 요청 페이지 URL정보
			  , dataType : 'json'  					// 서버로부터 전달받을 데이터 유형 (html, xml, json, script)
			  , data : params						// 서버에 전송할 파라미터 정보
			  , success : function(data) {
					console.log('data',data);
					if(data.result) {
						// 서버에 정보 전송
						// 모달 창 안의 텍스트를 데이터베이스에 등록하고, 
						
						// 35번 댓글 수정을 성공했다면?
						// modal form에 있는 textarea의 값을 div.class[data-re-no=35]의 textarea에 넣기
						
						var $rn = $('form[name=frm_reply_edit] input[name=reNo]').val()
						var $rc = $('form[name=frm_reply_edit] textarea[name=reContent]').val()
						 
						$('div.row[data-re-no='+$rn+']').find('pre').text($rc)
						
						// modal form의 reNo, reContent는 ''으로 설정
						$('form[name=frm_reply_edit] input[name=reNo]').val('')
						$('form[name=frm_reply_edit] textarea[name=reContent]').val('')
						
						/* replyParam.curPage = 1;
						$('#id_reply_list_area').html('');
						fn_reply_list(); */
						
						$('#id_reply_edit_modal').modal('hide');
					} else {
						alert(data.msg);
					}
				} 		 		// 요청에 성공한 경우 호출되는 함수 (data, status, xhr )
			  , error :	function(req, st, err) {
					console.log('----------------------------------');
					console.log('request', req);
					console.log('status', st);
					console.log('errors', err);
					console.log('----------------------------------');
					if(req.status == 401) {		// 로그인이 안 되어있으면 로그인 페이지로 이동
						window.location.href = '<c:url value="/login/login.wow" />'
					}
				}			// 요청에 실패한 경우 호출되는 함수 (xhr, status, error)
			}); 	// ajax
		}
		
	}); // btn_reply_modify.click
	
	// 삭제버튼 클릭
	$('#id_reply_list_area').on('click','button[name=btn_reply_delete]',function(e){
		$btn = $(this);
		$div = $btn.closest('div.row');
		res = confirm("글을 삭제하시겠습니까?");
		if(res){
			params = "reNo=" + $div.data('re-no');
			$.ajax({ 
				  type :"POST"
				, url : '<c:url value="/reply/replyDelete"/>' 		
				, dataType : 'json' 
				, data : params	
				, success : function(data) {
						console.log('data', data);
						if(data.result){
							$div.remove();
						}else{
							alert(data.msg);
						}
				  }  
				, error : function(req, st, err) {
						console.log('----------------------------');
						console.log('request', req);
						console.log('status', st);
						console.log('errors', err);
						console.log('----------------------------');
					}	 	
			}); // ajax			
		}  // confirm		
		
		
	}); // btn_reply_delete.click

	// 더보기 버튼 클릭
	$('#btn_reply_list_more').click(function(e) {
		fn_reply_list();
	}); // #btn_reply_list_more.click
	
	// 등록버튼 클릭
	$("#btn_reply_regist").click(function(e) {
		e.preventDefault();
		res = confirm("글을 등록하시겠습니까?");
		if(res){
			params = $('form[name=frm_reply]').serialize();
			$.ajax({ 
				  type :"POST"
				, url : '<c:url value="/reply/replyRegist" />' 		
				, dataType : 'json' 
				, data : params	
				, success : function(data) {
						console.log('data', data);
						if(data.result){
							replyParam.curPage = 1;
							document.forms.frm_reply.reContent.value = '';
							// $('from[name=frm_reply] textarea[name=reContent]').val('');							
							// 현재 목록영역 remove()
							$('#id_reply_list_area').html('');
							// 목록조회 함수 호출 
							fn_reply_list();
						}else{
							alert(data.msg);
						}
				  }  
				, error : function(req, st, err) {
						console.log('----------------------------');
						console.log('request', req);
						console.log('status', st);
						console.log('errors', err);
						console.log('----------------------------');
					}	 	
			}); // ajax			
		}  // confirm		
	}); // #btn_reply_regist.click

	// 초기화 함수 호출
	fn_reply_list();
	
}); // ready

</script>
<!-- END : 댓글 처리 스크립트 -->

</body>
</html>