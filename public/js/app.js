$(document).ready(function (){
  const Canvas = document.getElementById('julia-canvas');
  const Ctx = Canvas.getContext('2d');
  const CanvasWidth = Canvas.width;
  const CanvasHeight = Canvas.height;

  $("#form-julia").submit(function(e) {
    e.preventDefault();
    $(".error").remove();
    const FormData = $(this).serialize();
    $.ajax({
      type: 'GET',
      url: '/satori/julia/api',
      data: FormData,
      success: function(res) {
        const Data = JSON.parse(res);
        
        // 各ピクセルに色を指定
        for (let x = 0; x < CanvasWidth; x++) {
          for (let y = 0; y < CanvasHeight; y++) {
            Ctx.fillStyle = `hsl(${Data[x * CanvasHeight + y]}, 100%, 50%)`;
            Ctx.fillRect(x, y, 1, 1);
          }
        }
      },
      error: function(xhr) {
        const Err = JSON.parse(xhr.responseText);
        const ErrMessage = $(`<p class='error'>${Err.message}</p>`);
        $("#form-julia").after(ErrMessage);
      }
    })
  });
});