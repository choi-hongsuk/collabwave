<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<c:set var="dt" value="<%=System.currentTimeMillis()%>"/>

<!-- fullcalendar css -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.css">
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/moment.min.js"></script>
<!-- fullcalendar 언어 설정관련 script -->
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/locales-all.js"></script>

<style>
.fc-col-header-cell-cushion, .fc-daygrid-day-number {
    text-decoration: none;
}

.fc-scrollgrid-sync-inner > .fc-col-header-cell-cushion,
.fc-day-mon .fc-daygrid-day-number,
.fc-day-tue .fc-daygrid-day-number,
.fc-day-wed .fc-daygrid-day-number,
.fc-day-thu .fc-daygrid-day-number,
.fc-day-fri .fc-daygrid-day-number {
    color: black;
}

.fc-day-sun .fc-col-header-cell-cushion,
.fc-day-sun a {
    color : red;
}

.fc-day-sat .fc-col-header-cell-cushion,
.fc-day-sat a {
    color : blue;
}

/* no-click 클래스에 포인터 이벤트 차단 */
.fc-event.no-click {
    pointer-events: none;
}

.event-popup {
    display: none;
    position: fixed;
    z-index: 999;
    left: 50%;
    top: 50%;
    transform: translate(-50%, -50%);
    background-color: white;
    box-shadow: 0 4px 8px rgba(0,0,0,0.1);
    padding: 20px;
    border-radius: 5px;
}

.event-popup-content {
    position: relative;
}

.close {
    position: absolute;
    top: 10px;
    right: 10px;
    font-size: 20px;
    cursor: pointer;
}
</style>

<jsp:include page="../../layout/header.jsp"/>

<div class="main-content">
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-2">
                <jsp:include page="./scheduleSidebar.jsp"/>
            </div>
            <div class="col-md-10">
                <div class="card card-calendar">
                    <div id='calendar'></div> 
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 이벤트 팝업 -->
<div id="eventPopup" class="event-popup">
    <div class="event-popup-content">
        <span id="closePopup" class="close">&times;</span>
        <h4>일정 정보</h4>
        <p id="popupTitle"></p>
        <p id="popupStart"></p>
        <p id="popupEnd"></p>
        <p id="popupContents"></p>
        <input type="hidden" id="popupScdlNo">
        <button id="editScheduleBtn">수정</button>
        <button id="deleteScheduleBtn">삭제</button>
    </div>
</div>

<!-- 일정 수정 팝업 -->
<div id="editPopup" class="event-popup">
    <div class="event-popup-content">
        <span id="closeEditPopup" class="close">&times;</span>
        <h4>일정 수정</h4>
        <input type="hidden" id="editScdlNo">
        <label>제목:</label>
        <input type="text" id="editTitle"><br>
        <label>시작일:</label>
        <input type="date" id="editStartDate">
        <input type="time" id="editStartTime"><br>
        <label>종료일:</label>
        <input type="date" id="editEndDate">
        <input type="time" id="editEndTime"><br>
        <label>내용:</label>
        <textarea id="editContents"></textarea><br>
        <button id="saveEditBtn">저장</button>
    </div>
</div>

<jsp:include page="../../layout/footer.jsp"/>

