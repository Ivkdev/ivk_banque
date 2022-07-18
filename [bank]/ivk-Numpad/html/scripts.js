




function openContainer()
{

  $("#wrap").css("display", "block");
$( "#PINcode" ).html(
  "<form action='' method='' name='PINform' id='PINform' autocomplete='off' draggable='true'>" +
    "<input id='PINbox' type='password' class='NeedGone' value='' name='PINbox' disabled />" +
    "<br/>" +
    "<input type='button' class='PINbutton' name='1' value='1' id='1' onClick=addNumber(this); />" +
    "<input type='button' class='PINbutton' name='2' value='2' id='2' onClick=addNumber(this); />" +
    "<input type='button' class='PINbutton' name='3' value='3' id='3' onClick=addNumber(this); />" +
    "<br>" +
    "<input type='button' class='PINbutton' name='4' value='4' id='4' onClick=addNumber(this); />" +
    "<input type='button' class='PINbutton' name='5' value='5' id='5' onClick=addNumber(this); />" +
    "<input type='button' class='PINbutton' name='6' value='6' id='6' onClick=addNumber(this); />" +
    "<br>" +
    "<input type='button' class='PINbutton' name='7' value='7' id='7' onClick=addNumber(this); />" +
    "<input type='button' class='PINbutton' name='8' value='8' id='8' onClick=addNumber(this); />" +
    "<input type='button' class='PINbutton' name='9' value='9' id='9' onClick=addNumber(this); />" +
    "<br>" +
    "<input type='button' class='PINbutton clear' name='-' value='clear' id='-' onClick=clearForm(this); />" +
    "<input type='button' class='PINbutton zero' name='0' value='0' id='0' onClick=addNumber(this); />" +
    "<input type='button' class='PINbutton enter' name='+' value='enter' id='+' onClick=submitForm(PINbox); />" +
    "<input type='button' class='PINbutton cancel' name='close' value='cancel' id='+' onClick=closeForm(this); />" +
  "</form>"
);

}

function closeContainer()
{
  $("#wrap").css("display", "none");
}

window.addEventListener('message', function(event){
  var item = event.data;

  if(item.open === true) {
    openContainer()
  }
  if(item.close === true) {
    closeContainer()
  }


});

let keys = [1,2,3,4,5,6,7,8,9,0]

document.onkeyup = function (data) {
  if (data.which == 27 ) {
    $.post('http://FzD-Numpad/close', JSON.stringify({}));
  } else if (data.which == 13 ) {
    $.post('http://FzD-Numpad/complete', JSON.stringify({ pin: $( "#PINbox" ).val() }));
  } else {
    if ( !isNaN(data.key) ) {
      var v = $( "#PINbox" ).val();
      $( "#PINbox" ).val( v + data.key );
    }
  }
};


function addNumber(e){
  var v = $( "#PINbox" ).val();
  $( "#PINbox" ).val( v + e.value );
}
function clearForm(e){
  $( "#PINbox" ).val( "" );
}
function closeForm(e){
  $.post('http://FzD-Numpad/close', JSON.stringify({}));
  $( "#PINbox" ).val( "" );
}
function submitForm(e) {
  if (e.value == "") {

  } else {
    $.post('http://FzD-Numpad/complete', JSON.stringify({ pin:e.value }));
    data = {
      pin: e.value
    }
    $( "#PINbox" ).val( "" );
  };
};

