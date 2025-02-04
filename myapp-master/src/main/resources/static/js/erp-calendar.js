
erpCalendar = {
	
  initGoodsCalendar: function(calendarID){
    //$calendar = $('#goodsCalendar');
    $calendar = $('#' + calendarID);

    today = new Date();
    y = today.getFullYear();
    m = today.getMonth();
    d = today.getDate();
    
    $calendar.fullCalendar({
			
			locale: 'ko', // 한국어 설정
			
      viewRender: function(view, element) {
        // We make sure that we activate the perfect scrollbar when the view isn't on Month
        if (view.name != 'month'){
          $(element).find('.fc-scroller').perfectScrollbar();
        }
      },
      
      // 캘린더 타이틀 구성요소 배치 
      header: {
        left: 'title',
        center: 'prev, next, today',
        right: 'month, agendaWeek, agendaDay'
  },
  
  defaultDate: today,
  selectable: true,
  selectHelper: true,
    views: {
      month: { // name of view
        titleFormat: 'MMMM YYYY'
        // other view-specific options here
      },
      week: {
        titleFormat: " MMMM D YYYY"
      },
      day: {
        titleFormat: 'D MMM, YYYY'
      }
    },

  select: function(start, end) {

            // on select we show the Sweet Alert modal with an input
    swal({
      title: 'Create an Event',
      html: '<div class="form-group">' +
                        '<input class="form-control" placeholder="Event Title" id="input-field">' +
                    '</div>',
      showCancelButton: true,
      confirmButtonClass: 'btn btn-info btn-fill',
      cancelButtonClass: 'btn btn-danger btn-fill',
      buttonsStyling: false
    }).then(function(result) {

      var eventData;
      event_title = $('#input-field').val();

      if (event_title) {
        eventData = {
          title: event_title,
          start: start,
          end: end
        };
          
        $calendar.fullCalendar('renderEvent', eventData, true); // stick? = true
      }

      $calendar.fullCalendar('unselect');

    });
  },
  
  editable: true,
  eventLimit: true, // allow "more" link when too many events

  
});



}
}