<script>
document.addEventListener('DOMContentLoaded', function() {
	
    var calendarEl = document.getElementById('calendar');
    var eventPopup = document.getElementById('eventPopup');
    var closePopup = document.getElementById('closePopup');
    var deleteScheduleBtn = document.getElementById('deleteScheduleBtn');
    
    var selectedEventId;
    
    var empCode = '${sessionScope.emp.empCode}'; // 로그인한 사용자의 세션, 사용자 코드 
    
    closePopup.onclick = function() {
        eventPopup.style.display = 'none';
    }

    window.onclick = function(event) {
        if (event.target == eventPopup) {
            eventPopup.style.display = 'none';
        }
    }

    var calendar = new FullCalendar.Calendar(calendarEl, {
        googleCalendarApiKey: "AIzaSyDR6YAOuphCrCL2diTCS6ZM4LBSb4vIhXY",
        eventSources: [ 
            {
                googleCalendarId: 'ko.south_korea#holiday@group.v.calendar.google.com',
                color: 'red',
                textColor: 'white',
                className: 'no-click'
            },
            {
                url: '${contextPath}/schedule/getScheduleList.do',
                method: 'GET',
                failure: function() {
                    alert('일정을 가져오는데 실패했습니다.');
                }
            }
        ],
        initialView: 'dayGridMonth',
        headerToolbar: {
            left: 'prev next today',
            center: 'title',
            right: 'dayGridMonth timeGridWeek timeGridDay listWeek'
        },
        nowIndicator: true,
        locale: 'ko',
        eventClick: function(info) {
            if (!info.event.classNames.includes('no-click')) {
                var start = moment(info.event.start);
                var end = info.event.end ? moment(info.event.end) : start; // Ensure end date is valid
                
                var startDateText = start.format('YYYY-MM-DD');
                var startTimeText = start.format('HH:mm') !== '00:00' ? start.format('HH:mm') : '';
                
                var endDateText = end.format('YYYY-MM-DD');
                var endTimeText = end.format('HH:mm') !== '00:00' ? end.format('HH:mm') : '';

                document.getElementById('popupScdlNo').innerText = info.event.extendedProps.scdlNo;
                document.getElementById('popupTitle').innerText = info.event.title;
                document.getElementById('popupStart').innerText = '일정시작 : ' + startDateText + (startTimeText ? ' ' + startTimeText : '');
                document.getElementById('popupEnd').innerText = '일정종료 : ' + endDateText + (endTimeText ? ' ' + endTimeText : '');
                document.getElementById('popupContents').innerText = '내용 : ' + info.event.extendedProps.contents;

                selectedEventId = info.event.extendedProps.scdlNo;
                eventPopup.style.display = 'block';
            }
        },
        eventDidMount: function(info) {
            if (info.event.source.googleCalendarId) {
                info.el.classList.add('no-click');
            }
        }
    });

    calendar.render();

    deleteScheduleBtn.onclick = function() {
        if (confirm("일정을 삭제하겠습니까?")) {
            var scdlNo = encodeURIComponent(selectedEventId);

            fetch('${contextPath}/schedule/delete.do', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: 'scdlNo=' + scdlNo
            })
            .then(response => response.text())
            .then(data => {
                if (data === 'success') {
                    alert('일정이 삭제되었습니다.');
                    calendar.refetchEvents();
                    eventPopup.style.display = 'none';
                } else {
                    alert('일정 삭제에 실패했습니다.');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('일정 삭제 중 오류가 발생했습니다.');
            });
        }
    }
    
    var editPopup = document.getElementById('editPopup');
    var closeEditPopup = document.getElementById('closeEditPopup');
    var editScheduleBtn = document.getElementById('editScheduleBtn');
    var saveEditBtn = document.getElementById('saveEditBtn');

    closeEditPopup.onclick = function() {
        editPopup.style.display = 'none';
    }

    editScheduleBtn.onclick = function() {
        document.getElementById('editScdlNo').value = selectedEventId;
        document.getElementById('editTitle').value = document.getElementById('popupTitle').innerText;
        
        var startText = document.getElementById('popupStart').innerText.replace('일정시작 : ', '');
        var endText = document.getElementById('popupEnd').innerText.replace('일정종료 : ', '');
        
        var startDateTime = moment(startText, 'YYYY-MM-DD HH:mm');
        var endDateTime = moment(endText, 'YYYY-MM-DD HH:mm');

        if (startDateTime.isValid()) {
            document.getElementById('editStartDate').value = startDateTime.format('YYYY-MM-DD');
            document.getElementById('editStartTime').value = startDateTime.format('HH:mm');
        } else {
            document.getElementById('editStartDate').value = moment(startText, 'YYYY-MM-DD').format('YYYY-MM-DD');
            document.getElementById('editStartTime').value = '';
        }

        if (endDateTime.isValid()) {
            document.getElementById('editEndDate').value = endDateTime.format('YYYY-MM-DD');
            document.getElementById('editEndTime').value = endDateTime.format('HH:mm');
        } else {
            document.getElementById('editEndDate').value = moment(endText, 'YYYY-MM-DD').format('YYYY-MM-DD');
            document.getElementById('editEndTime').value = '';
        }

        document.getElementById('editContents').value = document.getElementById('popupContents').innerText.replace('내용 : ', '');
        
        editPopup.style.display = 'block';
    }

    saveEditBtn.onclick = function() { // 수정 후 저장 버튼 클릭 시 
        var scdlNo = document.getElementById('editScdlNo').value;
        var title = document.getElementById('editTitle').value;
        
        var startDate = document.getElementById('editStartDate').value;
        var startTime = document.getElementById('editStartTime').value;
        var endDate = document.getElementById('editEndDate').value;
        var endTime = document.getElementById('editEndTime').value;
        
        var start = startDate + (startTime ? 'T' + startTime : ''); 
        var end = endDate + (endTime ? 'T' + endTime : ''); 
        
        var contents = document.getElementById('editContents').value;

        fetch('${contextPath}/schedule/update.do', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                scdlNo: scdlNo,
                scdlTitle: title,
                startDatetime: start,
                endDatetime: end,
                scdlContents: contents
            })
        })
        .then(response => response.text())
        .then(data => {
            if (data === 'success') {
                alert('일정이 수정되었습니다.');
                calendar.refetchEvents();
                editPopup.style.display = 'none';
                eventPopup.style.display = 'none';
            } else {
                alert('일정 수정에 실패했습니다.');
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('일정 수정 중 오류가 발생했습니다.');
        });
    }
});
</script>
