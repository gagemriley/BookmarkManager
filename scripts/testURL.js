var landingPageApp_ns = landingPageApp_ns || {};

$.extend(true, landingPageApp_ns, {
	common_ns: {
		// Tests an img.src url to see if it returns an image
		// Parameter:
		//		url (string) - The image url to test
		// Returns:
		//		A Promise object. Call the then() method with a function argument that has no parameters.
		//		It will be called if the image fails to load.
		// See also:
		//		landingPageApp_ns.common_ns.Bookmark.display()
		testImageURL: function(url){
		    var imgPromise = new Promise(function(resolve, reject){
				var img = new Image();
				img.addEventListener("load", function(){ resolve(); });
				img.addEventListener("error", function () { reject(); });
			    img.src = url;
			});
			return imgPromise;
		}
	}
});