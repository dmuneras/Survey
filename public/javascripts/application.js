

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
