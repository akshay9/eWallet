/**
 * Created by Akshay on 04-04-2017.
 */

$.fn.extend({
    animateCss: function (animationName, callback) {
        var animationEnd = 'webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend';
        this.addClass('animated ' + animationName).one(animationEnd, function() {
            $(this).removeClass('animated ' + animationName);
            if(typeof callback === "function")
                callback();
        });
    }
});
function countTo(element, value, start){
    $(element).prop('Counter',start).animate({
        Counter: value
    }, {
        duration: 1000,
        easing: 'swing',
        step: function (now) {
            $(element).text(now.toFixed(2));
        }
    });
}
$('.count').each(function () {
    countTo(this, $(this).text(), 0);
});

function createSuccess(strongText, msg) {
    return "<div class=\"alert alert-success alert-dismissible\" role=\"alert\">"
        + "<button type=\"button\" class=\"close\" data-dismiss=\"alert\">"
        + "<span aria-hidden=\"true\">&times;</span>"
        + "</button>"
        + "<strong>"+ strongText +"</strong> " + msg
        + "</div>";
}

function createAlert(strongText, msg) {
    return "<div class=\"alert alert-danger alert-dismissible\" role=\"alert\">"
        + "<button type=\"button\" class=\"close\" data-dismiss=\"alert\">"
        + "<span aria-hidden=\"true\">&times;</span>"
        + "</button>"
        + "<strong>"+ strongText +"</strong> " + msg
        + "</div>";
}

$("#startButton").click(function () {
    var content_block = $("#main_content");
    var login_block = $("#login_block");
    content_block.animateCss('fadeOutUp', function () {
        content_block.addClass("hidden");
        login_block.removeClass("hidden");
        login_block.animateCss("fadeIn");
    });
});

$("#loginButton").click(function (e) {
    e.preventDefault();

    var email = $("#email").val();
    var pass = $("#password").val();

    $.ajax({url: "login.jsp",
        data: {
            email: email,
            password: pass
        },
        type: "POST",
        success: function(result){
            if(result.response == "success"){
                $("#login_block").find(".response").html(createSuccess("Success!", "You successfully Logged in, redirecting you to your account."));

                setTimeout(function () {
                    window.location = "/account.jsp";
                }, 2000);
            } else {
                $("#password").val("");
                $("#login_block").find(".response").html(createAlert("Error!", result.message));
                $("#login_block").animateCss("shake quick-anim", null);
            }

            $("#login_block").find(".response").animateCss("fadeIn quick-anim", null);
    }});
});

$(".register-now").click(function (e) {
    e.preventDefault();
    $("#login_block").addClass("hidden");
    $("#register_block").removeClass("hidden");
    $("#register_block").animateCss("fadeIn quick-anim");
});

