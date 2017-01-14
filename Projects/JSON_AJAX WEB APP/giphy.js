//IN THIS APP YOU CAN SEARCH FOR ANY STICKERS. For example: cat, dog, cow, bird, tree, etc.

//create an empty object to hold the data and functionality of our app.
		var app = {};
        
        
        // Create an init method that will hold all of the code 
		app.init = function(){
		// create event listener on select element
			$('#search').on('click', function() {
				//create variable and pass id info to it
				var searchInfo = $('#info').val();		
				$('#container').empty();
				//pass created variable as a parameter
				app.getGiphy(searchInfo);
			});	
		};
			
	
		
		// create the method that will get the result of API
		app.getGiphy = function(query){
			$.ajax({
				url: 'http://api.giphy.com/v1/stickers/search',
				method: 'GET',
				data: {
					q: query,
					api_key: 'dc6zaTOxFJmzC' 
				},
	
				success: function(result){
					//create if statement for lenght == 0
					if (result.data.length == 0) {
						app.noResults = '<p>Result not found</p>';
						//execute the code if condition is true
						$('#container').append(app.noResults);
					}
					//using forEach to loop over array of sticker
					result.data.forEach(function(sticker){
						//create variable to hold the app.stickerGet(sticker)
						var eachItem = app.stickerGet(sticker);
						//append created variable to id container
						$('#container').append(eachItem);
					});
				},

				error: function(error){
					console.log('Something went wrong.');
				}
			});
		};
		
		
   //Creating a function that will return data into the DOM
		app.stickerGet = function(sticker){
			return '<img src="' + sticker.images.downsized.url + '" >'
		};
		
		
		$(function(){
	app.init(); // starting the app!
});