$(function() {
    window.addEventListener('message', function(event) {
        if (event.data.type === "openbank"){
          $('#serverName').html(event.data.serverName);
          $('#currency1').html(event.data.currency);
          $('#currency2').html(event.data.currency);
          $('#currency3').html(event.data.currency);
          $('#currency4').html(event.data.currency);
          $('#currency5').html(event.data.currency);
          $('#currency6').html(event.data.currency);
          $('#currency7').html(event.data.currency);
          $('#currency8').html(event.data.currency);
          $('#currency9').html(event.data.currency);
          $('#currency10').html(event.data.currency);
          $('#currency11').html(event.data.currency);
          $('#currency12').html(event.data.currency);
          $('#currency13').html(event.data.currency);
          $('#currency14').html(event.data.currency);
          $('#currency15').html(event.data.currency);
          $('#currency16').html(event.data.currency);
          $('#main').show(100);
          $('#home').show(100);
          $("#accounthome").addClass('active');
          $("#withdrawals").removeClass('active');
          $("#deposit").removeClass('active');
          $("#transfer").removeClass('active');
          $("#savings").removeClass('active');
          $("#options").removeClass('active');
          $("#savingAccountCreator").css({"display":"block"});
          $("#changePin").css({"display":"none"});

          if(event.data.savings !== false && event.data.savings !== null) {
            $("#savingAccountCreator").css({"display":"none"});
            $("#savingAccount").css({"display":"block"});
            $('#currentSavingBalance').html(event.data.currentSavingBalance);
          } else {
            $("#savingAccountCreator").css({"display":"block"});
            $("#savingAccount").css({"display":"none"});
          }
        }

        else if (event.data.type === "CreatedSavings"){
          if(event.data.savings !== false && event.data.savings !== null) {
            $("#savingAccountCreator").css({"display":"none"});
            $("#savingAccount").css({"display":"block"});
            $('#currentSavingBalance').html(event.data.currentSavingBalance);
          } else {
            $("#savingAccountCreator").css({"display":"block"});
            $("#savingAccount").css({"display":"none"});
          }
        }
        
        else if (event.data.type === "closebank"){
          $('#main').hide(100);
          $("#savingAccountCreator").css({"display":"block"});
        }

        else if (event.data.type === "sendBalnce"){
          $('#customerName').html(event.data.customer);
          $('#customerCardName').html(event.data.customer);
					$('#currentBalance').html(event.data.currentBalance);
          $('#currentCashBalance').html(event.data.currentCashBalance);
					$('#currentBalance1').html(event.data.currentBalance);
          $('#currentCashBalance1').html(event.data.currentCashBalance);
					$('#currentBalance2').html(event.data.currentBalance);
          $('#currentCashBalance2').html(event.data.currentCashBalance);
          $('#currentBalance3').html(event.data.currentBalance);
          $('#currentCashBalance3').html(event.data.currentCashBalance);
          $('#currentBalance4').html(event.data.currentBalance);
        }
    });
});

$("#accounthome").click(function(){
  $("#changePin").css({"display":"none"});
  $('#withdrawals1').fadeOut(400);
  $("#withdrawals").removeClass('active');
  $('#deposit1').fadeOut(400);
  $("#deposit").removeClass('active');
  $('#transfer1').fadeOut(400);
  $("#transfer").removeClass('active');
  $('#savings1').fadeOut(400);
  $("#savings").removeClass('active');
  $('#options1').fadeOut(400);
  $("#options").removeClass('active');
  setTimeout(function(){
    $('#home').fadeIn(400);
  }, 500)
  $("#accounthome").addClass('active');
})

$("#withdrawals").click(function(){
  $("#changePin").css({"display":"none"});
  $('#home').fadeOut(400);
  $("#accounthome").removeClass('active');
  $('#deposit1').fadeOut(400);
  $("#deposit").removeClass('active');
  $('#transfer1').fadeOut(400);
  $("#transfer").removeClass('active');
  $('#savings1').fadeOut(400);
  $("#savings").removeClass('active');
  $('#options1').fadeOut(400);
  $("#options").removeClass('active');
  setTimeout(function(){
    $('#withdrawals1').fadeIn(400);
  }, 500)
  $("#withdrawals").addClass('active');
})

$("#deposit").click(function(){
  $("#changePin").css({"display":"none"});
  $('#home').fadeOut(400);
  $("#accounthome").removeClass('active');
  $('#withdrawals1').fadeOut(400);
  $("#withdrawals").removeClass('active');
  $('#transfer1').fadeOut(400);
  $("#transfer").removeClass('active');
  $('#savings1').fadeOut(400);
  $("#savings").removeClass('active');
  $('#options1').fadeOut(400);
  $("#options").removeClass('active');
  setTimeout(function(){
    $('#deposit1').fadeIn(400);
  }, 500)
  $("#deposit").addClass('active');
})

$("#transfer").click(function(){
  $("#changePin").css({"display":"none"});
  $('#home').fadeOut(400);
  $("#accounthome").removeClass('active');
  $('#withdrawals1').fadeOut(400);
  $("#withdrawals").removeClass('active');
  $('#deposit1').fadeOut(400);
  $("#deposit").removeClass('active');
  $('#savings1').fadeOut(400);
  $("#savings").removeClass('active');
  $('#options1').fadeOut(400);
  $("#options").removeClass('active');
  setTimeout(function(){
    $('#transfer1').fadeIn(400);
  }, 500)
  $("#transfer").addClass('active');
})

