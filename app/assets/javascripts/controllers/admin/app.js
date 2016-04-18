/**
 * Created by steven on 16/4/18.
 */
$(document).ready(function () {
  alert('ok1');

  $('a').on('click', function (event) {
    alert('ok2');
    event.preventDefault();
    $.ajax({
        type: 'GET',
        url: '/admin/products/set_recommended',
        data: {id: this.id},
        success: function (res) {
          $info = res['data'];
        }
      }
    );
  })
})