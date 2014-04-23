   <script type="text/javascript">

	var counter=0;
	
	var numberOfPages=5;
	

	// Adds the pages that the book will need
	function addPage(page, book) {
		// 	First check if the page is already in the book
		console.log('page'+page);
		
		if (!book.turn('hasPage', page)) {
			// Create an element for this page
			var element = $('<div />', {'class': 'page '+((page%2==0) ? 'odd' : 'even'), 'id': 'page-'+page}).html('<i class="loader"></i>');
			// If not then add the page
			book.turn('addPage', element, page);
			// Let's assum that the data is comming from the server and the request takes 1s.
			setTimeout(function(){
					element.html("<div class='data'><div id='photo"+counter+"' class='myPage'></div></div>");
					counter++;
			}, 1000);
		}
	}

	$(window).ready(function(){
	
		console.log('loading');
		$('#book').turn({acceleration: true,
							pages: numberOfPages,
							elevation: 150,
							
							when: {
								turning: function(e, page, view) {

									// Gets the range of pages that the book needs right now
									var range = $(this).turn('range', page);
									
									console.log('range'+range);
									
									counter=0;
									// Check if each page is within the book
									for (page = 1; page<=numberOfPages; page++) 
										addPage(page, $(this));

								},

								turned: function(e, page) {
									$('#page-number').val(page);
								}
							}
						});

		
	});
	
	
	
	
	$(window).bind('keydown', function(e){

		if (e.target && e.target.tagName.toLowerCase()!='input')
			if (e.keyCode==37)
				$('#book').turn('previous');
			else if (e.keyCode==39)
				$('#book').turn('next');

	});
  </script>
