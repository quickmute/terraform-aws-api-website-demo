(function myScopeWrapper($) {
    $(function onDocReady() {
  alert('Welcome');
  $('#enterBtn').click(handleRequestClick);

        if (!_config.api.invokeUrl) {
            $('#noApiMessage').show();
        }
    });

 function handleRequestClick(){
  var argument = $('#argument').val();
        calc(argument);
 }
 
 function calc(argument_var){
   $.ajax({
            method: 'POST',
            url: _config.api.invokeUrl + '/myCalc',
            headers: {
            
            },
            data: JSON.stringify({
                argument: argument_var
            }),
            contentType: 'application/json',
            success: completeRequest,
            error: completeRequest
        });
    }
 
    function completeRequest(result) {
        console.log('Response received from API: ', result);
        displayUpdate(result.Response);
    }

    function displayUpdate(text) {
        $('#updates').append($('<li>' + text + '</li>'));
    } 
 
}(jQuery));
