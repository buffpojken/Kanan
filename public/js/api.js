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
			$.ajax({
				url:'/stream', 
				type:'jsonp', 
				success: function(data){
					console.log(data);
				}, 
				error: function(){
					
				}
			});
		}, 
		_setup_element: function(){
			this.el.append($("<img>").attr({'style':'border:1px solid red; width:200px; height:150px;'}));
		}
	}
	$(function(){
		window.kanan_api = Object.create(api).initialize('#kanan-root');
	});
})(jQuery, window);