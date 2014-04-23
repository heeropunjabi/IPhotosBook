<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
  <%@ taglib prefix="s" uri="/struts-tags" %>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>IPhotosBook</title>

 <link rel="stylesheet" type="text/css" href="view/css/index.css" />
  <link rel="stylesheet" type="text/css" href="view/css/flipbook.css" />
  <link rel="stylesheet" type="text/css" href="view/css/jquery.ui.css" />


	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
	<!--<script type="text/javascript" src="http://code.jquery.com/jquery-1.7.1.min.js"></script> -->
    <script type="text/javascript" src="view/js/turn.min.js"></script>



  <script src="https://www.google.com/jsapi" type="text/javascript"></script>
    <script type="text/javascript">
	
	google.load('search', '1');
	
	var imageSearch ;
	
	
	var currentPageNumber=1;
	
	var urlArray=new Array();
	
	 function searchComplete() {
		 
		 
		var results = imageSearch.results;
		urlArray=new Array();
		 for (var i = 0; i < results.length; i++) {
          
          var result = results[i];
		  console.log('inside search complete method'+result.url);
		  
		  urlArray[i]=result.url;
		
		
	 
	 }
		 if(urlArray.length>0)
		 {
		 	loadImagesInBook(0);
		 	$('#book').turn('next');
		 }
		 else
			alert('Sorry ! No images found.'); 
			
	
	}
	
	
	
	 function OnLoad() {
 
		imageSearch = new google.search.ImageSearch();
	 imageSearch.setRestriction(google.search.ImageSearch.RESTRICT_IMAGESIZE,
			 google.search.ImageSearch.IMAGESIZE_MEDIUM);
								 
	
	 imageSearch.setRestriction(
			  google.search.ImageSearch.RESTRICT_FILETYPE,
			  google.search.ImageSearch.FILETYPE_PNG
			);
	 
	 
	imageSearch.setSearchCompleteCallback(this, searchComplete, null);							 
	
	
	
	
	}
	
	
	function searchImages(){
		
		
		
		while(currentPageNumber!=1){
			currentPageNumber--;
			$('#book').turn('previous');
			
		}
		
		
		
		
		imageSearch.setResultSetSize(8);
		imageSearch.execute($('#searchTextBox').val());
		
		
		
		
		
		
	}
	
	
	
	function loadImagesInBook(isFavoriteButton){
		
		var count=0;
		 $(".myPage").each(function()
		 {
			    $(this).empty();
			    $(this).css( "padding", "20px" );
			    
			    if(urlArray[count]!=undefined)
			    	$(this).append("<img src='"+ urlArray[count]+"' style='padding:20px;border: 15px solid rgb(222, 222, 222);' width='200px' height='200px' />");
			    
			    if($('#isSign').val()=='true' && isFavoriteButton!=1)
			    {
			    	var img=$("<img src='view/images/bookmark.png' style='padding:20px;' width='20px' height='20px'  />")	
			    	$(this).append(img);
					img.click(function()
			    	{
			    		console.log('url add method'+$(this).prev().attr('src'));
			    		var imagePath=$(this).prev().attr('src');
			    		
			    		var lengthOfFavoriteItems=$('#listPanel').children().length;
			    		
			    		if(lengthOfFavoriteItems<4)
			    		{
			    		 		$.ajax(
			    				 {
			    					url:"add?url="+$(this).prev().attr('src'),
			    					success:function(result)
			    					{
			    						
			    		
			    						console.log('image added');	
			    						
			    		    		}
			    				 });
								console.log('imagepath='+imagePath);
								$("#listPanel").prepend("<span><img src='"+imagePath+"' width='60px' height='60px'/><img src='view/images/delete.png' width='16px' height='16px' style='position: relative;bottom: 7em;visibility:hidden;' /></span>");
    							hoverEvent(); 
			    		
    							$(this).css('visibility','hidden');
    							 favoriteButtonEnableDisable();
    					
			    		}
			    		else
			    			alert("Sorry ! you can't make more than 4 Photos as Favorites");
    					
			    		
					});
			    }
			    
			    console.log('inside load imags'+urlArray[count]);
			    count++;
			    
			    
			    
		 });
	}
	
	
	
	
	
	google.setOnLoadCallback(OnLoad);
 
 
 </script>
 
 
 
 

