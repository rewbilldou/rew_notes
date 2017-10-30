# gdewar.rewtemplates.com CE  VR backend

> location: `/httpdocs/inc/skins/ce/modules/fgallery/module.php` line 42
```
// REWMOD - Bill Dou - 9/28/2017 - check setting for this
// CMS Database
$db = DB::get('cms');

// define selected field
$sql_select = '`popup_showing_form_if_cycle_all_photos`';

// Get idx feed name
$feed = Settings::getInstance()->IDX_FEED;

$sql_where = " WHERE idx='" . $feed . "'";

$query = $db->prepare("SELECT " . $sql_select . " FROM `" . TABLE_IDX_SYSTEM . "`" . $sql_where . ";");
$query->execute();
$result = $query->fetch();

// Create a JS variable for popup request form
// See JS code in module.js.php
if ($result['popup_showing_form_if_cycle_all_photos'] == 'true') {
    $page->addJavascript("custom_popup_switcher = true;", 'dynamic', false);
} else {
    $page->addJavascript("custom_popup_switcher = false;", 'dynamic', false);
}
// REWMOD - Bill Dou - 9/28/2017 - end
```
> Location: `/httpdocs/inc/skins/ce/modules/fgallery/module.js.php` line 20
after `$galleryLink` click
 ```
/ REWMOD - Bill Dou - 9/27/2017 - initial slide view count number
            // Client can control this switcher from backend setting
            if (custom_popup_switcher) {
                // Init viewed
                var viewed_counter = 0;

                // Monitor left/right arrow click event
                $('.pswp__ui > .pswp__button').click(function(){
                    // If next clicked, plus 1
                    if ($(this).hasClass('pswp__button--arrow--right')) {
                        viewed_counter = viewed_counter + 1;
                    // If prev clicked, minus 1
                    } else {
                        viewed_counter = viewed_counter - 1;
                    }

                    // If absolute value is equal to image number, pop up request showing form
                    if (Math.abs(viewed_counter) == galleryPhotos.length) {
                        $.Window({ iframe : 'inquire/' });

                        // Unset viewed counter
                        viewed_counter = undefined;
                    }
                });
            }
            /* REWMOD - Bill Dou - 9/28/2017 4:16 PM - end */
```
> Locaiton: `/httpdocs/backend/inc/tpl/pages/settings/idx/default.tpl`
```
<?php // REWMOD - Bill Dou - 9/28/2017 - add switcher for popup request form after viewing all listing images ?>
        <h3 class="divider text">
            <span class="divider__label divider__label--left">Property Detail Settings</span>
        </h3>

        <div class="field">
            <label class="field__label">If user cycles through all of the photos for a listing, pop up the Request a showing form</label>
            <div class="buttonset radios compact toggle">
                <input type="radio" name="popup_showing_form_if_cycle_all_photos" id="popup_showing_form_if_cycle_all_photos_true"
                       value="true"<?= ($system['popup_showing_form_if_cycle_all_photos'] === 'true') ? ' checked' : ''; ?>>
                <label class="boolean toggle__label" for="popup_showing_form_if_cycle_all_photos_true">Enable</label>
                <input type="radio" name="popup_showing_form_if_cycle_all_photos" id="popup_showing_form_if_cycle_all_photos_false"
                       value="false"<?= ($system['popup_showing_form_if_cycle_all_photos'] === 'false') ? ' checked' : ''; ?>>
                <label class="boolean toggle__label" for="popup_showing_form_if_cycle_all_photos_false">Disable</label>
            </div>
            <p class="text--mute">
                <strong>If Enable:</strong> If a user cycles through all of the photos for a listing have the Request a showing form pop up.
            </p>
        </div>
        <?php // REWMOD - Bill Dou - 9/28/2017 - end ?>
```

> Location: `/httpdocs/backend/classes/Controller/Settings/Idx/IndexController.php` line 
```
`popup_showing_form_if_cycle_all_photos`    = :po158pup_showing_form_if_cycle_all_photos,
```

line 191
```
'popup_showing_form_if_cycle_all_photos' => $_POST['popup_showing_form_if_cycle_all_photos'] === 'true' ? 'true' : 'false',
```
