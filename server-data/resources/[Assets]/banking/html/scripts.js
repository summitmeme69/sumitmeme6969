// Credit to Kanersps @ llrp-mode and Eraknelo @FiveM
function addGaps(nStr) {
    nStr += '';
    var x = nStr.split('.');
    var x1 = x[0];
    var x2 = x.length > 1 ? '.' + x[1] : '';
    var rgx = /(\d+)(\d{3})/;
    while (rgx.test(x1)) {
        x1 = x1.replace(rgx, '$1' + '<span style="margin-left: 3px; margin-right: 3px;"/>' + '$2');
    }
    return x1 + x2;
}

function addCommas(nStr) {
    nStr += '';
    var x = nStr.split('.');
    var x1 = x[0];
    var x2 = x.length > 1 ? '.' + x[1] : '';
    var rgx = /(\d+)(\d{3})/;
    while (rgx.test(x1)) {
        x1 = x1.replace(rgx, '$1' + ',<span style="margin-left: 0px; margin-right: 1px;"/>' + '$2');
    }
    return x1 + x2;
}

$(document).ready(function() {
    // Mouse Controls
    var documentWidth = document.documentElement.clientWidth;
    var documentHeight = document.documentElement.clientHeight;

    // Partial Functions
    function closeMain() {
        $(".home").css("display", "none");
    }

    function openMain() {
        $(".home").css("display", "block");
    }

    function closeAll() {
        $(".body").css("display", "none");
    }

    function openBalance() {
        $(".balance-container").css("display", "block");
    }

    function openWithdraw() {
        $(".withdraw-container").css("display", "block");
    }

    function openDeposit() {
        $(".deposit-container").css("display", "block");
    }

    function openTransfer() {
        $(".transfer-container").css("display", "block");
    }

    function openContainer() {
        removeblur()
        $("#loadingimage").fadeIn()

        $(".loading").slideDown('slow')
        setTimeout(function() {
            $("#loadingimage").fadeOut()
            $(".loading").slideUp(500)
            setTimeout(function() {
                $(".bank-container").slideDown("slow")
                $(".accountstext").fadeIn(2000)
                $("#waitdawg").fadeIn(2000)
                $(".transactionhistory").fadeIn(2000)           
            }, 1000);

        }, 800);

    }

    function closeContainer() {
        $(".transactionhistory").fadeOut(100)
        $(".bank-container").slideUp("slow")
        $(".accountstext").fadeOut(100)
        $(".idk").css("display", "none")
    }
    $("#withdrawbussiness").click(function() {
        $('.idk5').slideDown('slow')
        addblur()
        resetvalues()
    })
    $("#depositbussiness").click(function() {
        $('.idk4').slideDown('slow')
        addblur()
        resetvalues()
    })


    // Listen for NUI Events
    window.addEventListener('message', function(event) {
        var item = event.data;
        // Update HUD Balance
        if (item.updateBalance == true) {
            $('.balance').hide();
            if (item.show != false) {
                $('.balance').show();
            }
            $('.balance').html('<p id="balance"><img id="icon" src="bank-icon.png" alt=""/>' + addGaps(event.data.balance) + '</p>');
            $('.currentBalance').html('$' + event.data.balance);
            $('.username').html(event.data.name);
            $('.titlewithdraw').html(event.data.name + " /\n" + "1231");



            if (item.show != false) {
                setTimeout(function() {
                    $('.balance').fadeOut(600)
                }, 4000)
            }
        }
        if (item.updateName == true) {
            $('.username').html(event.data.name);
        }
        if (item.viewBalance == true) {
            $('.balance').show();
            $('.cash').show();
            setTimeout(function() {
                $('.balance').fadeOut(600)
                $('.cash').fadeOut(600)
            }, 8000)
        }
        if (item.viewCash == true) {
            $('.balance').show();
            $('.cash').show();
            setTimeout(function() {
                $('.balance').fadeOut(600)
                $('.cash').fadeOut(600)
            }, 8000)
        }
        if (item.updateCash == true) {
            $(".cashrightnow").html("Cash: $" + item.cash)

            $('.cash').hide();
            if (item.show != false) {
                $('.cash').show();
            }
            $('.cash').html('<p id="cash"><span class="green"> $ </span>' + addGaps(event.data.cash) + '</p>');
            if (item.show != false) {
                setTimeout(function() {
                    $('.cash').fadeOut(600)
                }, 4000)
            }
        }

        // Trigger Add Balance Popup
        if (item.addBalance == true) {
            $('.transaction').show();
            var element = $('<p id="add-balance"><span class="pre">+</span><span class="green"> $ </span>' + addGaps(event.data.amount) + '</p>');
            $(".transaction").append(element);

            setTimeout(function() {
                $(element).fadeOut(600, function() { $(this).remove(); })
            }, 2000)
        }
        //Trigger Remove Balance Popup
        if (item.removeBalance == true) {
            $('.transaction').show();
            var element = $('<p id="add-balance"><span class="pre">-</span><span class="red"> $ </span>' + addGaps(event.data.amount) + '</p>');
            $(".transaction").append(element);
            setTimeout(function() {
                $(element).fadeOut(600, function() { $(this).remove(); })
            }, 2000)
        }
        // Trigger Add Balance Popup
        if (item.addCash == true) {
            $('.cashtransaction').show();
            var element = $('<p id="add-balance"><span class="pre">+</span><span class="green"> $ </span>' + addGaps(event.data.amount) + '</p>');
            $(".cashtransaction").append(element);

            setTimeout(function() {
                $(element).fadeOut(600, function() { $(this).remove(); })
            }, 2000)
        }
        //Trigger Remove Balance Popup
        if (item.removeCash == true) {
            $('.cashtransaction').show();
            var element = $('<p id="add-balance"><span class="pre">-</span><span class="red"> $ </span>' + addGaps(event.data.amount) + '</p>');
            $(".cashtransaction").append(element);
            setTimeout(function() {
                $(element).fadeOut(600, function() { $(this).remove(); })
            }, 2000)
        }
        // Open & Close main bank window
        if (item.openBank == true) {
            openContainer();
            $("#cashdownonscreen").html(item.cash + "$")
            if (item.atm == true) {
                $("#DEPOSIT").hide()
                $("#depositbussiness").hide()
            } else {
                $("#DEPOSIT").show()
                $("#depositbussiness").show()
            }
            openMain();
        }
        if (item.openBank == false) {
            closeContainer();
            closeMain();
        }
        // Open sub-windows / partials
        if (item.openSection == "balance") {
            closeAll();
            openBalance();
        }
        if (item.openSection == "withdraw") {
            closeAll();
            openWithdraw();
        }
        if (item.openSection == "deposit") {
            closeAll();
            openDeposit();
        }
        if (item.openSection == "transfer") {
            closeAll();
            openTransfer();
        }
        if (item.updatelogs == 'yes') {
            for (i = 0; i < event.data.logs.length; i++) {
                var logs = event.data.logs[i];
                if (logs.withdraw == 0) {
                    if (logs.business == 0) {
                        addlog(logs.amount, logs.reason, true, false)
                    } else {
                        addlog(logs.amount, logs.reason, true, true)

                    }
                } else if (logs.withdraw == 1) {
                    if (logs.business == 0) {
                        addlog(logs.amount, logs.reason, false, false)
                    } else {
                        addlog(logs.amount, logs.reason, false, true)
                    }

                }
            }
        }
        if (item.bankAccountNumber == true) {
            var number = item.bank
            $("#accountnumber").text(`Personal Account / ${number}`)
            var street = item.street
            $("#bankname").html('<i class="fas fa-university" ></i>' + street)
        }

        if (item.bussiness == true) {
            $(".bussinessbox").fadeIn(2000)
            $(".Bussiness").text("Business  Account: " + item.jobname)
        }
        if (item.getBussinessCashBal == true) {
            $(".currentcash").text("$" + item.cash)
        }
    });

    function addlog(amount, message, withdraw, bussiness) {
        if (amount == "" || amount == null) {
            return
        }
        if (message == '' || message == null) {
            message = 'Non reason specificed'
        }
        if (withdraw) {
            if (bussiness) {
                $(".transactionhistory").prepend(`<div class="box"><br><a class="textabc" style="font-size: 18px;">Business Account</a><hr style="width: 900px;margin-left: 17px;height: 0px;background-color:rgba(198,198,198,1.0);margin-top: 8px;"><div class="text" style="margin-left: 18px;margin-top: 2px;font-size: 35px;color:#e8a97d;">` + `-` + `$` + amount + `</div><div class="text" style="margin-left: 20px;margin-top:50px;font-size: 15px;margin-bottom: 5px;color: rgba(198,198,198,0.5);;">Message</div><a class="textabc" style="font-size: 18px;margin-left: 20px;color: rgba(198,198,198,0.5);;">` + message + `</a><hr style="width: 900px;margin-left: 19px;height: 0px;border: none;border-top: 1px dotted  rgba(198,198,198,0.5);margin-top: 3px;height: -1px;"></div><br>`)
            } else {
                $(".transactionhistory").prepend(`<div class="box" style="padding:5px;"><br><a class="textabc" style="font-size: 18px;">Personal Account</a><hr style="width: 900px;margin-left: 17px;height: 0px;background-color:rgba(198,198,198,1.0);margin-top: 8px;"><div class="text" style="margin-left: 18px;margin-top: 2px;font-size: 35px;color:#e8a97d;">` + `-` + `$` + amount + `</div><div class="text" style="margin-left: 20px;margin-top:50px;font-size: 15px;margin-bottom: 5px;color: rgba(198,198,198,0.5);;">Message</div><a class="textabc" style="font-size: 18px;margin-left: 20px;color: rgba(198,198,198,0.5);;">` + message + `</a><hr style="width: 900px;margin-left: 19px;height: 0px;border: none;border-top: 1px dotted  rgba(198,198,198,0.5);margin-top: 3px;height: -1px;"></div><br>`)
            }
        } else {
            if (bussiness) {
                $(".transactionhistory").prepend(`<div class="box" style="padding:5px;"><br><a class="textabc" style="font-size: 18px;">Business Account</a><hr style="width: 900px;margin-left: 17px;height: 0px;background-color:rgba(198,198,198,1.0);margin-top: 8px;"><div class="text" style="margin-left: 18px;margin-top: 2px;font-size: 35px;color:#79a66a">` + `$` + amount + `</div><div class="text" style="margin-left: 20px;margin-top:50px;font-size: 15px;margin-bottom: 5px;color: rgba(198,198,198,0.5);;">Message</div><a class="textabc" style="font-size: 18px;margin-left: 20px;color: rgba(198,198,198,0.5);;">` + message + `</a><hr style="width: 900px;margin-left: 19px;height: 0px;border: none;border-top: 1px dotted  rgba(198,198,198,0.5);margin-top: 3px;height: -1px;"></div><br>`)
            } else {
                $(".transactionhistory").prepend(`<div class="box" style="padding:5px;"><br><a class="textabc" style="font-size: 18px;">Personal Account</a><hr style="width: 900px;margin-left: 17px;height: 0px;background-color:rgba(198,198,198,1.0);margin-top: 8px;"><div class="text" style="margin-left: 18px;margin-top: 2px;font-size: 35px;color:#79a66a">` + `$` + amount + `</div><div class="text" style="margin-left: 20px;margin-top:50px;font-size: 15px;margin-bottom: 5px;color: rgba(198,198,198,0.5);;">Message</div><a class="textabc" style="font-size: 18px;margin-left: 20px;color: rgba(198,198,198,0.5);;">` + message + `</a><hr style="width: 900px;margin-left: 19px;height: 0px;border: none;border-top: 1px dotted  rgba(198,198,198,0.5);margin-top: 3px;height: -1px;"></div><br>`)
            }
        }
    }

    function removeblur() {
        $(".personalbox").css("-webkit-filter", "blur(0px)");
        $(".accountstext").css("-webkit-filter", "blur(0px)");
        $(".transactionhistory").css("-webkit-filter", "blur(0px)");
        $(".bussinessbox").css("-webkit-filter", "blur(0px)");
    }

    // On 'Esc' call close method
    document.onkeyup = function(data) {
        if (data.which == 27) {
            $.post('http://banking/close', JSON.stringify({}));
        }
    };
    // Handle Button Presses
    $(".btnWithdraw").click(function() {
        $.post('http://banking/withdraw', JSON.stringify({}));
    });

    function resetvalues() {
        $('#amountwithdraw').val("")
        $("#commentforwithdraw").val("")
        $("#playerid").val("")
        $("#amounttransfer").val("")
        $("#commentfortransfer").val("")
        $("#amountdeposit").val("");
        $("#commentfordeposit").val("")
        $("#bussinesscommentdeposit").val("")
        $("#bussinessdeposit").val("")
        $("#bussinessWithdraw").val("")
        $("#bussinesscommentWithdraw").val("")
    }

    function addblur() {
        $(".personalbox").css("-webkit-filter", "blur(14px)");
        $(".accountstext").css("-webkit-filter", "blur(14px)");
        $(".bussinessbox").css("-webkit-filter", "blur(14px)");
        $(".transactionhistory").css("-webkit-filter", "blur(14px)");

    }

    $("#WITHDRAW").click(function() {
        $('.idk').slideDown("slow")
        addblur()
        resetvalues()
    })
    $("#TRANSFER").click(function() {
        $(".idk3").slideDown("slow")
        addblur()
        resetvalues()
    })
    $("#DEPOSIT").click(function() {
        $('.idk2').slideDown("slow")
        addblur()
        resetvalues()

    })


    $("#Withdraw").click(function() {
        var amount = $("#amountwithdraw").val();
        var comment = $("#commentforwithdraw").val();
        removeblur()
        $('.idk').slideUp("slow")
        if (amount == "" || amount == null) {
            return
        }
        $.post('http://banking/withdrawSubmit', JSON.stringify({ amount: amount, reason: comment }));
        addlog(amount, comment, true)

    })
    $("#Transfer").click(function() {
        var playerid = $("#playerid").val();
        var amount = $("#amounttransfer").val();
        var comment = $("#commentfortransfer").val();
        removeblur()
        $('.idk3').slideUp("slow")
        if (amount == "" || amount == null) {
            return
        }
        $.post('http://banking/transferSubmit', JSON.stringify({ toPlayer: playerid, amount: amount, reason: comment }));
        addlog(amount, comment, true)

    })
    $("#cancel3").click(function() {
        removeblur()
        $('.idk3').slideUp("slow")
        resetvalues()

    })

    $("#Deposit").click(function() {
        var amount = $("#amountdeposit").val();
        var comment = $("#commentfordeposit").val();
        removeblur()
        $('.idk2').slideUp("slow")
        if (amount == "" || amount == null) {
            return
        }
        $.post('http://banking/depositSubmit', JSON.stringify({ amount: amount, reason: comment }));
        addlog(amount, comment, false)

    })
    $("#cancel").click(function() {
        removeblur()
        $('.idk').slideUp("slow")
        resetvalues()


    })
    $("#cancel2").click(function() {
        removeblur()
        $('.idk2').slideUp("slow")
        resetvalues()

    })
    $("#cancel4").click(function() {
        removeblur()
        $('.idk4').slideUp("slow")
        resetvalues()

    })

    $("#cancel5").click(function() {
            removeblur()
            $('.idk5').slideUp("slow")
            resetvalues()

        })
        // BUSSINESS PART
    $("#bussinessdepositaccept").click(function() {
        var amount = $("#bussinessdeposit").val();
        var comment = $("#bussinesscommentdeposit").val();
        removeblur()
        $('.idk4').slideUp("slow")
        if (amount == "" || amount == null) {
            return
        }
        $.post('http://banking/depositBussinessSubmit', JSON.stringify({ amount: amount, reason: comment }));
        addlog(amount, comment, false, true)

    })
    $("#bussinessWithdrawaccept").click(function() {
        var amount = $("#bussinessWithdraw").val();
        var comment = $("#bussinesscommentWithdraw").val();
        removeblur()
        $('.idk5').slideUp("slow")
        if (amount == "" || amount == null) {
            return
        }
        $.post('http://banking/withdrawBussinessSubmit', JSON.stringify({ amount: amount, reason: comment }));
        addlog(amount, comment, true, true)

    })


    //////////////////////////

});