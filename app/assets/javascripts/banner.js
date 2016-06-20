(function($) {
	$.fn.slideBox = function(number) {
		function banner(number) {
			this.banner_ul = $('#banner-ul');
			this.banner_li = this.banner_ul.children('li')
			this.li_length = this.banner_ul.children('li').length || number;
			this.li_width = $(window).width() > 640 ? 640 : $(window).width();
			this.timer = '';
			this.banner_dian = $('#banner-dian');
			this.banner_dian_li = this.banner_dian.children('li');
			this.index = 0;
		};
		banner.prototype.init = function() {
			var _this = this;
			
				_this.banner_ul.prepend(_this.banner_li.eq(_this.li_length - 1));
				if (_this.li_length==2){
				      _this.banner_ul.append(_this.banner_li.eq(1).clone());
					_this.banner_ul.append(_this.banner_li.eq(0).clone());
			       }
			
			
			
			//设置远点位置
			_this.banner_dian.css({
				'margin-left': -_this.banner_dian.width() / 2 + 'px'
			});
			//设置bannerli的宽度
			_this.banner_ul.children('li').css({
				'width': _this.li_width + 'px'
			});
			if(_this.li_length<=1){
				return 
			}
			//设置初始化的translate3d 
			_this.banner_ul.css({
					'-webkit-transform': 'translate3d(-' + _this.li_width + 'px,0,0)',
					'transform': 'translate3d(-' + _this.li_width + 'px,0,0)'
				})
			
				
				//把最后一个插入的第一个
			
			//设置自动执行4000
			_this.timer = setInterval(function() {
				_this.slideBoxAction();
			}, 4000);
			//拖动执行切换
			_this.dragSlideBoxAction();
		};
		banner.prototype.slideBoxAction = function(direction) {
			var _this = this;
			var _direction = direction || -1;
			var _append_li, _offx
			if (_direction < 0) {
				_this.index++;
				var _append_li = $('#banner-ul').children('li').eq(0);
				_offx = -_this.li_width * 2;

			} else {
				_this.index--;
				var _append_li = $('#banner-ul').children('li').eq(this.li_length - 1);
				_offx = 0;
			}
			_this.banner_ul.css({
				'-webkit-transition': '0.5s  linear',
				'transition': '0.5s  linear',
				'-webkit-transform': 'translate3d(' + _offx + 'px,0,0)',
				'transform': 'translate3d(' + _offx + 'px,0,0)'
			})
			_this.banner_ul.on('webkitTransitionEnd', function() {
				if (_direction < 0) {
					$('#banner-ul').append(_append_li);
				} else {
					$('#banner-ul').prepend(_append_li);
				}
				_this.index = _this.getIndex(_this.index);

				_this.banner_dian_li.eq(_this.index).addClass('current').siblings('li').removeClass('current');
				_this.banner_ul.css({
					'-webkit-transition': '0s linear',
					'transition': '0s linear',
					'-webkit-transform': 'translate3d(-' + _this.li_width + 'px,0,0)',
					'transform': 'translate3d(-' + _this.li_width + 'px,0,0)'
				})
			})
		};
		//计算index
		banner.prototype.getIndex = function(index) {
			var _this = this;
			if (index < 0) {
				return _this.li_length - 1;
			} else if (index > (_this.li_length - 1)) {
				return 0;
			} else {
				return index;
			}
		};
		//drag切换
		banner.prototype.dragSlideBoxAction = function() {
			var _this = this;
			touch.on('#banner-ul', 'touchstart', function(ev) {
				ev.preventDefault();
				clearInterval(_this.timer)
			})
			var dx = -_this.li_width;
			var _direction = "";
			touch.on('#banner-ul', 'drag', function(ev) {
				var _offx = dx + ev.x + "px";
				_direction = ev.x;
				_this.banner_ul.css({
					'-webkit-transform': 'translate3d(' + _offx + ',0,0)',
					'transform': 'translate3d(' + _offx + ',0,0)'
				})
			})
			touch.on('#banner-ul', 'dragend', function(ev) {
				_this.slideBoxAction(_direction);
				_this.timer = setInterval(function() {
					_this.slideBoxAction();
				}, 4000);
			})
		}
		var banner = new banner();
		banner.init();
	};
})(Zepto);