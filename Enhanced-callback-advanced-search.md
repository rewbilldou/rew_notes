## This is for advanced search with your own closure function
### *http://rpm.rewhosting.com/projects/details/?id=42494*
> location: `MySQLImproved.php`
> `buildQueryString function`

```PHP
public function buildQueryString ($mysql_field, $mysql_values, $sql_match_type, $sql_conjunction = 'AND', $keep_or = true) {
        /* REWMOD - Bill Dou - 9/12/2017 10:40 AM - add callback function for advanced search */
        // Notice: why I put lessthan here as exception? lessthan is declared as function in vendor, so lessthan will be considered callable function
        // The function location: ./vendor/phpunit/phpunit/src/Framework/Assert/Functions.php  Line 2046
        // I have to update this callable codes
        if (is_array($sql_match_type) && is_callable($sql_match_type['closure'])) {

            // Check if co idx field exists
            $mysql_co_field = $sql_match_type['co_idx_field'];

            $sql_match_type = $sql_match_type['closure'];

            $resultList = array();

            foreach ((is_array($mysql_values) ? $mysql_values : array($mysql_values)) as $value) {
                // if the result is an array, then merge them all in
                if (is_array($result = $sql_match_type($mysql_field, $mysql_co_field, $this->cleanInput($value)))) {
                    $resultList += $result;
                }
                else {
                    $resultList[] = $result;
                }
            }

            // Need to remove OR if there is no "where condition" before this closure where
            if ($keep_or) {
                return '(' . implode(' OR ', $resultList) . ')' . $sql_conjunction;
            } else {
                return preg_replace('/\s?OR\s?/', '', '(' . implode(' OR ', $resultList) . ')' . $sql_conjunction, 1);
            }

        }
        /* REWMOD - Bill Dou - 9/12/2017 10:40 AM - end */
```

> Location: `advanced.settings.php`
```PHP
array('name' => 'Property Type',       'form_field' => 'search_type',           'idx_field' => 'ListingType',           'match' =>
                array('closure' =>
                          function($field, $co_field, $value) {
                              switch ($value) {
                                  case 'Home':
                                      return "`$field` = 'Residential' AND `$co_field` LIKE 'Single Family%'";
                                      break;
                                  case 'Condo':
                                      return "`$field` = 'Residential' AND `$co_field` LIKE 'Condo%'";
                                      break;
                                  case 'Land':
                                      return "`$field` = '" . $value . "'";
                                      break;
                                  case 'Commercial':
                                      return "`$field` = '" . $value . "'";
                                      break;
                              }
                          },
                    'co_idx_field' => 'ListingSubType'
                )
            ),
```

> Location: `httpdocs/inc/classes/IDX.php` `buildWhere` funciton

```PHP
// Group Search Query
            if (!empty($searchField['group'])) {
                if (!isset($search_or_where[$searchField['group']])) {
                    $search_or_where[$searchField['group']] = '';
                }
                if (!empty($searchValue)) {
                    $search_or_where[$searchField['group']] .= $db_idx->buildQueryString($search_db_field, $searchValue, $searchField['match'], 'OR');
                }

            // Search Query
            } elseif (!empty($searchValue)) {
                /* REWMOD - Bill Dou - 10/12/2017 2:15 PM -
                 * Why I add these changes?
                 * If we just use callable function, there is 'or' at the beginning of search_where,
                 * like "WHERE (OR ListingType like '%Land%' ... `)"
                 * So we need to remove the first " OR ", so I have added another para in buildQueryString function,
                 * It is called "keep_or"
                 * See the codes - /inc/classes/Database/MySQLImproved.php line 340
                 */
                if (empty($search_where) && is_array($searchField['match'])) {
                    $search_where .= $db_idx->buildQueryString($search_db_field, $searchValue, $searchField['match'], 'AND', false);
                } else {
                    $search_where .= $db_idx->buildQueryString($search_db_field, $searchValue, $searchField['match'], 'AND');
                }

            }
```