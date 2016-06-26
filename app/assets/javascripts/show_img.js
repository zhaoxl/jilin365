//点击放大图片
(function($) {
	$.fn.showPlayerBigImg = function(arrimg) {
		function showBig(arrimg) {
			this.arrimg = arrimg
			this.win_w = $('body').width();
			this.win_h = $(window).height();
			this.index = 0
		};
		showBig.prototype.insertDome = function(index) {
			var _this = this
			var _ul_width = _this.win_w * _this.arrimg.length;
			var　 _html = '';
			//设置平移位置
			_this.defalueOffx = -_this.win_w * index
			_html += '<div class="big-img-box pf" id="big-img-box"><table class="big-img-table"  id="big-img-table" border="0" cellspacing="0" cellpadding="0"  width="' + _ul_width + 'px" style="-webkit-transition: 0s  linear; -webkit-transform:translate3d(' + _this.defalueOffx + 'px,0,0) "><tr>';
			for (var i = 0; i < _this.arrimg.length; i++) {
				if (i == index) {
					_html += '<td  style="width:' + _this.win_w + 'px;height:' + _this.win_h + 'px;overflow:hidden"><img src=' + _this.arrimg[i] + '  data-src=' + _this.arrimg[i] + '  class="show_img img-responsive"></td>';
				} else {
					_html += '<td  style="width:' + _this.win_w + 'px;height:' + _this.win_h + 'px;overflow:hidden"><img  data-src=' + _this.arrimg[i] + ' class="show_img img-responsive"></td>';
				}
			}
			_html += '</tr></table></div>';
			$('body').append(_html)
			_this.bigimgtable = $(document).find('#big-img-table');
			_this.dragTab(index)
//			_this.scaleBigImg(index) 
		};
		showBig.prototype.dragTab = function(index) {
			var _this = this;
			_this.index = index;
		
			touch.on('.show_img', 'drag', function(ev) {
				var dx = _this.defalueOffx;
				var _offx = dx + ev.x
				_this.bigimgtable.css({
					'-webkit-transition': '0s  linear',
					'-webkit-transform': 'translate3d(' + _offx + 'px,0,0)'
				})
			})
	
			touch.on('.show_img', 'dragend', function(ev) {
				if (Math.abs(ev.x) < 80) {
					_this.bigimgtable.css({
						'-webkit-transition': '0.5s  linear',
						'-webkit-transform': 'translate3d(' + _this.defalueOffx  + 'px,0,0)'
					})
					return
				}

				if (ev.x < 0) {
					_this.index++;
					_this.index = getIndex(_this.index)
				} else {
					_this.index--;
					_this.index = getIndex(_this.index)

				}
				var _end_offx = -_this.win_w * _this.index;
				_this.defalueOffx = _end_offx;
				var _nextshowimg = _this.bigimgtable.find('td').eq(_this.index).children('img')
				_nextshowimg.attr('src', _nextshowimg.attr('data-src'))
				_this.bigimgtable.css({
					'-webkit-transition': '0.5s  linear',
					'-webkit-transform': 'translate3d(' + _end_offx + 'px,0,0)'
				})
			})

			function getIndex(index) {
				if (index < 0) {
					index = 0
				} else if (index > _this.arrimg.length - 1) {
					index = _this.arrimg.length - 1;
				}
				return index
			}
		};

		showBig.prototype.scaleBigImg = function() {
			var _this = this;
			touch.on('.show_img', 'doubletap', function(ev) {
				var _x = -(ev.position.x - _this.win_w / 2),
					_y = -((ev.position.y - $(window).scrollTop()) - _this.win_h / 2);
				console.log('translate3d(-' + _x + 'px,-' + _y + 'px,0)')
				$(this).css({
					'-webkit-transition': '0.5s  linear',
					'-webkit-transform': 'scale(2,2) translate3d(' + _x + 'px,' + _y + 'px,0)'
				})
			})
		};

		var showbig = new showBig(arrimg);
		//点击显示点击的图片
		$(document).bind('tap', '.waterone', function() {
			var _index = $(this).attr('data-img-index')
			showbig.insertDome(_index)

		});
		//阻止默认行为
		$(document).bind('touchstart', '#big-img-box', function(e) {
			e.preventDefault();
		});
		touch.on('#big-img-box','touchstart',function(ev){
			ev.preventDefault();
		})
		//点击删除图片浏览
		$(document).bind('tap', '#big-img-box', function() {
			$(this).css({
				'-webkit-transition': '0.5s  linear',
				'transition': '0.5s  linear',
				'-webkit-opacity': '0',
				'opacity': '0'
			})
			$(this).on('webkitTransitionEnd', function() {
				$(this).remove()
			})
		});

	}
})(Zepto);