</head>


<body style="margin: 0px">
   <div id="header">
   
   <table style="width: 100%;">
     <tbody>
	 <tr>
       	<td width="30%">
   			<span id="brandLogo" >
   				<a href="index" style="text-decoration: none;background-color: rgb(241, 241, 241);font-family: Segoe UI;color: rgb(66,135, 250);font-weight: bolder;">!PhotosBook</a>
			</span>
		</td>	
   		<td width="45%">
   				<span id="textBoxAndSearch">
   				
   					<input type="text" value="" id="searchTextBox" />
   					<span id="searchButton" onclick="searchImages()">search</span>
   			
   				</span>
			
   		</td>
   		<td width="25%">	
   			
   		
   		
   		
   		
   		
   			<s:if test="%{userName != ''}">
   			
				<span id="signOut"><a href='<s:property value="signOutURL" />'>Sign Out</a></span>
			</s:if>
			<s:else>
				
				<span id="signIn"><a href='<s:property value="signInURL" />'>Sign In with Google Account</a></span>
				
    			
    		</s:else>
 
		</td>
	</tr>
	</tbody>
</table>
		
   		
   		
   		
   		
   	</div>
   		
   		
   
   
   
   
   <div id="content">
   
 <s:if test="%{userName != ''}">
   		
   		
   		<div id="favoritePanel" >	

	 	<div id="listPanel" style=" overflow: auto; display: list-item; height: 100%; ">
   			<s:iterator value="listOfURLs" >
   				<span><img src='<s:property/>' width='60px' height='60px'/>
   				<img src="view/images/delete.png" width="16px" height="16px" style="position: relative;bottom: 7em;visibility:hidden;" />
   				
   				
   				</span>
   			</s:iterator>
 		</div>
    
    
    
    
    	
    
    
	</div>		
			
	<div id="book" style="width: 700px; height: 400px; top: 7em; left: 23em; position: absolute !important;">
	<div class="cover">
		<div id="cover">
			<p style="text-align: center;color: rgb(66,135,255);font-weight: bold;font-size: 31px;margin-left: 0px;">!PhotosBook</p>
			<br>
  			<p style="color: grey;font-size: 17px;font-weight: bold;font-family: segoe UI;margin-left: 10px;margin-right: 27px;">!PhotosBook will help you to search Images &amp; view it in real book format. &nbsp; &nbsp;&nbsp;<br><br> Use Keyboard's left &amp; right Arrow keys to move the pages.</p><br>
			<br>
			
		</div>
	
	
	</div>
	</div>
	
	<input type="hidden" id="isSign" value="true" />
	
			
</s:if>
			
 <s:else>
 
 <div id="book" style="width: 700px; height: 400px; top: 7em; left: 23em; position: absolute !important;">
	<div class="cover">
		<div id="cover">
			<p style="text-align: center;color: rgb(66,135,255);font-weight: bold;font-size: 31px;margin-left: 0px;">!PhotosBook</p>
			<br>
  			<p style="color: grey;font-size: 17px;font-weight: bold;font-family: segoe UI;margin-left: 10px;margin-right: 27px;">!PhotosBook will help you to search Images &amp; view it in real book format. &nbsp; &nbsp;&nbsp;<br><br> Use Keyboard's left &amp; right Arrow keys to move the pages.</p><br>
			<br>
			
		</div>
	
	
	</div>
	
	
	
	
