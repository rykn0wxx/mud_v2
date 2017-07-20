(function(root, factory) {

  'use strict';
  if (typeof define === 'function' && define.amd) {
		define(['jquery', 'exports'], function ($, exports) {
			root.rykn0wxx = factory(root, exports, $);
		});
	} else
  if (typeof exports !== 'undefined') {
		var jQuery = window.jQuery;
		if (jQuery === undefined) {
			try {
				jQuery = require('jquery');
			} catch (err) {
				if (!jQuery) throw new Error('jQuery dependency not found');
			}
		}
		factory(root, exports, jQuery);
	} else {
		root.rykn0wxx = factory(root, {}, (root.jQuery || root.Zepto || root.ender || root.$));
	}

}(this, function (root, rykn0wxx, $) {

  'use strict';

  var AppAdmin = function (el, opts) {
    this.$element = $(el);
    this.options = $.extend({}, AppAdmin.DEFAULTS, opts);
    this.isLoading = false;
    this.segmenter = null;
    this.dataCalls = ['data-plugin', 'data-side'];
    return this;
  };

  AppAdmin.DEFAULTS = {
    loadingText: 'loading...',
    animationSpeed: 500,
    enableBSToppltip: true,
    BSTooltipSelector: '[data-toggle="tooltip"]'
  };

  AppAdmin.prototype.clearModal = function () {
    var frmId = $('#modal_form').parent('form').attr('id');
    var mdlFrm = document.getElementById(frmId);
    var mdl = document.getElementById('modal_form');
    setTimeout(function () {
      mdl.parentNode.removeChild(mdl);
      mdlFrm.parentNode.removeChild(mdlFrm);
    }, 1);
  };

  var _helpers = {

  };

  var AddOn = {
    base: function () {
    },
    metismenu: function (el) {
      if ($.fn.metisMenu) {
        $(el).metisMenu();
      } else {
        throw new Error('First install metisMenu plugin!');
      }
    },
    totop: function (el) {
      var scrollParent = $(el).parent();
      var isScrolling = false;
      updateState();
      scrollParent.on('scroll', updateState);

      function updateState () {
        var newState = scrollParent[0].scrollTop !== 0;
        if (newState !== isScrolling) {
          $(el).toggleClass('scrolling', newState);
          if (newState) {
            $(el).on('click', topClicker);
            $(el).fadeIn(function() {
              $(el).css('transform','scale(1)');
            });
          } else {
            $(el).off('click', topClicker);
            $(el).fadeOut(function () {
              $(el).css('transform','scale(0)');
            });
          }
        }
        isScrolling = newState;
      }
      function topClicker (ev) {
        var _body = $('body');
        _body.hasClass('page-fixed') ? _body.hasClass('main-fixed') ? $('.main-content').animate({scrollTop: 0},600) :$('.app-main').animate({scrollTop: 0},600) : $('body, html').animate({scrollTop: 0},600);
      }
    }
  };

  function Plugin(option) {
		return this.each(function () {
			var $this = $(this);
			var data = $this.data('rykn0wxx');
			var options = typeof option === 'object' && option;
			if (!data) {
        $this.data('rykn0wxx', (data = new AppAdmin(this, options)))
      }
      data.dataCalls.forEach(function (val, ind) {
        $('[' + val + ']').each(function () {
          if (AddOn[$(this).attr(val)]) {
            AddOn[$(this).attr(val)](this);
          }
        });
      });
      AddOn.base();
		});
	}

  var old = $.fn.rykn0wxx;
	$.fn.rykn0wxx = Plugin;
	$.fn.rykn0wxx.Constructor = AppAdmin;
	$.fn.rykn0wxx.noConflict = function () {
		$.fn.rykn0wxx = old;
		return this;
	};

  $(document)
    .on('turbolinks:load', function (ev) {
      var $ryk = $('.rykn0wxx');
      if ($ryk.data('rykn0wxx')) {
        $ryk.data('rykn0wxx', null);
      }
      Plugin.call($ryk);
      ev.preventDefault();
    });

}));
