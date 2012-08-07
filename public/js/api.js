if (typeof Object.create !== 'function') {
    Object.create = function (o) {
        function F() {}
        F.prototype = o;
        return new F();
    };
}

(function(q,w){
	var $ = q; 
	var api = {
		initialize: function(el){
			this.el = $(el);
			this._setup_element();
			var _t = this;
			setInterval(function(){
				_t.refresh.apply(_t);
			}, 5000);
		}, 
		refresh: function(){
			var _t = this;
			$.ajax({
			  url: 'http://kanan.vassaro.net/stream.js?callback=',
			  dataType: 'jsonp',
			  success: function(data){          
					_t.el.find('img').attr('src', data.image.url);					
				} 	
			});
		}, 
		_setup_element: function(){
			this.el.append($("<img>").attr({'style':'border:1px solid red; width:350px; height:263px;'}));
			this.el.find('img').bind('click', function(){
				window.open('http://kanan.vassaro.net');
			});
		}
	}
	$(function(){
		window.kanan_api = Object.create(api).initialize('#kanan-root');
	});
})(jQuery, window);