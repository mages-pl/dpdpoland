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
<script>
	$(document).ready(function(){
		$("table.ParcelHistories .datepicker").datepicker({
			prevText: '',
			nextText: '',
			dateFormat: 'yy-mm-dd'
		});
		
		$('table#parcel_history_list .filter').keypress(function(event){
			formSubmit(event, 'submitFilterButtonParcelHistories');
		})
	});
</script>

<form class="form" action="{$full_url|escape:'htmlall':'UTF-8'}" method="post">
    <input type="hidden" value="0" name="submitFilterParcelHistories" id="submitFilterParcelHistories">
    <table id="parcel_history_list" name="list_table" class="table_grid">
        <tbody>
            <tr>
                <td class="bottom">
                    <span class="float-left">
                        {if $page > 1}
                            <input type="image" src="../img/admin/list-prev2.gif" onclick="getE('submitFilterParcelHistories').value=1"/>&nbsp;
                            <input type="image" src="../img/admin/list-prev.gif" onclick="getE('submitFilterParcelHistories').value=;{$page|escape:'htmlall':'UTF-8' - 1}"/>
                        {/if}
                        {l s='Page' mod='dpdpoland'} <b>{$page|escape:'htmlall':'UTF-8'}</b> / {$total_pages|escape:'htmlall':'UTF-8'}
                        {if $page < $total_pages}
                            <input type="image" src="../img/admin/list-next.gif" onclick="getE('submitFilterParcelHistories').value=;{$page|escape:'htmlall':'UTF-8' + 1}"/>&nbsp;
                            <input type="image" src="../img/admin/list-next2.gif" onclick="getE('submitFilterParcelHistories').value=;{$total_pages|escape:'htmlall':'UTF-8'}"/>
                        {/if}
                        | {l s='Display' mod='dpdpoland'}
                        <select name="pagination" onchange="submit()">
                            {foreach from=$pagination item=value}
                                <option value="{$value|intval|escape:'htmlall':'UTF-8'}"{if $selected_pagination == $value} selected="selected" {elseif $selected_pagination == NULL && $value == $pagination[1]} selected="selected2"{/if}>{$value|intval|escape:'htmlall':'UTF-8'}</option>
                            {/foreach}
                        </select>
                        / {$list_total|escape:'htmlall':'UTF-8'} {l s='result(s)' mod='dpdpoland'}
                    </span>
                    <span class="float-right">
                        <input type="submit" class="button" value="{l s='Filter' mod='dpdpoland'}" name="submitFilterButtonParcelHistories" id="submitFilterButtonParcelHistories">
                        <input type="submit" class="button" value="{l s='Reset' mod='dpdpoland'}" name="submitResetParcelHistories">
                    </span>
                    <span class="clear"></span>
                </td>
            </tr>
            <tr>
                <td>
                    <table cellspacing="0" cellpadding="0" class="table ParcelHistories">
                        <colgroup>
                            <col width="100px">
                            <col width="100px">
                            <col width="140px">
							<col width="140px">
                            <col width="80px">
                            <col width="100px">
                            <col>
							<col width="140px">
                            <col width="30px">
                        </colgroup>
                        <thead>
                            <tr class="nodrag nodrop titles-row">
                                <th class="center">
									<span class="title_box">
										{l s='Order ID' mod='dpdpoland'}
									</span>
                                    <br>
                                    <a href="{$full_url|escape:'htmlall':'UTF-8'}&ParcelHistoriesOrderBy=id_order&ParcelHistoriesOrderWay=desc">
                                        {if $order_by == 'id_order' && $order_way == 'desc'}
                                            <img border="0" src="../img/admin/down_d.gif">
                                        {else}
                                            <img border="0" src="../img/admin/down.gif">
                                        {/if}
                                    </a>
                                    <a href="{$full_url|escape:'htmlall':'UTF-8'}&ParcelHistoriesOrderBy=id_order&ParcelHistoriesOrderWay=asc">
                                        {if $order_by == 'id_order' && $order_way == 'asc'}
                                            <img border="0" src="../img/admin/up_d.gif">
                                        {else}
                                            <img border="0" src="../img/admin/up.gif">
                                        {/if}
                                    </a>
                                </th>
                                <th class="center">
									<span class="title_box">
										{l s='Parcel Number' mod='dpdpoland'}
									</span>
                                    <br>
                                    <a href="{$full_url|escape:'htmlall':'UTF-8'}&ParcelHistoriesOrderBy=id_parcel&ParcelHistoriesOrderWay=desc">
                                        {if $order_by == 'id_parcel' && $order_way == 'desc'}
                                            <img border="0" src="../img/admin/down_d.gif">
                                        {else}
                                            <img border="0" src="../img/admin/down.gif">
                                        {/if}
                                    </a>
                                    <a href="{$full_url|escape:'htmlall':'UTF-8'}&ParcelHistoriesOrderBy=id_parcel&ParcelHistoriesOrderWay=asc">
                                        {if $order_by == 'id_parcel' && $order_way == 'asc'}
                                            <img border="0" src="../img/admin/up_d.gif">
                                        {else}
                                            <img border="0" src="../img/admin/up.gif">
                                        {/if}
                                    </a>
                                </th>
                                <th class="center">
									<span class="title_box">
										{l s='Receiver' mod='dpdpoland'}
									</span>
                                    <br>
                                    <a href="{$full_url|escape:'htmlall':'UTF-8'}&ParcelHistoriesOrderBy=receiver&ParcelHistoriesOrderWay=desc">
                                        {if $order_by == 'receiver' && $order_way == 'desc'}
                                            <img border="0" src="../img/admin/down_d.gif">
                                        {else}
                                            <img border="0" src="../img/admin/down.gif">
                                        {/if}
                                    </a>
                                    <a href="{$full_url|escape:'htmlall':'UTF-8'}&ParcelHistoriesOrderBy=receiver&ParcelHistoriesOrderWay=asc">
                                        {if $order_by == 'receiver' && $order_way == 'asc'}
                                            <img border="0" src="../img/admin/up_d.gif">
                                        {else}
                                            <img border="0" src="../img/admin/up.gif">
                                        {/if}
                                    </a>
                                </th>
								<th class="center">
									<span class="title_box">
										{l s='Country' mod='dpdpoland'}
									</span>
                                    <br>
                                    <a href="{$full_url|escape:'htmlall':'UTF-8'}&ParcelHistoriesOrderBy=country&ParcelHistoriesOrderWay=desc">
                                        {if $order_by == 'country' && $order_way == 'desc'}
                                            <img border="0" src="../img/admin/down_d.gif">
                                        {else}
                                            <img border="0" src="../img/admin/down.gif">
                                        {/if}
                                    </a>
                                    <a href="{$full_url|escape:'htmlall':'UTF-8'}&ParcelHistoriesOrderBy=country&ParcelHistoriesOrderWay=asc">
                                        {if $order_by == 'country' && $order_way == 'asc'}
                                            <img border="0" src="../img/admin/up_d.gif">
                                        {else}
                                            <img border="0" src="../img/admin/up.gif">
                                        {/if}
                                    </a>
                                </th>
                                <th class="center">
									<span class="title_box">
										{l s='Postal code' mod='dpdpoland'}
									</span>
                                    <br>
                                    <a href="{$full_url|escape:'htmlall':'UTF-8'}&ParcelHistoriesOrderBy=postcode&ParcelHistoriesOrderWay=desc">
                                        {if $order_by == 'postcode' && $order_way == 'desc'}
                                            <img border="0" src="../img/admin/down_d.gif">
                                        {else}
                                            <img border="0" src="../img/admin/down.gif">
                                        {/if}
                                    </a>
                                    <a href="{$full_url|escape:'htmlall':'UTF-8'}&ParcelHistoriesOrderBy=postcode&ParcelHistoriesOrderWay=asc">
                                        {if $order_by == 'postcode' && $order_way == 'asc'}
                                            <img border="0" src="../img/admin/up_d.gif">
                                        {else}
                                            <img border="0" src="../img/admin/up.gif">
                                        {/if}
                                    </a>
                                </th>
                                <th class="center">
									<span class="title_box">
										{l s='City' mod='dpdpoland'}
									</span>
                                    <br>
                                    <a href="{$full_url|escape:'htmlall':'UTF-8'}&ParcelHistoriesOrderBy=city&ParcelHistoriesOrderWay=desc">
                                        {if $order_by == 'city' && $order_way == 'desc'}
                                            <img border="0" src="../img/admin/down_d.gif">
                                        {else}
                                            <img border="0" src="../img/admin/down.gif">
                                        {/if}
                                    </a>
                                    <a href="{$full_url|escape:'htmlall':'UTF-8'}&ParcelHistoriesOrderBy=city&ParcelHistoriesOrderWay=asc">
                                        {if $order_by == 'city' && $order_way == 'asc'}
                                            <img border="0" src="../img/admin/up_d.gif">
                                        {else}
                                            <img border="0" src="../img/admin/up.gif">
                                        {/if}
                                    </a>
                                </th>
                                <th class="center">
									<span class="title_box">
										{l s='Address' mod='dpdpoland'}
									</span>
                                    <br>
                                    <a href="{$full_url|escape:'htmlall':'UTF-8'}&ParcelHistoriesOrderBy=address&ParcelHistoriesOrderWay=desc">
                                        {if $order_by == 'address' && $order_way == 'desc'}
                                            <img border="0" src="../img/admin/down_d.gif">
                                        {else}
                                            <img border="0" src="../img/admin/down.gif">
                                        {/if}
                                    </a>
                                    <a href="{$full_url|escape:'htmlall':'UTF-8'}&ParcelHistoriesOrderBy=address&ParcelHistoriesOrderWay=asc">
                                        {if $order_by == 'address' && $order_way == 'asc'}
                                            <img border="0" src="../img/admin/up_d.gif">
                                        {else}
                                            <img border="0" src="../img/admin/up.gif">
                                        {/if}
                                    </a>
                                </th>
								<th class="center">
                                    <span class="title_box">
                                        {l s='Shipment date' mod='dpdpoland'}
                                    </span>
                                    <br>
                                    <a href="{$full_url|escape:'htmlall':'UTF-8'}&ParcelHistoriesOrderBy=date_add&ParcelHistoriesOrderWay=desc">
                                        {if $order_by == 'date_add' && $order_way == 'desc'}
                                            <img border="0" src="../img/admin/down_d.gif">
                                        {else}
                                            <img border="0" src="../img/admin/down.gif">
                                        {/if}
                                    </a>
                                    <a href="{$full_url|escape:'htmlall':'UTF-8'}&ParcelHistoriesOrderBy=date_add&ParcelHistoriesOrderWay=asc">
                                        {if $order_by == 'date_add' && $order_way == 'asc'}
                                            <img border="0" src="../img/admin/up_d.gif">
                                        {else}
                                            <img border="0" src="../img/admin/up.gif">
                                        {/if}
                                    </a>
                                </th>
                                <th class="center">
                                    <span class="title_box">
                                        {l s='Actions' mod='dpdpoland'}<br>&nbsp;
                                    </span>
                                    <br>
                                </th>
                            </tr>
                            <tr class="nodrag nodrop filter row_hover filter-row">
                                <td class="center">
                                    <input type="text" value="{if Context::getContext()->cookie->__isset('ParcelHistoriesFilter_id_order') && Context::getContext()->cookie->ParcelHistoriesFilter_id_order}{Context::getContext()->cookie->ParcelHistoriesFilter_id_order}{/if}" name="ParcelHistoriesFilter_id_order" class="filter">
                                </td>
                                <td class="center">
                                    <input type="text" value="{if Context::getContext()->cookie->__isset('ParcelHistoriesFilter_id_parcel') && Context::getContext()->cookie->ParcelHistoriesFilter_id_parcel}{Context::getContext()->cookie->ParcelHistoriesFilter_id_parcel}{/if}" name="ParcelHistoriesFilter_id_parcel" class="filter">
                                </td>
                                <td class="right">
                                    <input type="text" value="{if Context::getContext()->cookie->__isset('ParcelHistoriesFilter_receiver') && Context::getContext()->cookie->ParcelHistoriesFilter_receiver}{Context::getContext()->cookie->ParcelHistoriesFilter_receiver}{/if}" name="ParcelHistoriesFilter_receiver" class="filter">
                                </td>
								<td class="right">
                                    <input type="text" value="{if Context::getContext()->cookie->__isset('ParcelHistoriesFilter_country') && Context::getContext()->cookie->ParcelHistoriesFilter_country}{Context::getContext()->cookie->ParcelHistoriesFilter_country}{/if}" name="ParcelHistoriesFilter_country" class="filter">
                                </td>
                                <td class="right">
                                    <input type="text" value="{if Context::getContext()->cookie->__isset('ParcelHistoriesFilter_postcode') && Context::getContext()->cookie->ParcelHistoriesFilter_postcode}{Context::getContext()->cookie->ParcelHistoriesFilter_postcode}{/if}" name="ParcelHistoriesFilter_postcode" class="filter">
                                </td>
                                <td class="right">
                                    <input type="text" value="{if Context::getContext()->cookie->__isset('ParcelHistoriesFilter_city') && Context::getContext()->cookie->ParcelHistoriesFilter_city}{Context::getContext()->cookie->ParcelHistoriesFilter_city}{/if}" name="ParcelHistoriesFilter_city" class="filter">
                                </td>
                                <td class="right">
                                    <input type="text" value="{if Context::getContext()->cookie->__isset('ParcelHistoriesFilter_address') && Context::getContext()->cookie->ParcelHistoriesFilter_address}{Context::getContext()->cookie->ParcelHistoriesFilter_address}{/if}" name="ParcelHistoriesFilter_address" class="filter">
                                </td>
								<td class="right">
                                    {l s='From' mod='dpdpoland'} <input type="text" value="" name="ParcelHistoriesFilter_date_add[0]" id="ParcelHistoriesFilter_date_add_0" class="filter datepicker">
                                    <br>
                                    {l s='To' mod='dpdpoland'} <input type="text" value="" name="ParcelHistoriesFilter_date_add[1]" id="ParcelHistoriesFilter_date_add_1" class="filter datepicker">
                                </td>
                                <td class="center">
                                    --
                                </td>
                            </tr>
                        </thead>
                        <tbody>
                            {if isset($table_data) && $table_data}
                                {section name=ii loop=$table_data}
                                    <tr class="row_hover" id="tr_{$smarty.section.ii.index|escape:'htmlall':'UTF-8' + 1}_{$table_data[ii].id_order|escape:'htmlall':'UTF-8'}_0">
                                        <td class="center">
                                            {if $table_data[ii].id_order}
                                                {$table_data[ii].id_order|escape:'htmlall':'UTF-8'}
                                            {else}
                                                --
                                            {/if}
                                        </td>
                                        <td class="center">
                                            {if $table_data[ii].id_parcel}
                                                {$table_data[ii].id_parcel|escape:'htmlall':'UTF-8'}
                                            {else}
                                                --
                                            {/if}
                                        </td>
                                        <td class="center">
                                            {if $table_data[ii].receiver}
                                                {$table_data[ii].receiver|escape:'htmlall':'UTF-8'}
                                            {else}
                                                --
                                            {/if}
                                        </td>
										<td class="center">
                                            {if $table_data[ii].country}
                                                {$table_data[ii].country|escape:'htmlall':'UTF-8'}
                                            {else}
                                                --
                                            {/if}
                                        </td>
                                        <td class="center">
                                            {if $table_data[ii].postcode}
                                                {$table_data[ii].postcode|escape:'htmlall':'UTF-8'}
                                            {else}
                                                --
                                            {/if}
                                        </td>
                                        <td class="center">
                                            {if $table_data[ii].city}
                                                {$table_data[ii].city|escape:'htmlall':'UTF-8'}
                                            {else}
                                                --
                                            {/if}
                                        </td>
                                        <td class="center">
                                            {if $table_data[ii].address}
                                                {$table_data[ii].address|escape:'htmlall':'UTF-8'}
                                            {else}
                                                --
                                            {/if}
                                        </td>
										<td class="center">
                                            {if $table_data[ii].date_add && $table_data[ii].date_add != '0000-00-00 00:00:00'}
                                                {$table_data[ii].date_add|escape:'htmlall':'UTF-8'}
                                            {else}
                                                --
                                            {/if}
                                        </td>
                                        <td class="center parcel-history-list-buttons">
                                            <a target="_blank" title="{l s='View' mod='dpdpoland'}" href="{$tracking_link|escape:'htmlall':'UTF-8'}{$table_data[ii].id_parcel|escape:'htmlall':'UTF-8'}">
                                                <img alt="{l s='View' mod='dpdpoland'}" src="../img/admin/details.gif">
                                            </a>
                                        </td>
                                    </tr>
                                {/section}
                            {else}
                                <tr>
                                    <td colspan="9" class="center">
                                        {l s='No parcels history' mod='dpdpoland'}
                                    </td>
                                </tr>
                            {/if}
                        </tbody>
                    </table>
                </td>
            </tr>
        </tbody>
    </table>
</form>