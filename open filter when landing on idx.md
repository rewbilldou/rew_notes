Title         : How to make filter open when you land on idx page
Author        : Bill Dou
Date          : 9/21/2017

# How to make filter open when you land on idx page

## Create variable to determine right page 

> location: `/inc/skins/elite/tpl/misc/footer.tpl.php`
```javascript
<?php /* REWMOD - Bill Dou - 9/21/2017 2:43 PM - add variable to determine the page info */ ?>
    window.REW.is_idx = <?= $_GET['load_page'] == 'search' && $_GET['refine'] !== 'true' ? 'true' : 'false'; ?>;
```
## Open filter
> Location: `httpdocs/inc/skins/elite/js/skin/ctas.js`
```javascript
if (REW.is_idx) {
    REW.loadPanels(true);
}
```