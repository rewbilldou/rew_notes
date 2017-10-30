# http://www.southbayresidential.com lec-2015
# http://dev.ahuffine.rewtemplates.com bcse

### Git hash ID: `d6d9120e78bbce4f03b75d47467a63af0a18d841`

> location: `httpdocs/inc/classes/IDX/Panel.php` after line 472
```
. (!empty($this->hidden) ? ' ' . $this->hiddenClass : '')
```
add
```

                /* REWMOD - Bill Dou - 7/21/2017 3:44 PM - add switch class to enable the toggle function ticket 186167*/
                . (!empty($this->closed) ? ' switch' : '')
                . (!empty($this->closed) ? ' closed' : '')
                /* REWMOD - Bill Dou - 7/21/2017 4:30 PM - end */

```
before
```
if (!empty($this->titleElement)) echo '</' . $this->titleElement . '>';
```
add
```
echo (!empty($this->closed) ? '<span class="inner-icon"><i class="fa icon-reorder" aria-hidden="true"></i></span>' : '');
```

before 
```
echo $this->getMarkup();
```
change to 
```
echo '<div class="' . $this->detailsClass . (!empty($this->closed) && !empty($this->toggle) ? ' ' . $this->hiddenClass : '') . (!empty($this->closed) ? ' collapsed' : '') . '">'; // REWMOD - Bill Dou - 9/28/2017 - ad hidden class
```

> location: `/httpdocs/inc/skins/brew/modules/idx-search/module.js.php`

after 
```
BREW.Modules.IDX_SEARCH = {
                                return true;
                        });
```
						
```
             /* REWMOD - Bill Dou - 7/21/2017 3:41 PM - add toggle function  ticket 186167*/
            // Toggle Panels
            $form.on(BREW.events.click, '.switch.field>label', function () {
                var $label = $(this)
                    , $field = $label.closest('.field')
                ;
                if ($field.hasClass('closed')) {
                    // Open Panel
                    $field.removeClass('closed').find('.details').removeClass('collapsed').slideDown('fast');

                } else {
                    // Close Panel
                    $field.addClass('closed').find('.details').addClass('collapsed').slideUp('fast');
                }
                return true;
            });
                       /* REWMOD - Bill Dou - 7/21/2017 3:41 PM - END */

```

> location: `httpdocs/inc/skins/lec-2015/css/custom.less`

```
/* REWMOD - Bill Dou - 7/21/2017 3:54 PM - add icon arrow into closed panel ticket 186167*/
+.advanced-options .field.switch {
       &>label span.inner-icon{
               float: right;
       }
       .details.collapsed {
               display: none;
       }
+}

+@media only screen and (max-width: 1200px) {
       .advanced-options .field .details label {
               width: 50%;
               font: 14px/20px helvetica;
       }
}
/* REWMOD - Bill Dou - 7/21/2017 4:26 PM - END */
```