</div>
 
 <input type="hidden" id="isSign" value="false" />
 </s:else>  
   
   

  
   
   
   
   </div>
   
   <div id="footer">
   
   
   
   
   		<span id="author">Powered By :Heero Punjabi</span>
   
   
   		<s:if test="%{userName != ''}">	
   			<span id="favoriteButton">
    			View favourite Photos
    		</span>
    	</s:if>
   
   
   
   
   		
   	
   		
   
   </div>
   
   
   
   
   
   
   <script type="text/javascript">

	
	
	var numberOfPages=5;
	
	
	$(window).ready(function(){
	
		
		$('#book').turn({acceleration: true,
							pages: numberOfPages,
							elevation: 150,
							
							when: {
								
								turned: function(e, page) {
									//$('#page-number').val(page);
									currentPageNumber=page;
									console.log('current page'+page);
								}
							}
						});
		
		
		for (var page = 2; page<=numberOfPages; page++)
		{
					
				var book=$('#book');
				var element = $('<div />', {'class': 'page '+((page%2==0) ? 'odd' : 'even'), 'id': 'page-'+page}).html('<i class="loader"></i>');
				element.html("<div class='data'><div id='photo"+page+"' class='myPage'></div></div>");
				book.turn('addPage', element, page);
									
		}
		
		var backCover="<div class='cover'><span id='backCover'></span></div>";
		$('#book').turn('addPage', backCover, 6);
		
		

		
	});
	
	
	
	
	$(window).bind('keydown', function(e){

		if (e.target && e.target.tagName.toLowerCase()!='input')
			if (e.keyCode==37)
				$('#book').turn('previous');
			else if (e.keyCode==39)
				$('#book').turn('next');

	});
	
	
	
	
	$( document ).ready(function() 
	{
		
		

		/* $('#favoritePanel > div > span').mouseout(function() 
		{
			$(this).find('img:nth-child(2)').css('visibility','hidden');
		}); */
		
		hoverEvent();
		favoriteButtonEnableDisable();
		
		$($('#cover').parent()[0]).css('border-top','22px solid rgb(220,220,220)');
		$($('#cover').parent()[0]).css('border-left','31px solid rgb(66,135,250)');
		$($('#cover').parent()[0]).css('background-color','white');
		
		
		$($('#backCover').parent()[0]).css('border-top','9px solid white');
		
		
		
		 $('#searchTextBox').on('keypress', function (event) {
	         if(event.which == '13'){

	        	 $(this).blur();
	        	 searchImages();
	           	      
	         }
	   });
		
		
		
	});
	
	
	function favoriteButtonEnableDisable()
	{
		if($('#listPanel').children().length>0)
		{
			$('#favoritePanel').css('visibility','visible');
			$('#favoriteButton').removeClass( "disableFavoriteButton" ).addClass( "enableFavoriteButton" );
			
		}
			
		else
		{
			$('#favoritePanel').css('visibility','hidden');
			$('#favoriteButton').removeClass( "enableFavoriteButton" ).addClass( "disableFavoriteButton" );
			
		}
			
		
	}
	
	
	function hoverEvent()
	{
		
		
		
		
		
		
		$('#favoritePanel > div > span').hover(function() 
				{
					
				
					$(this).find('img:nth-child(2)').css('visibility','visible');
					
				},function() 
				{
					$(this).find('img:nth-child(2)').css('visibility','hidden');
				}
				
			);
		
		

		$('#favoritePanel > div > span > img:nth-child(2)').click(function()
				{
		    		console.log('url delete method'+$(this).prev().attr('src'));
		    		 $.ajax(
		    				 {
		    					url:"delete?url="+$(this).prev().attr('src'),
		    					success:function(result)
		    					{
		    		      			
		    		    		}
		    				 });
		    		 
		    		 console.log('parent'+$(this).parent());
		    		 $(this).parent().remove();
		    		 favoriteButtonEnableDisable();
		    		
				});
		
		
		$('#favoriteButton').click(function()
		{
			
			var counter=0;
			urlArray=new Array();
			$('#favoritePanel > div > span > img:nth-child(2)').each(function()
			{
				
						
						urlArray[counter++]=$(this).prev().attr('src');
						
			    		 
			});
			 if(urlArray.length>0)
			 {
				 
				 
				 while(currentPageNumber!=1){
						currentPageNumber--;
						console.log('current page number while'+currentPageNumber);
						$('#book').turn('previous');
						
					}
				 
				 loadImagesInBook(1);
				 
				
					 $('#book').turn('next');	 
				
				 
				 
					
			 	
			 }
			
			
		
		
		
		});
		
		

		
	}
	
	
	
	
	
	

</script>
  
    
  </body>
</html>