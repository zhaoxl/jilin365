var data,
		myScroll,
		pullUpEl, pullUpOffset,
		generatedCount = 0;
var page = 2;

function pullUpAction () {
	$.ajax({
		url: next_page_url,
		dataType: "text",
		data: {page: page},
		success: function(data){
			$(list_content_path).append(data);
			myScroll.refresh();
		}
	});
	page += 1;
}

function loaded() {
	pullUpEl = document.getElementById('pullUp');	
	pullUpOffset = pullUpEl.offsetHeight;
	
	/**
	 * 初始化iScroll控件
	 */
	myScroll = new iScroll(wrapper_id, {
		vScrollbar : false,
		topOffset : 0,
		onRefresh : function () {
			if (pullUpEl.className.match('loading')) {
				pullUpEl.querySelector('.pullUpLabel').innerHTML = '上拉加载更多...';
			}
		},
		onScrollMove: function () {
			if (this.y < (this.maxScrollY - 5) && !pullUpEl.className.match('flip')) {
				pullUpEl.className = 'flip';
				pullUpEl.querySelector('.pullUpLabel').innerHTML = '<span class="iconfont">&#xe617;</span>松手开始更新...';
			}
		},
		onScrollEnd: function () {
			if (pullUpEl.className.match('flip')) {
				pullUpEl.className = 'loading';
				pullUpEl.querySelector('.pullUpLabel').innerHTML = '<span class="iconfont">&#xe616;</span>加载中...';				
				pullUpAction();
			}
		}
	});
}


//初始化绑定iScroll控件 
// document.addEventListener('touchmove', function (e) { e.preventDefault(); }, false);
// document.addEventListener('DOMContentLoaded', loaded, false);