$("#registerButton").click(function (e) {
    e.preventDefault();

    var name = $("#name");
    var email = $("#newemail");
    var phone = $("#phone");
    var pass = $("#newpassword");
    var repeatpass = $("#repeatpassword");
    var responseElement = $("#register_block").find(".response");

    responseElement.html("");

    // Checks if the name is Alphabets only
    if(!new RegExp("^[a-zA-Z .]+$").test(name.val())) {
        responseElement.append(createAlert("Error!", "Enter a valid name. "));
    }

    var emailRegExp = (/^(([^<>()\[\]\.,;:\s@\"]+(\.[^<>()\[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i);

    if(!emailRegExp.test(email.val())){
        responseElement.append(createAlert("Error!", "Enter a valid email. "));
    }

    /// should be an indian 10 digit mobile number.
    if(!new RegExp("^((\\+91)|(0)){0,1}[0-9]{10}$").test(phone.val())){
        responseElement.append(createAlert("Error!", "Enter a valid phone number. "));
    }

    // password min length 6
    if(pass.val().length < 6) {
        responseElement.append(createAlert("Error!", "Passwords should be of at least length of 6 characters."));
    }

    // Check if both the entered password are same.
    if(repeatpass.val() !== pass.val()) {
        responseElement.append(createAlert("Error!", "Passwords do not Match"));
    }

    if(responseElement.html() !== ""){
        $("#register_block").animateCss("shake quick-anim", null);
        responseElement.animateCss("fadeIn quick-anim", null);
        return;
    }


    $.ajax({url: "register.jsp",
        data: {
            name: name.val(),
            email: email.val(),
            phone: phone.val(),
            password: pass.val()
        },
        type: "POST",
        success: function(result){
            if(result.response == "success"){
                responseElement.html(createSuccess("Success!", "You successfully registered, redirecting you to your account."));

                setTimeout(function () {
                    window.location = "/account.jsp";
                }, 2000);
            } else {
                $("#password").val("");
                responseElement.html(createAlert("Error!", result.message));
                $("#register_block").animateCss("shake quick-anim", null);
            }

            responseElement.animateCss("fadeIn quick-anim", null);
    }});
});

$("#phone2").on('input', function () {
    if(new RegExp("^((\\+91)|(0)){0,1}[0-9]{10}$").test($(this).val())){
        $.ajax({url: "ajax.jsp",
            data: {
                type: "getNameFromPhone",
                phone: $(this).val()
            },
            type: "POST",
            success: function(result){
                if(result.response === "success"){
                    $("#toPerson").text(result.value);
                }
        }});
    } else {
        $("#toPerson").text("");
    }
});

$(".sendMoney").click( function (e) {
    e.preventDefault();

    var responseElement = $("#quickTransfer").find(".response");
    responseElement.html("");

    $.ajax({url: "ajax.jsp",
        data: {
            type: "getBalance"
        },
        type: "POST",
        success: function(result){
            if(result.response === "success"){
                var balance = result.value;
                if(balance < $("#amount").val()){
                    responseElement.append(createAlert("Error!", "Insufficient Balance in Wallet."));
                }

                if($("#amount").val() <= 0){
                    responseElement.append(createAlert("Error!", "Amount should be greater than 0."));
                }

                if ($("#toPerson").text() == ""){
                    responseElement.append(createAlert("Error!", "Invalid \"To\" number."));
                }

                if ($("#comment").val().length > 32){
                    responseElement.append(createAlert("Error!", "Comment can be of max 32 characters."));
                }

                if(responseElement.html() !== ""){
                    responseElement.animateCss("fadeIn quick-anim", null);
                    return;
                }

                if(confirm("Continue Transfer Money?\nRemaining Balance: ₹ " + (balance - $("#amount").val()).toFixed(2))){
                    $.ajax({url: "ajax.jsp",
                        data: {
                            type: "sendMoney",
                            to: $("#phone2").val(),
                            amount: $("#amount").val(),
                            comment: $("#comment").val()
                        },
                        type: "POST",
                        success: function(result){
                            if(result.response === "success"){
                                responseElement.append(createSuccess("Success!", result.value));
                                countTo($("#accBalance"), balance - $("#amount").val(), $("#accBalance").text());
                            } else {
                                responseElement.append(createAlert("Error!", "Something went wrong!"));
                            }
                        },
                        error: function () {
                            responseElement.append(createAlert("Error!", "Something went wrong!"));
                        }
                    });
                }

            }
        }});
});

// $("#ccno").on( "focusout", function () {
//     if($(this).val().length !== 16  && $(this).val().length > 0){
//         $(this).val("41111111111111111111");
//     }
// });


$("#expiry").on( "focusout", function () {
    if(($(this).val() > 12 || $(this).val() < 1) && $(this).val().length > 0){
        $(this).val("12");
    }
});

$("#expiry2").on( "focusout", function () {
    if(($(this).val() > 2025 || $(this).val() < 2017) && $(this).val().length > 0){
        $(this).val("2025");
    }
});

$("#cvv").on( "focusout", function () {
    if(($(this).val() > 999 || $(this).val() < 100) && $(this).val().length > 0){
        $(this).val("555");
    }
});

$(".addMoney").click( function (e) {
    e.preventDefault();

    var responseElement = $("#quickTransfer").find(".response");
    responseElement.html("");

    if($("#amount").val() <= 0){
        responseElement.append(createAlert("Error!", "Amount should be greater than 0."));
    }


    if(responseElement.html() !== ""){
        responseElement.animateCss("fadeIn quick-anim", null);
        return;
    }

    $.ajax({url: "ajax.jsp",
        data: {
            type: "addMoney",
            amount: $("#amount").val()
        },
        type: "POST",
        success: function(result){
            if(result.response === "success"){
                responseElement.append(createSuccess("Success!", result.value));
                var accBalance = $("#accBalance");
                countTo(accBalance, Number(accBalance.text()) + Number($("#amount").val()), Number(accBalance.text()));
            } else {
                responseElement.append(createAlert("Error!", result.value));
            }
        },
        error: function () {
            responseElement.append(createAlert("Error!", "Something went wrong!"));
        }
    });
});

$(".change-access a").click(function (e) {
    e.preventDefault();

    var clickedElement = $(this);

    var responseElement = $(".floating-alert-holder");
    var element;

    var url = $(this).attr("href");

    $.ajax({url: url,
        type: "POST",
        success: function(result){
            if(result.response === "success"){
                element = $(createSuccess("Success!", result.value));
                responseElement.append(element);
            } else {
                element = createAlert("Error!", result.value);
                responseElement.append(element);
            }
            element.animateCss("fadeInRight quick-anim-2x");

            var accessTd = clickedElement.parent().parent().parent().prev();
            accessTd.removeClass("user banned moderator admin");
            if(clickedElement.text().toLowerCase() !== "ban") {
                accessTd.addClass(clickedElement.text().toLowerCase());
                accessTd.text(clickedElement.text());
            } else {
                accessTd.addClass("banned");
                accessTd.text("Banned");
            }

            setTimeout(function () {
                element.animateCss("flipOutX quick-anim", function () {
                    element.remove();
                });
            }, 1500);
        },
        error: function () {
            element = createAlert("Error!", "Something went wrong!");
            responseElement.append(element);
            element.animateCss("fadeInRight quick-anim-2x");

            setTimeout(function () {
                element.animateCss("flipOutX quick-anim", function () {
                    element.remove();
                });
            }, 1500);
        }
    });
});
$(".reverseTxn").click(function (e) {
    e.preventDefault();

    var clickedElement = $(this);
    if(clickedElement.hasClass("hidden"))
        return;

    var responseElement = $(".floating-alert-holder");
    var element;

    var url = $(this).attr("href");

    $.ajax({url: url,
        type: "POST",
        success: function(result){
            if(result.response === "success"){
                element = $(createSuccess("Success!", result.value));
                responseElement.append(element);
            } else {
                element = createAlert("Error!", result.value);
                responseElement.append(element);
            }
            element.animateCss("fadeInRight quick-anim-2x");

            clickedElement.text("Reversed");
            clickedElement.addClass("disabled");

            setTimeout(function () {
                element.animateCss("flipOutX quick-anim", function () {
                    element.remove();
                });
            }, 1500);
        },
        error: function () {
            element = createAlert("Error!", "Something went wrong!");
            responseElement.append(element);
            element.animateCss("fadeInRight quick-anim-2x");

            setTimeout(function () {
                element.animateCss("flipOutX quick-anim", function () {
                    element.remove();
                });
            }, 1500);
        }
    });
});