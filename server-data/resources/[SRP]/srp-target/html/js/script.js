window.addEventListener('message', function(event) {
    let item = event.data;

    if (item.response == 'openTarget') {
        $(".target-label").html("");

        $('.target-wrapper').show();

        $(".target-eye").css("color", "black");
    } else if (item.response == 'closeTarget') {
        $(".target-label").html("");

        $('.target-wrapper').hide();
    } else if (item.response == 'validTarget') {
        $(".target-label").html("");

        $.each(item.data, function (index, item) {
            $(".target-label").append("<div id='target-"+index +"'<li><span class='target-icon'><i class='"+item.icon+"'></i></span>&nbsp"+item.label+"</li></div>");
            $("#target-"+index).hover((e)=> {
                $("#target-"+index).css("color",e.type === "mouseenter" ?"#12a1e6":"white")
            })

            $("#target-"+index+"").css("padding-top", "7px");

            $("#target-"+index).data('TargetData', item.event);

            $("#target-"+index).data('ParmsData', item.parms);
        });

        $("#eye1").show()
        $("#eye2").hide()

    } else if (item.response == 'leftTarget') {
        $(".target-label").html("");
        $("#eye2").show()
        $("#eye1").hide()
    }
});

$(document).on('mousedown', (event) => {
    let element = event.target;

    if (element.id.split("-")[0] === 'target') {
        let TargetData = $("#" + element.id).data('TargetData');
        let ParmsData = $("#" + element.id).data('ParmsData');
        $.post('http://srp-target/selectTarget', JSON.stringify({
            event: TargetData,
            parms: ParmsData,
        }));

        $(".target-label").html("");
        $('.target-wrapper').hide();
    }
});

$(document).on('keydown', function() {
    switch (event.keyCode) {
        case 27: // ESC
            $(".target-label").html("");
            $('.target-wrapper').hide();
            $.post('http://srp-target/closeTarget');
            break;
    }
});