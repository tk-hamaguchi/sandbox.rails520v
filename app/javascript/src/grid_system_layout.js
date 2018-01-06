'use strict'

import $ from 'jquery';

class GridSystemLayout {
	static adjustSideMenu() {
		let contentHeight = ($(window).height() - $('header').height()) || 0
		let mainHeight    = $('#main_contents').height() || 0
		let paddingTop    = 16
		let footerHeight  = $('footer').height() || 0

		if (
			(mainHeight > 0) &&
			(mainHeight > (contentHeight - paddingTop - footerHeight))
		) {
			console.log("hoge")
			//$('#main_contents').css('min-height', (contentHeight - 23) + 'px')
		} else {
			$('#main_contents').css('min-height', (contentHeight - paddingTop - footerHeight) + 'px')
			$('#side_menu').css('min-height', contentHeight + 'px')
		}
	}
}

$(document).on('DOMContentLoaded', () => {
	$('#main_contents').on('DOMSubtreeModified', () => {
		console.log("#main_contents DOMSubtreeModified");
		GridSystemLayout.adjustSideMenu();
	})

	$(window).on('resize load', () => {
		console.log("window resize load page:load");
		GridSystemLayout.adjustSideMenu();
	})
	$(document).on('turbolinks:load', () => {
		console.log("document turbolinks:load");
		GridSystemLayout.adjustSideMenu();
	})
})
