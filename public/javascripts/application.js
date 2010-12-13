
$(document).ready(function(){
    $("#login").overlay({
    	top: '10%',
    	left: '25%',
    	mask: {
    	    color: '#000',
    	    loadSpeed: 200,
    	    opacity: 0.9
    	},
    	closeOnClick: false,
	closeOnEsc: false,
    	load: true
    });

    $("dfn").hover(function(){
	$(this).addClass("highlight-dfn");
    }, function(){
	$(this).removeClass("highlight-dfn");
    });

    $('dfn').qtip({style: {
	name: 'blue', 
	tip: true	  
    }});

    // $(".aspect").hover(function() {
    // 	ab = $(this).children().first();
    // 	ab.replaceWith(ab[title]);
    // });

    // $(".modalDialog").overlay({
    // 	top:'1%',
    // 	mask:{
    //         color:'#000',
    //         loadSpeed: 200,
    //         opacity: 0.9
            
    // 	},
    // 	onBeforeLoad: function() {
    //         var wrap = this.getOverlay().find(".contentWrap");
    //         wrap.load(this.getTrigger().attr("href"));
    //         this.getOverlay().appendTo("body");

    // 	},
    // });

   
 
});
