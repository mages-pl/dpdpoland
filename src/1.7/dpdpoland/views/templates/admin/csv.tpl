{** 2019 DPD Polska Sp. z o.o.
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Open Software License (OSL 3.0)
 * that is bundled with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * http://opensource.org/licenses/osl-3.0.php
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * prestashop@dpd.com.pl so we can send you a copy immediately.
 *
 * @author    DPD Polska Sp. z o.o.
 * @copyright 2019 DPD Polska Sp. z o.o.
 * @license http://opensource.org/licenses/osl-3.0.php Open Software License (OSL 3.0)
 * International Registered Trademark & Property of DPD Polska Sp. z o.o.
 *}
<form id="configuration_csv_form" class="defaultForm" action="{$saveAction|escape:'htmlall':'UTF-8'}" method="post" enctype="multipart/form-data">
    <fieldset id="sender_payer">
        <legend>
            <img src="{$smarty.const._DPDPOLAND_IMG_URI_|escape:'htmlall':'UTF-8'}settings.png" alt="{l s='Settings |' mod='dpdpoland'}" />
            {l s='Price rules import' mod='dpdpoland'}
        </legend>
        
        <label>
            {l s='Upload CSV:' mod='dpdpoland'}
        </label>
        <div class="margin-form">
            <input type="file" name="{DpdPolandCSV::CSV_FILE|escape:'htmlall':'UTF-8'}" value="" />
            <input type="submit" class="button" name="{DpdPolandCSVController::SETTINGS_SAVE_CSV_ACTION|escape:'htmlall':'UTF-8'}" value="{l s='Upload' mod='dpdpoland'}" />
        </div>
        <div class="clear"></div>
        
        <label>
            {l s='Download CSV:' mod='dpdpoland'}
        </label>
        <div class="margin-form">
            <input type="button" class="button" name="{DpdPolandCSVController::SETTINGS_DOWNLOAD_CSV_ACTION|escape:'htmlall':'UTF-8'}" value="{l s='Download' mod='dpdpoland'}" />
        </div>
        
        <div class="separation"></div>
        
        <h3>
            {l s='Preview imported prices:' mod='dpdpoland'}
        </h3>
        
        <div class="csv_information_block">
            <p class="preference_description">
                {l s='Available' mod='dpdpoland'} <b>{l s='carriers' mod='dpdpoland'}</b> {l s='(shipping methods) and their ID\'s:' mod='dpdpoland'}
            </p>
            <p class="preference_description">
                {l s='* DPD domestic shipment - Standard:' mod='dpdpoland'} <b>{$smarty.const._DPDPOLAND_STANDARD_ID_|escape:'htmlall':'UTF-8'}</b>
            </p>
            <p class="preference_description">
                {l s='* DPD domestic shipment - Standard with COD:' mod='dpdpoland'} <b>{$smarty.const._DPDPOLAND_STANDARD_COD_ID_|escape:'htmlall':'UTF-8'}</b>
            </p>
            <p class="preference_description">
                {l s='* DPD international shipment (DPD Classic):' mod='dpdpoland'} <b>{$smarty.const._DPDPOLAND_CLASSIC_ID_|escape:'htmlall':'UTF-8'}</b>
            </p>
            <p class="preference_description">
                {l s='* DPD Poland Reception Point Pickup:' mod='dpdpoland'} <b>{$smarty.const._DPDPOLAND_PUDO_ID_|escape:'htmlall':'UTF-8'}</b>
            </p>
            <p class="preference_description">
                {l s='* DPD Poland Reception Point Pickup with COD:' mod='dpdpoland'} <b>{$smarty.const._DPDPOLAND_PUDO_COD_ID_|escape:'htmlall':'UTF-8'}</b>
            </p>
            <br />
            <p class="preference_description">
                <b>{l s='Country' mod='dpdpoland'}</b> {l s='- this column should contain the full name of the country (the letters are not case sensitive, or as an abbreviation, e.g. PL, DE, GB)' mod='dpdpoland'}
            </p>
            <p class="preference_description">
                <b>{l s='Cart price from' mod='dpdpoland'}</b> {l s='- this column contains the cart total price without shipping which is the lower limit of the price range for the specified price.' mod='dpdpoland'}
            </p>
            <p class="preference_description">
                <b>{l s='Cart price to' mod='dpdpoland'}</b> {l s='- this column contains the cart total price without shipping which is the upper limit of the price range for the specified price.' mod='dpdpoland'}
            </p>
            <p class="preference_description">
                <b>{l s='Parcel weight from' mod='dpdpoland'}</b> {l s='- this column contains the parcel weight which is the lower limit of the weight range for the specified price.' mod='dpdpoland'}
            </p>
            <p class="preference_description">
                <b>{l s='Parcel weight to' mod='dpdpoland'}</b> {l s='- this column contains the parcel weight which is the upper limit of the weight range for the specified price.' mod='dpdpoland'}
            </p>
            <p class="preference_description">
                <b>{l s='Parcel price' mod='dpdpoland'}</b> {l s='- in this column the user enters the price in PLN which will be charged to the client for dispatch of one parcel with the weight within the specified weight range.' mod='dpdpoland'}
            </p>
            <br />
            <table name="list_table" class="table_grid">
                <tbody>
                    <tr>
                        <td class="bottom">
                            <span class="float-left">
                                {if $page > 1}
                                    <a href="{$saveAction|escape:'htmlall':'UTF-8'}&current_page=1&pagination={$selected_pagination|escape:'htmlall':'UTF-8'}">
                                        <img class="pagination_image" src="../img/admin/list-prev2.gif" alt="{l s='First page' mod='dpdpoland'}" />
                                    </a>
                                    <a href="{$saveAction|escape:'htmlall':'UTF-8'}&current_page={$page|escape:'htmlall':'UTF-8' - 1}&pagination={$selected_pagination|escape:'htmlall':'UTF-8'}">
                                        <img class="pagination_image" src="../img/admin/list-prev.gif" alt="{l s='Previous page' mod='dpdpoland'}" />
                                    </a>
                                {/if}
                                {l s='Page' mod='dpdpoland'} <b>{$page|escape:'htmlall':'UTF-8'}</b> / {$total_pages|escape:'htmlall':'UTF-8'}
                                {if $page < $total_pages}
                                    <a href="{$saveAction|escape:'htmlall':'UTF-8'}&current_page={$page|escape:'htmlall':'UTF-8' + 1}&pagination={$selected_pagination|escape:'htmlall':'UTF-8'}">
                                        <img class="pagination_image" src="../img/admin/list-next.gif" alt="{l s='Next page' mod='dpdpoland'}" />
                                    </a>
                                    <a href="{$saveAction|escape:'htmlall':'UTF-8'}&current_page={$total_pages|escape:'htmlall':'UTF-8'}&pagination={$selected_pagination|escape:'htmlall':'UTF-8'}">
                                        <img class="pagination_image" src="../img/admin/list-next2.gif" alt="{l s='Last page' mod='dpdpoland'}" />
                                    </a>
                                {/if}
                                | {l s='Display' mod='dpdpoland'}
                                <select name="pagination" onchange="submit()">
                                    {foreach $pagination AS $value}
                                        <option value="{$value|intval|escape:'htmlall':'UTF-8'}"{if $selected_pagination == $value} selected="selected" {elseif $selected_pagination == NULL && $value == $pagination[1]} selected="selected2"{/if}>{$value|intval|escape:'htmlall':'UTF-8'}</option>
                                    {/foreach}
                                </select>
                                / {$list_total|escape:'htmlall':'UTF-8'} {l s='result(s)' mod='dpdpoland'}
                            </span>
                            <span class="clear"></span>
                        </td>
                    </tr>
                    <tr>
                        <td clas="no-border">
                            <table cellspacing="0" cellpadding="0" class="table document">
                                <colgroup>
                                    <col>
                                    <col>
                                    <col>
                                    <col>
                                    <col>
                                    <col>
                                    <col>
                                    <col>
                                </colgroup>
                                <thead>
                                    <tr class="nodrag nodrop titles-row">
                                        <th class="center">
                                            <span class="title_box">{l s='Country' mod='dpdpoland'}</span>
                                        </th>
                                        <th class="center">
                                            <span class="title_box">{l s='Cart price from (PLN)' mod='dpdpoland'}</span>
                                        </th>
                                        <th class="center">
                                            <span class="title_box">{l s='Cart price to (PLN)' mod='dpdpoland'}</span>
                                        </th>
                                        <th class="center">
                                            <span class="title_box">{l s='Parcel weight from (kg)' mod='dpdpoland'}</span>
                                        </th>
                                        <th class="center">
                                            <span class="title_box">{l s='Parcel weight to (kg)' mod='dpdpoland'}</span>
                                        </th>
                                        <th class="center">
                                            <span class="title_box">{l s='Parcel price (PLN)' mod='dpdpoland'}</span>
                                        </th>
                                        <th class="center">
                                            <span class="title_box">{l s='Carrier' mod='dpdpoland'}</span>
                                        </th>
                                        <th class="center">
                                            <span class="title_box">{l s='COD cost (PLN)' mod='dpdpoland'}</span>
                                        </th>
                                    </tr>
                                </thead>
            
                                <tbody>
                                    {if isset($csv_data) && !empty($csv_data)}
                                        {section name=ii loop=$csv_data}
                                            <tr>
                                                <td class="center">
                                                    {$csv_data[ii].iso_country|escape:'htmlall':'UTF-8'}
                                                </td>
                                                <td class="center">
                                                    {$csv_data[ii].price_from|floatval}
                                                </td>
                                                <td class="center">
                                                    {$csv_data[ii].price_to|floatval}
                                                </td>
                                                <td class="center">
                                                    {$csv_data[ii].weight_from|floatval}
                                                </td>
                                                <td class="center">
                                                    {$csv_data[ii].weight_to|floatval}
                                                </td>
                                                <td class="center">
                                                    {$csv_data[ii].parcel_price|escape:'htmlall':'UTF-8'}
                                                </td>
                                                <td class="center">
                                                    {$csv_data[ii].id_carrier|escape:'htmlall':'UTF-8'}
                                                </td>
                                                <td class="center">
                                                    {$csv_data[ii].cod_price|escape:'htmlall':'UTF-8'}
                                                </td>
                                            </tr>
                                        {/section}
                                    {else}
                                        <tr>
                                            <td colspan="8" class="center">
                                                {l s='No prices' mod='dpdpoland'}
                                            </td>
                                        </tr>
                                    {/if}
                                </tbody>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input type="submit" {if !isset($csv_data) || isset($csv_data) && empty($csv_data)}disabled="disabled"{/if} class="button" name="{DpdPolandCSVController::SETTINGS_DELETE_CSV_ACTION}" value="{l s='Delete all prices' mod='dpdpoland'}" />
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </fieldset>
</form>