$("#savings").click(function(){
  $("#changePin").css({"display":"none"});
  $('#home').fadeOut(400);
  $("#accounthome").removeClass('active');
  $('#withdrawals1').fadeOut(400);
  $("#withdrawals").removeClass('active');
  $('#deposit1').fadeOut(400);
  $("#deposit").removeClass('active');
  $('#transfer1').fadeOut(400);
  $("#transfer").removeClass('active');
  $('#options1').fadeOut(400);
  $("#options").removeClass('active');
  setTimeout(function(){
    $('#savings1').fadeIn(400);
  }, 500)
  $("#savings").addClass('active');
})

$("#options").click(function(){
  $("#changePin").css({"display":"none"});
  $('#home').fadeOut(400);
  $("#accounthome").removeClass('active');
  $('#withdrawals1').fadeOut(400);
  $("#withdrawals").removeClass('active');
  $('#deposit1').fadeOut(400);
  $("#deposit").removeClass('active');
  $('#transfer1').fadeOut(400);
  $("#transfer").removeClass('active');
  $('#savings1').fadeOut(400);
  $("#savings").removeClass('active');
  setTimeout(function(){
    $('#options1').fadeIn(400);
  }, 500)
  $("#options").addClass('active');
})

$("#close").click(function(){
  $("#changePin").css({"display":"none"});
  $('#main').hide(100);
  $('#home').hide(100);
  $('#withdrawals1').hide(100);
  $('#deposit1').hide(100);
  $('#transfer1').hide(100);
  $('#savings1').hide(100);
  $('#options1').hide(100);
  $.post('https://FzD-Banking/NUIFocusOff', JSON.stringify({}));
})

$("#deposit100").click(function(){
  $.post('https://FzD-Banking/Deposit100', JSON.stringify({}));
})

$("#deposit1000").click(function(){
  $.post('https://FzD-Banking/Deposit1000', JSON.stringify({}));
})

$("#deposit10000").click(function(){
  $.post('https://FzD-Banking/Deposit10000', JSON.stringify({}));
})

$("#withdraw100").click(function(){
  $.post('https://FzD-Banking/Withdraw100', JSON.stringify({}));
})

$("#withdraw1000").click(function(){
  $.post('https://FzD-Banking/Withdraw1000', JSON.stringify({}));
})

$("#withdraw10000").click(function(){
  $.post('https://FzD-Banking/Withdraw10000', JSON.stringify({}));
})

$("#depositButton").click(function(){
  var amount = $('#depositAmount').val();

  if(amount !== undefined && amount > 0) {
    $.post('http://FzD-Banking/deposit', JSON.stringify({ 
      amount: parseInt(amount)
    }));
    $('#depositAmount').val('');
  }
})

$("#withdrawButton").click(function(){
  var amount = $('#withdrawAmount').val();

  if(amount !== undefined && amount > 0) {
    $.post('http://FzD-Banking/withdraw', JSON.stringify({ 
      amount: parseInt(amount)
    }));
    $('#withdrawAmount').val('');
  }
})

$("#createSavings").click(function(){
  $.post('https://FzD-Banking/createSavingsAccount', JSON.stringify({}));
})

$("#deleteSavings").click(function(){
  $.post('https://FzD-Banking/deleteSavingsAccount', JSON.stringify({}));
})

$("#savingsDepositButton").click(function(){
  var amount = $('#savingsDepositAmount').val();

  if(amount !== undefined && amount > 0) {
    $.post('http://FzD-Banking/savingsDeposit', JSON.stringify({ 
      amount: parseInt(amount)
    }));
    $('#savingsDepositAmount').val('');
  }
})

$("#savingsWithdrawButton").click(function(){
  var amount = $('#savingsWithdrawAmount').val();

  if(amount !== undefined && amount > 0) {
    $.post('http://FzD-Banking/savingsWithdraw', JSON.stringify({ 
      amount: parseInt(amount)
    }));
    $('#savingsWithdrawAmount').val('');
  }
})

$("#transferButton").click(function(){
  var identifier = $('#transferID').val();
  var amount = $('#transferAmount').val();

  if(identifier !== undefined && identifier > 0) {
    if(amount !== undefined && amount > 0) {
      $.post('http://FzD-Banking/transferMoney', JSON.stringify({ 
        identifier: parseInt(identifier),
        amount: parseInt(amount)
      }));
      $('#transferID').val('');
      $('#transferAmount').val('');
    }
  }
})

$("#orderNewCardButton").click(function(){
  $.post('http://FzD-Banking/orderNewCard', JSON.stringify({}));
})

$("#changePinButton").click(function(){
  $("#changePin").css({"display":"block"});
})

$("#comfirmChangePinButton").click(function(){
  var pin = $('#createPin').val();
  var pinlength = pin.length;

  if(pin !== undefined && pinlength == 4) {
    $.post('http://FzD-Banking/createPin', JSON.stringify({ 
      pin: pin
    }));
    $("#changePin").css({"display":"none"});
    $("#pinCreated").css({"display":"block"});
    $('#createPin').val('');
    setTimeout(function(){
      $('#pinCreated').fadeOut(1600);
    }, 1600)
  } else {
    $("#showError").css({"display":"block"});
  }
})


$("#cancelChangePinButton").click(function(){
  $("#changePin").css({"display":"none"});
})

document.onkeyup = function(data){
    if (data.which == 27){
        $('#main').hide(100);
        $('#home').hide(100);
        $('#withdrawals1').hide(100);
        $('#deposit1').hide(100);
        $('#transfer1').hide(100);
        $('#savings1').hide(100);
        $('#options1').hide(100);
        $.post('https://FzD-Banking/NUIFocusOff', JSON.stringify({}));
    }
}