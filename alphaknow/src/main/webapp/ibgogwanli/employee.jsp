<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="classDirectory.byeol.dto.EmployeeDTO"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Employee</title>
<!-- 은별 공통 css. JS -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/eunbyeol_header,main.css">
<script src="${pageContext.request.contextPath}/js/eunbyeol.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>


<style>

/* new_register_pop , 신규등록 팝업 css */
#new_register_pop_wrap {
	display: none;
	width: 50%;
	max-height: 80%;
	position: fixed;
	top: 30%;
	right: 20%;
}

.department_check {
	width: 100%;
	display: flex;
}

.form_check {
	display: flex;
	align-items: center;
}

.department_check_label {
	white-space: nowrap;
	display: flex;
}

/* 테이블 숨기기 임시!*/
.hidden {
	display: none;
}


</style>
<script>

	// 팝업 관련 sript
	window.addEventListener('load', function() {
		// 신규등록 팝업 보이기, 숨기기
		let new_register_pop_wrap = document.getElementById("new_register_pop_wrap");
		document.getElementById("new_register").addEventListener("click",
				function() {
					new_register_pop_wrap.style.display = "block";
				});

		document.getElementById("register_close").addEventListener("click",
				function() {
					new_register_pop_wrap.style.display = "none";
				});
		
		// 신규등록 눌렀을 때 input창 초기화
		document.getElementById("new_register").addEventListener("click", function () {
	    // 텍스트와 비밀번호 입력란 초기화
		    Array.from(document.querySelectorAll('[type="text"], [type="password"]')).forEach(input => {
		        input.value = '';
		    });
		
	    // 부서코드 입력란 초기화
	    let departmentCode = document.getElementById('departmentCode');
		    if (departmentCode) {
		        departmentCode.value = '';
	    }
		 // 비밀번호 확인 메시지 초기화
		let check = document.getElementById('check');
		    if (check) {
		        check.textContent = '';
		    }
	});
		
		// 수정하기
		// 수정하기 버튼 클릭 시 실행되는 함수

		document.getElementById("edit").addEventListener("click", function () {
		    let selectedRows = document.querySelectorAll('table tbody input[type="checkbox"]:checked');

		    if (selectedRows.length === 1) {
		        let parentRow = selectedRows[0].closest('tr');
		        let cells = parentRow.querySelectorAll('td');

		        document.getElementsByName("employeeKey")[0].value = cells[1].textContent;
		        document.getElementsByName("employeeName")[0].value = cells[2].textContent;

		        let departmentCode = cells[3].textContent;
		        let departmentCheckboxes = document.querySelectorAll('input[name="departmentCode"]');
		        departmentCheckboxes.forEach(checkbox => {
		            if (checkbox.value === departmentCode) {
		                checkbox.checked = true;
		            }
		        });
		        
		        document.getElementsByName("employeePhone")[0].value = cells[4].textContent;
		        document.getElementsByName("jobGrade")[0].value = cells[5].textContent;
		        document.getElementsByName("managerPhone")[0].value = cells[6].textContent;

		        document.getElementsByName("employeeDate")[0].value = cells[8].textContent;
		        document.getElementsByName("employeeId")[0].value = cells[9].textContent;
		        document.getElementsByName("employeePw")[0].value = cells[10].textContent;

		        let employmentStatus = cells[7].textContent;
		        if (employmentStatus === "Yes") {
		            document.querySelector('input[name="employeementStatus"][value="Yes"]').checked = true;
		        } else {
		            document.querySelector('input[name="employeementStatus"][value="No"]').checked = true;
		        }

		        document.getElementById("new_register_pop_wrap").style.display = "block";
				
		        document.getElementById("formAction").value = "update";
		    } else if (selectedRows.length > 1) {
		        alert("하나의 사원만 선택해주세요.");
		    } else {
		        alert("수정할 사원을 선택해주세요.");
		    }
		});

		//삭제하기
		// "삭제" 버튼 클릭 이벤트
		document.getElementById('delete').addEventListener('click', function(e) {
			  e.preventDefault(); // 버튼의 기본 동작을 막습니다.

			  let selectedRows = document.querySelectorAll('table tbody input[class="employee-checkbox"]:checked');
			  
			  if (selectedRows.length > 0) {
			    let form = document.getElementById('employeeForm');
			    // 기존의 employeeKey hidden 필드를 제거합니다.
			    document.querySelectorAll('input[name="employeeKey"]').forEach(function(input) {
			      input.parentNode.removeChild(input);
			    });
			    
			    // 선택된 각 체크박스에 대해 hidden 필드를 폼에 추가합니다.
			    selectedRows.forEach(function(checkbox) {
			      let input = document.createElement('input');
			      input.type = 'hidden';
			      input.name = 'employeeKey';
			      input.value = checkbox.value;
			      form.appendChild(input);
			    });
			    
			    // 폼의 action을 delete로 설정하고 폼을 제출합니다.
			    form.action = '/alphaknow/employee';
			    let input = document.createElement('input');
			    input.type = 'hidden';
			    input.name = 'action';
			    input.value = 'delete';
			    form.appendChild(input);
			    form.submit();
			  } else {
			    // 선택된 행이 없다면 경고 메시지를 출력합니다.
			    alert('삭제할 직원을 선택해주세요.');
			  }
			});
		
		
        });

		
	
	// form 내용 체크
	window.addEventListener('load', function() {
		document.getElementById('employeeForm').addEventListener('input', function (event) {
		    // 사원코드가 입력되면 사원 아이디에 자동으로 입력
		    if (event.target.name === 'employeeKey') {
		        document.querySelector('input[name="employeeId"]').value = event.target.value;
		    }

		 // 비밀번호 확인이 비밀번호와 일치하지 않으면 메시지 출력
       document.getElementById('pw').addEventListener('input', checkPassword);
		document.getElementById('pw2').addEventListener('input', checkPassword);
		
		function checkPassword() {
		    let pw = document.getElementById('pw').value;
		    let pw2 = document.getElementById('pw2').value;
		    let check = document.getElementById('check');
		
		    if (pw !== '' && pw2 !== '') {
		        if (pw === pw2) {
		            check.textContent = '비밀번호가 일치합니다.';
		            check.style.color = 'blue';
		        } else {
		            check.textContent = '비밀번호가 일치하지 않습니다.';
		            check.style.color = 'red';
		        }
		    } else {
		        check.textContent = '';
		    }
		}
	});
		// 중복체크
		$(document).ready(function() {
		    $('#employeeSearch').click(function() {
		        let employeeKey = $('input[name="employeeKey"]').val();
		        $.ajax({
		            url: '/alphaknow/employee',
		            type: 'POST',
		            data: { employeeKey: employeeKey },
		            success: function(data) {
		                if (data.isDuplicate) {
		                    alert('중복, 사용불가');
		                    $('input[name="employeeKey"]').val('');
		                }
		            }
		        });
		    });
		});
		
		// 부서코드 체크박스 하나만 선택 가능
		document.querySelectorAll('input[type="checkbox"][name="departmentCode"]').forEach(function(element) {
		    element.addEventListener('change', function() {
		        document.querySelectorAll('input[type="checkbox"][name="departmentCode"]').forEach(function(otherElement) {
		            if (otherElement !== element) {
		                otherElement.checked = false;
		            }
		        });
		    });
		});
	});
	
	// content 관련 script
	window.addEventListener('load', function() {
	 // '전체 선택' 
    document.querySelector('table thead input[type="checkbox"]').addEventListener("change", function () {
        let isChecked = this.checked;
        Array.from(document.querySelectorAll('table tbody input[type="checkbox"]')).forEach(checkbox => {
            checkbox.checked = isChecked;
        });
    });
	});
