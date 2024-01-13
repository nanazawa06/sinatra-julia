$(document).ready(function (){
  const Canvas = document.getElementById('julia-canvas');
  const Ctx = Canvas.getContext('2d');
  const CanvasWidth = Canvas.width;
  const CanvasHeight = Canvas.height;

  $("#form-julia").submit(function(e) {
    e.preventDefault();
    const FormData = $(this).serialize();
    $.ajax({
      type: 'GET',
      url: '/satori/julia',
      data: FormData,
      success: function(res) {
        const Data = JSON.parse(res);
        
        // 各ピクセルに色を指定
        for (let x = 0; x < CanvasWidth; x++) {
          for (let y = 0; y < CanvasHeight; y++) {
            Ctx.fillStyle = `rgb(${Data[x * CanvasHeight + y]}, 0, 0)`;
            Ctx.fillRect(x, y, 1, 1);
          }
        }
      },
      error: function(error) {
        console.log('Error: ', error);
      }
    })
  });
});