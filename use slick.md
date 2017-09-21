Title         : how to use slick in rew site
Author        : Bill Dou
Date          : 9/21/2017

[TITLE]

# Create init JS file 

In skin JS directory (like *`/httpdocs/inc/skins/pt-1r/js/slick.init.js`*), create a file named `slick.init.js`, 
then go to *`/httpdocs/inc/classes/Skin/BREW.php`*, in `construct` function, add 
```$this->addJavascript('js/slick.min.js');
$this->addJavascript('js/slick.init.js');```

# CSS
Go to skin misc header.tpl like *`httpdocs/inc/skins/pt-1r/tpl/misc/header.tpl.php`*

```<link rel="stylesheet" type="text/css" href="<?=$path; ?>/css/slick.css"/>```
```<link rel="stylesheet" type="text/css" href="<?=$path; ?>/css/slick-theme.css"/>```

# demo

```javascript
$(document).ready(function(){
  $('.listings-carousel-container').slick({
	  dots: false,
	  infinite: true,
	  autoplay: false,
	  autoplaySpeed: 3200,
	  speed: 300,
	  slidesToShow: 4,
	  slidesToScroll: 1,
	  pauseOnHover: true,
	  responsive: [
	    {
	      breakpoint: 1024,
	      settings: {
	        slidesToShow: 3,
	        slidesToScroll: 3,
	        infinite: true
	      }
	    },
	    {
	      breakpoint: 600,
	      settings: {
	        slidesToShow: 2,
	        slidesToScroll: 1
	      }
	    },
	    {
	      breakpoint: 480,
	      settings: {
	        slidesToShow: 1,
	        slidesToScroll: 1
	      }
	    }
	  ]
	});
});
```