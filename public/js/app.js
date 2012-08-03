function setup(){     
	window.kana = {
		current_page: 1, 
		url: 'http://kanan.vassaro.net'
	}

	$(".load-more").click(function(e){     
		e.preventDefault();
		var _b = $(this);
		var _t = _b.parent();
		_t.addClass('loading');
		$.ajax({
			url:'/photos.html',           
			data: { page:window.kana.current_page }, 
			type:'get',
			headers: {'Accept':'text/html'},
			dataType:'html',
			success: function(html, resp, xhr){
				window.kana.current_page = xhr.getResponseHeader('X-More-Content')
				var html = $(html);
				$(".photo-list").append(html).find('.slide').each(function(i, el){
					new Swipe(el);
				});
				_t.removeClass('loading');                                        
				if(!window.kana.current_page){
					_b.css({display:'none'});
				}
			}, 
			error: function(){
				_t.removeClass('loading');
			}
		})  
	});             
	
	$(".share-on-tw").live('click', function(e){
		var data = $(e.currentTarget).parents('.image-item');
		 window.open('https://twitter.com/share?url='+window.kana.url+data.attr('data-photo-url')+"&hashtags=boomerang2012", "", "width=500,height=270");
	});
                        
	$(".share-on-g").live('click', function(e){
		var data = $(e.currentTarget).parents('.image-item');
		window.open('https://plusone.google.com/_/+1/confirm?hl=en&url='+window.kana.url+data.attr('data-photo-url'), "", "width=500,height=200");
	})

	$(".share-on-fb").live('click', function(e){
		var data = $(e.currentTarget).parents('.image-item');
		var obj = {
			method: 'feed',
			link: 'http://kanan.vassaro.net',
			picture: window.kana.url + data.attr('data-photo-url'),
			name: 'Vattenkana!',
			caption: 'Something funny...',
			description: 'Sol, bad, vatten och annat skoj...'
		};                                                
		FB.ui(obj);
	})

	window.mySwipe = new Swipe(
		document.getElementById('slider')
	);	
}


// Admin Structure
var commander = {
	initialize: function(opts){
		this.options 	= $.extend({autostart: true}, opts);
		if(this.options.autostart){
			this.timer		= setInterval(this.poll.bind(this), 2000);
		}                                     
		$(".pump-btn").bind('click', this.toggle_pump.bind(this));
		$(".light-btn a").bind('click', this.toggle_light.bind(this));
		return this;
	}, 
	poll: function(){
		$.ajax({
			url:'http://kanan.vassaro.net:4568', 
			dataType:'jsonp',         
			success: function(data){
				if(data.pump){
					$(".pump-status").html("På").removeClass('off').addClass('on');	 
					$(".pump-btn").html('Stäng Av');
				}else{
					$(".pump-status").html("Av").removeClass('on').addClass('off');					
					$(".pump-btn").html('Sätt På');
				}
				
			}, 
			error: function(){
				
			}
		});
	}, 
	toggle_pump: function(){
		$.ajax({
			url:'http://kanan.vassaro.net:4568/write', 
			dataType:'jsonp',   
			data: {pump: true},
			success: function(data){
				if(data.pump){
					$(".pump-status").html("På").removeClass('off').addClass('on');	 
					$(".pump-btn").html('Stäng Av');
				}else{
					$(".pump-status").html("Av").removeClass('on').addClass('off');					
					$(".pump-btn").html('Sätt På');
				}
				
			}, 
			error: function(){
				
			}
		});
	}, 
	toggle_light: function(e){    
		var color = $(e.currentTarget).attr('data-color');
		$.ajax({
			url:'http://kanan.vassaro.net:4568/light', 
			dataType:'jsonp',   
			data: {light: color},
			success: function(data){
				if(data.pump){
					$(".pump-status").html("På").removeClass('off').addClass('on');	 
					$(".pump-btn").html('Stäng Av');
				}else{
					$(".pump-status").html("Av").removeClass('on').addClass('off');					
					$(".pump-btn").html('Sätt På');
				}
				
			}, 
			error: function(){
				
			}
		});
	}
}

function admin(){
	window.admin_tool = Object.create(commander).initialize({});
}