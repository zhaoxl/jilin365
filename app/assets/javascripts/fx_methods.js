//     Zepto.js
//     (c) 2010-2016 Thomas Fuchs
//     Zepto.js may be freely distributed under the MIT license.

;(function($, undefined){
  var document = window.document, docElem = document.documentElement,
    origShow = $.fn.show, origHide = $.fn.hide, origToggle = $.fn.toggle

  function anim(el, speed, opacity, scale, callback) {
    if (typeof speed == 'function' && !callback) callback = speed, speed = undefined
    var props = { opacity: opacity }
    if (scale) {
      props.scale = scale
      el.css($.fx.cssPrefix + 'transform-origin', '0 0')
    }
    return el.animate(props, speed, null, callback)
  }

  function hide(el, speed, scale, callback) {
    return anim(el, speed, 0, scale, function(){
      origHide.call($(this))
      callback && callback.call(this)
    })
  }

  $.fn.show = function(speed, callback) {
    origShow.call(this)
    if (speed === undefined) speed = 0
    else this.css('opacity', 0)
    return anim(this, speed, 1, '1,1', callback)
  }

  $.fn.hide = function(speed, callback) {
    if (speed === undefined) return origHide.call(this)
    else return hide(this, speed, '0,0', callback)
  }

  $.fn.toggle = function(speed, callback) {
    if (speed === undefined || typeof speed == 'boolean')
      return origToggle.call(this, speed)
    else return this.each(function(){
      var el = $(this)
      el[el.css('display') == 'none' ? 'show' : 'hide'](speed, callback)
    })
  }

  $.fn.fadeTo = function(speed, opacity, callback) {
    return anim(this, speed, opacity, null, callback)
  }

  $.fn.fadeIn = function(speed, callback) {
    var target = this.css('opacity')
    if (target > 0) this.css('opacity', 0)
    else target = 1
    return origShow.call(this).fadeTo(speed, target, callback)
  }

  $.fn.fadeOut = function(speed, callback) {
    return hide(this, speed, null, callback)
  }

  $.fn.fadeToggle = function(speed, callback) {
    return this.each(function(){
      var el = $(this)
      el[
        (el.css('opacity') == 0 || el.css('display') == 'none') ? 'fadeIn' : 'fadeOut'
      ](speed, callback)
    })
  }
	
	$.fn.scrollTo =function(options){
	  var defaults = {
	      toT : 0,    //滚动目标位置
	      durTime : 500,  //过渡动画时间
	      delay : 30,     //定时器时间
	      callback:null   //回调函数
	  };
	  var opts = $.extend(defaults,options),
	      timer = null,
	      _this = this,
	      curTop = _this.scrollTop(),//滚动条当前的位置
	      subTop = opts.toT - curTop,    //滚动条目标位置和当前位置的差值
	      index = 0,
	      dur = Math.round(opts.durTime / opts.delay),
	      smoothScroll = function(t){
	          index++;
	          var per = Math.round(subTop/dur);
	          if(index >= dur){
	              _this.scrollTop(t);
	              window.clearInterval(timer);
	              if(opts.callback && typeof opts.callback == 'function'){
	                  opts.callback();
	              }
	              return;
	          }else{
	              _this.scrollTop(curTop + index*per);
	          }
	      };
	  timer = window.setInterval(function(){
	      smoothScroll(opts.toT);
	  }, opts.delay);
	  return _this;
	};

})(Zepto)
