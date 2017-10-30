## Click outside of container to close the drop down menu
> Site: https://www.knoxre.com
```javascript
$(document).on('click', function(e) {
        var container = $('.mega');
        if (!container.is(e.target) && container.has(e.target).length === 0) {
            $('.mega').removeClass('mega-current');
            $('.mega .mega-drop').removeClass('opened');
        }
    });
```