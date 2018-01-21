$(document).ready(function() {
  $('#category_status').selectpicker({
    style: 'btn-success'
  });

  $('.datepicker').datepicker({
    format: 'mm dd yyyy',
    startDate: '-1d'
  });

  $('#income_category_id').selectpicker({
    style: 'btn-success'
  });

  $('#expense_category_id').selectpicker({
    style: 'btn-danger'
  });

  $('#category_search').selectpicker({
    style: 'btn-success',
    liveSearch: true
  });
});