</script>
</head>
<body>
	<%@ include file="../mainheader.jsp"%>

	<div id="content">


		<!-- content header 헤더 영역 -->
		<div id="main_header">
			<div id="content_header_title">사원(담당)리스트</div>
			<div id="content_header_search">
				<input type="text" id="list_search_text" value=""
					placeholder="입력 후 [Enter]">
				<button type="button" id="content_header_search_button"
					class="change_button">Search</button>
			</div>
		</div>


		<!-- content main 메인 영역 페이지네이션까지-->
		<div id=main_content_wrap>

			<!-- content main table, 메인 테이블 -->
			<table id="main_board">
				<!-- 테이블 너비 조절 -->
				<colgroup>
					<col style="width: 5%" />
					<col style="width: 15%" />
					<col style="width: 10%" />
					<col style="width: 15%" />
					<col style="width: 15%" />
					<col style="width: 15%" />
					<col style="width: 15%" />
					<col style="width: 10%" />

				</colgroup>
				<thead>
					<tr>
						<th><input type="checkbox"></th>
						<th>사원(담당)코드</th>
						<th>사원명</th>
						<th>부서</th>
						<th>연락처</th>
						<th>직급</th>
						<th>담당자연락처</th>
						<th>근무여부</th>
					</tr>

				</thead>
				<tbody>
					<!-- 항목이 동적으로 추가됨 -->
					<%
					// employees attribute에서 직원 정보를 가져옵니다.
					List<EmployeeDTO> employees = (List<EmployeeDTO>) request.getAttribute("employees");

					// 각 직원 정보를 테이블의 행으로 추가합니다.
					if (employees != null) {
						for (EmployeeDTO employee : employees) {
					%>
					<tr>
						<td><input type="checkbox" class="employee-checkbox"
							value="<%=employee.getEmployeeKey()%>"></td>
						<td><%=employee.getEmployeeKey()%></td>
						<td><%=employee.getEmployeeName()%></td>
						<td><%=employee.getDepartmentCode()%></td>
						<td><%=employee.getEmployeePhone()%></td>
						<td><%=employee.getJobGrade()%></td>
						<td><%=employee.getManagerPhone()%></td>
						<td><%=employee.getEmployeementStatus()%></td>
						<td class="hidden"><%=employee.getEmployeeDate()%></td>
						<td class="hidden"><%=employee.getEmployeeId()%></td>
						<td class="hidden"><%=employee.getEmployeePw()%></td>
					</tr>
					<%
					}
					}
					%>
				</tbody>

			</table>
			<div id="content_main_button">
				<!-- 신규등록 및 수정버튼-->
				<button id="new_register" class="change_button">신규등록</button>
				<button id="edit" class="button_basic">수정하기</button>
				<button id="delete" class="button_basic">삭제하기</button>
			</div>
			<div id=pagenation></div>
			<!-- content main wrap div 끝 -->
		</div>


		<!-- content div 끝 -->
	</div>


	<!-- new_register 신규등록 팝업 div -->
	<form method="post" action="/alphaknow/employee" id="employeeForm"
		value="">
		<div class="pop_wrap" id="new_register_pop_wrap">
			<div class="pop_header">
				<div class="pop_header_title">사원(담당)등록</div>
			</div>
			<div class="pop_content_wrap">
				<div class="pop_content_header">
					<div class="pop_content_title">사원(담당)등록</div>
				</div>
				<div class="pop_content_com">
					<div class="wrapper_ul">
						<ul class="wrapper_li">
							<li id="employeeKey" class="whole_row">
								<div class="title">사원(담당)코드</div>
								<div class="form">
									<div class="control_set">
										<button type="button" id="employeeSearch" class="button_basic">중복조회</button>
										<input type="text" name="employeeKey" placeholder="사원코드 입력">
									</div>
								</div>
							</li>
							<li id="employeeName" class="whole_row">
								<div class="title">사원명</div>
								<div class="form">
									<div class="control_set">
										<input type="text" name="employeeName" placeholder="사원명 입력">
									</div>
								</div>
							</li>
							<li id="employeePhone" class="whole_row">
								<div class="title">연락처</div>
								<div class="form">
									<div class="control_set">
										<input type="text" name="employeePhone" placeholder="연락처 입력">
									</div>
								</div>
							</li>
							<li id="employeeDate" class="whole_row">
								<div class="title">입사일</div>
								<div class="form">
									<div class="control_set">
										<input type="date" name="employeeDate" placeholder="달력 입력 예정">
									</div>
								</div>
							</li>
							<li id="departmentCode" class="whole_row">
								<div class="title">부서코드</div>
								<div class="form">
									<div class="control_set">
										<div class="department_check">
											<span class="form_check"> <input type="checkbox"
												name="departmentCode" value="1" id="1"> <label
												for="1" class="department_check_label"> 관리 </label>
											</span> <span class="form_check"> <input type="checkbox"
												name="departmentCode" value="2" id="2"> <label
												for="2" class="department_check_label"> 생산 </label>
											</span> <span class="form_check"> <input type="checkbox"
												name="departmentCode" value="3" id="3"> <label
												for="영업" class="department_check_label"> 영업 </label>
											</span> <span class="form_check"> <input type="checkbox"
												name="departmentCode" value="4" id="4"> <label
												for="4" class="department_check_label"> 구매 </label>
											</span>
										</div>
									</div>
								</div>
							</li>
							<li id="jobGrade" class="whole_row">
								<div class="title">직급</div>
								<div class="form">
									<div class="control_set">
										<input type="text" name="jobGrade" placeholder="직급 입력">
									</div>
								</div>
							</li>
							<li id="employeeId" class="whole_row">
								<div class="title">사원아이디</div>
								<div class="form">
									<div class="control_set">
										<input type="text" name="employeeId" readOnly>
									</div>
								</div>
							</li>
							<li id="employeePw" class="whole_row">
								<div class="title">비밀번호</div>
								<div class="form">
									<div class="control_set">
										<input type="password" id="pw" name="employeePw"
											placeholder="비밀번호 입력">
									</div>
								</div>
							</li>
							<li id="employeePwCheck" class="whole_row">
								<div class="title">비밀번호확인</div>
								<div class="form">
									<div class="control_set">
										<input type="password" name="
											employeePwCheck"
											id="pw2" placeholder="비밀번호 재입력">
										<div id=check></div>
									</div>
								</div>
							</li>
							<li id="managerPhone" class="whole_row">
								<div class="title">담당자연락처</div>
								<div class="form">
									<div class="control_set">
										<input type="text" name="managerPhone"
											placeholder="담당자 연락처 입력">
									</div>
								</div>
							</li>
							<li id="employeementStatus" class="whole_row">
								<div class="title">근무여부</div>
								<div class="form">
									<div class="control_set">
										<div class="use_check">
											<input type="radio" name="employeementStatus" value="Yes"
												checked> 재직 <input type="radio"
												name="employeementStatus" value="No"> 퇴직
										</div>
									</div>
								</div>
							</li>
						</ul>
					</div>
				</div>
				<div class="pop_footer_wrap">
					<div class="pop_footer">
					<input type="hidden" name="action" id="formAction">
						<input type="submit" value="저장" class="change_button"
							id="employee_save">
						<button type="button" class="button_basic" id="register_reset">다시쓰기</button>
						<button type="button" class="button_basic" id="register_close">닫기</button>
					</div>
				</div>
			</div>
		</div>
	</form>
</body>

</html>