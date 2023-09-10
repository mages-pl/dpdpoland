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
	var dpdpoland_packages_ids = "{Context::getContext()->cookie->dpdpoland_packages_ids|escape:'htmlall':'UTF-8'}";

	$(document).ready(function(){
		$("table.Packages .datepicker").datepicker({
			prevText: '',
			nextText: '',
			dateFormat: 'yy-mm-dd'
		});

		$('table#packages .filter').keypress(function(event){
			formSubmit(event, 'submitFilterButtonPackages');
		});

		if (dpdpoland_packages_ids)
		{
			window.location = window.location + '&printManifest';
		}
	});

	function sendDpdPolandBulkAction(form, action) {
		String.prototype.splice = function(index, remove, string) {
			return (this.slice(0, index) + string + this.slice(index + Math.abs(remove)));
		};

		var form_action = $(form).attr('action');

		form_action = form_action.replace('&printLabelsLabelFormat', '').replace('&printLabelsA4Format', '');

		if (form_action.replace(/(?:(?:^|\n)\s+|\s+(?:$|\n))/g,'').replace(/\s+/g,' ') == '')
			return false;

		if (form_action.indexOf('#') == -1)
			$(form).attr('action', form_action + '&' + action);
		else
			$(form).attr('action', form_action.splice(form_action.lastIndexOf('&'), 0, '&' + action));

		$(form).submit();
	}
</script>
<script type="text/javascript">
	$(function() {
		$('table#packages .filter').keypress(function(e){
			var key = (e.keyCode ? e.keyCode : e.which);
			if (key == 13)
			{
				e.preventDefault();
				formSubmit(event, 'submitFilterButtonPackages');
			}
		});
		$('#submitFilterButtonPackages').click(function() {
			$('#submitFilterPackages').val(1);
			$('#packages_form').submit();
		});
	});
</script>

<form id="packages_form" class="form-horizontal clearfix" action="{$full_url|escape:'htmlall':'UTF-8'}" method="post">
	<input type="hidden" value="0" name="submitFilterButtonPackages" id="submitFilterPackages" />
	<div class="panel col-lg-12">
		<div class="panel-heading">
			{l s='Packages' mod='dpdpoland'}
			<span class="badge">{$list_total|escape:'htmlall':'UTF-8'}</span>
		</div>

		<div class="table-responsive clearfix">
			<table id="packages" class="table Packages">
				<thead>
					<tr class="nodrag nodrop">
						<th class="center fixed-width-xs">
							&nbsp;
						</th>
						<th>
							<span class="title_box{if $order_by == 'date_add'} active{/if}">
								{l s='Printout date' mod='dpdpoland'}
								<a{if $order_by == 'date_add' && $order_way == 'desc'} class="active"{/if} href="{$full_url|escape:'htmlall':'UTF-8'}&PackagesOrderBy=date_add&PackagesOrderWay=desc">
									<i class="icon-caret-down"></i>
								</a>
								<a{if $order_by == 'date_add' && $order_way == 'asc'} class="active"{/if} href="{$full_url|escape:'htmlall':'UTF-8'}&PackagesOrderBy=date_add&PackagesOrderWay=asc">
									<i class="icon-caret-up"></i>
								</a>
							</span>
						</th>
						<th class="left">
							<span class="title_box{if $order_by == 'id_order'} active{/if}">
								{l s='Order number' mod='dpdpoland'}
								<a{if $order_by == 'id_order' && $order_way == 'desc'} class="active"{/if} href="{$full_url|escape:'htmlall':'UTF-8'}&PackagesOrderBy=id_order&PackagesOrderWay=desc">
									<i class="icon-caret-down"></i>
								</a>
								<a{if $order_by == 'id_order' && $order_way == 'asc'} class="active"{/if} href="{$full_url|escape:'htmlall':'UTF-8'}&PackagesOrderBy=id_order&PackagesOrderWay=asc">
									<i class="icon-caret-up"></i>
								</a>
							</span>
						</th>
						<th>
							<span class="title_box{if $order_by == 'package_number'} active{/if}">
								{l s='Package number' mod='dpdpoland'}
								<a{if $order_by == 'package_number' && $order_way == 'desc'} class="active"{/if} href="{$full_url|escape:'htmlall':'UTF-8'}&PackagesOrderBy=package_number&PackagesOrderWay=desc">
									<i class="icon-caret-down"></i>
								</a>
								<a{if $order_by == 'package_number' && $order_way == 'asc'} class="active"{/if} href="{$full_url|escape:'htmlall':'UTF-8'}&PackagesOrderBy=package_number&PackagesOrderWay=asc">
									<i class="icon-caret-up"></i>
								</a>
							</span>
						</th>
						<th class="fixed-width-xs center">
							<span class="title_box{if $order_by == 'count_parcel'} active{/if}">
								{l s='Number of Parcels' mod='dpdpoland'}
								<a{if $order_by == 'count_parcel' && $order_way == 'desc'} class="active"{/if} href="{$full_url|escape:'htmlall':'UTF-8'}&PackagesOrderBy=count_parcel&PackagesOrderWay=desc">
									<i class="icon-caret-down"></i>
								</a>
								<a{if $order_by == 'count_parcel' && $order_way == 'asc'} class="active"{/if} href="{$full_url|escape:'htmlall':'UTF-8'}&PackagesOrderBy=count_parcel&PackagesOrderWay=asc">
									<i class="icon-caret-up"></i>
								</a>
							</span>
						</th>
						<th>
							<span class="title_box{if $order_by == 'receiver'} active{/if}">
								{l s='Receiver' mod='dpdpoland'}
								<a{if $order_by == 'receiver' && $order_way == 'desc'} class="active"{/if} href="{$full_url|escape:'htmlall':'UTF-8'}&PackagesOrderBy=receiver&PackagesOrderWay=desc">
									<i class="icon-caret-down"></i>
								</a>
								<a{if $order_by == 'receiver' && $order_way == 'asc'} class="active"{/if} href="{$full_url|escape:'htmlall':'UTF-8'}&PackagesOrderBy=receiver&PackagesOrderWay=asc">
									<i class="icon-caret-up"></i>
								</a>
							</span>
						</th>
						<th>
							<span class="title_box{if $order_by == 'country'} active{/if}">
								{l s='Country' mod='dpdpoland'}
								<a{if $order_by == 'country' && $order_way == 'desc'} class="active"{/if} href="{$full_url|escape:'htmlall':'UTF-8'}&PackagesOrderBy=country&PackagesOrderWay=desc">
									<i class="icon-caret-down"></i>
								</a>
								<a{if $order_by == 'country' && $order_way == 'asc'} class="active"{/if} href="{$full_url|escape:'htmlall':'UTF-8'}&PackagesOrderBy=country&PackagesOrderWay=asc">
									<i class="icon-caret-up"></i>
								</a>
							</span>
						</th>
						<th class="fixed-width-xs center">
							<span class="title_box{if $order_by == 'postcode'} active{/if}">
								{l s='Postal code' mod='dpdpoland'}
								<a{if $order_by == 'postcode' && $order_way == 'desc'} class="active"{/if} href="{$full_url|escape:'htmlall':'UTF-8'}&PackagesOrderBy=postcode&PackagesOrderWay=desc">
									<i class="icon-caret-down"></i>
								</a>
								<a{if $order_by == 'postcode' && $order_way == 'asc'} class="active"{/if} href="{$full_url|escape:'htmlall':'UTF-8'}&PackagesOrderBy=postcode&PackagesOrderWay=asc">
									<i class="icon-caret-up"></i>
								</a>
							</span>
						</th>
						<th>
							<span class="title_box{if $order_by == 'city'} active{/if}">
								{l s='City' mod='dpdpoland'}
								<a{if $order_by == 'city' && $order_way == 'desc'} class="active"{/if} href="{$full_url|escape:'htmlall':'UTF-8'}&PackagesOrderBy=city&PackagesOrderWay=desc">
									<i class="icon-caret-down"></i>
								</a>
								<a{if $order_by == 'city' && $order_way == 'asc'} class="active"{/if} href="{$full_url|escape:'htmlall':'UTF-8'}&PackagesOrderBy=city&PackagesOrderWay=asc">
									<i class="icon-caret-up"></i>
								</a>
							</span>
						</th>
						<th>
							<span class="title_box{if $order_by == 'address'} active{/if}">
								{l s='Address' mod='dpdpoland'}
								<a{if $order_by == 'address' && $order_way == 'desc'} class="active"{/if} href="{$full_url|escape:'htmlall':'UTF-8'}&PackagesOrderBy=address&PackagesOrderWay=desc">
									<i class="icon-caret-down"></i>
								</a>
								<a{if $order_by == 'address' && $order_way == 'asc'} class="active"{/if} href="{$full_url|escape:'htmlall':'UTF-8'}&PackagesOrderBy=address&PackagesOrderWay=asc">
									<i class="icon-caret-up"></i>
								</a>
							</span>
						</th>

						<th>
							<span class="title_box{if $order_by == 'ref1'} active{/if}">
								{l s='Ref1' mod='dpdpoland'}
								<a{if $order_by == 'ref1' && $order_way == 'desc'} class="active"{/if} href="{$full_url|escape:'htmlall':'UTF-8'}&PackagesOrderBy=ref1&PackagesOrderWay=desc">
									<i class="icon-caret-down"></i>
								</a>
								<a{if $order_by == 'ref1' && $order_way == 'asc'} class="active"{/if} href="{$full_url|escape:'htmlall':'UTF-8'}&PackagesOrderBy=ref1&PackagesOrderWay=asc">
									<i class="icon-caret-up"></i>
								</a>
							</span>
						</th>

						<th>
							<span class="title_box{if $order_by == 'ref2'} active{/if}">
								{l s='Ref2' mod='dpdpoland'}
								<a{if $order_by == 'ref2' && $order_way == 'desc'} class="active"{/if} href="{$full_url|escape:'htmlall':'UTF-8'}&PackagesOrderBy=ref2&PackagesOrderWay=desc">
									<i class="icon-caret-down"></i>
								</a>
								<a{if $order_by == 'ref2' && $order_way == 'asc'} class="active"{/if} href="{$full_url|escape:'htmlall':'UTF-8'}&PackagesOrderBy=ref2&PackagesOrderWay=asc">
									<i class="icon-caret-up"></i>
								</a>
							</span>
						</th>

						<th>
							<span class="title_box{if $order_by == 'additional_info'} active{/if}">
								{l s='Additional info' mod='dpdpoland'}
								<a{if $order_by == 'additional_info' && $order_way == 'desc'} class="active"{/if} href="{$full_url|escape:'htmlall':'UTF-8'}&PackagesOrderBy=additional_info&PackagesOrderWay=desc">
									<i class="icon-caret-down"></i>
								</a>
								<a{if $order_by == 'additional_info' && $order_way == 'asc'} class="active"{/if} href="{$full_url|escape:'htmlall':'UTF-8'}&PackagesOrderBy=additional_info&PackagesOrderWay=asc">
									<i class="icon-caret-up"></i>
								</a>
							</span>
						</th>
						<th></th>
					</tr>
					<tr class="nodrag nodrop filter row_hover">
						<th class="text-center">
							--
						</th>
						<th class="text-right">
							<div class="date_range row">
								<div class="input-group fixed-width-md">
									<input type="text" placeholder="{l s='From' mod='dpdpoland'}" name="PackagesFilter_date_add[0]" id="PackagesFilter_date_add_0" class="filter datepicker">
									<span class="input-group-addon">
										<i class="icon-calendar"></i>
									</span>
								</div>
								<div class="input-group fixed-width-md">
									<input type="text" placeholder="{l s='To' mod='dpdpoland'}" name="PackagesFilter_date_add[1]" id="PackagesFilter_date_add_1" class="filter datepicker">
									<span class="input-group-addon">
										<i class="icon-calendar"></i>
									</span>
								</div>
							</div>
						</th>
						<th class="center">
							<input class="filter" type="text" value="{if Context::getContext()->cookie->__isset('PackagesFilter_id_order') && Context::getContext()->cookie->PackagesFilter_id_order}{Context::getContext()->cookie->PackagesFilter_id_order}{/if}" name="PackagesFilter_id_order" />
						</th>
						<th>
							<input class="filter" type="text" value="{if Context::getContext()->cookie->__isset('PackagesFilter_package_number') && Context::getContext()->cookie->PackagesFilter_package_number}{Context::getContext()->cookie->PackagesFilter_package_number}{/if}" name="PackagesFilter_package_number">
						</th>
						<th>
							<input class="filter" type="text" value="{if Context::getContext()->cookie->__isset('PackagesFilter_count_parcel') && Context::getContext()->cookie->PackagesFilter_count_parcel}{Context::getContext()->cookie->PackagesFilter_count_parcel}{/if}" name="PackagesFilter_count_parcel">
						</th>
						<th>
							<input class="filter" type="text" value="{if Context::getContext()->cookie->__isset('PackagesFilter_receiver') && Context::getContext()->cookie->PackagesFilter_receiver}{Context::getContext()->cookie->PackagesFilter_receiver}{/if}" name="PackagesFilter_receiver">
						</th>
						<th>
							<input class="filter" type="text" value="{if Context::getContext()->cookie->__isset('PackagesFilter_country') && Context::getContext()->cookie->PackagesFilter_country}{Context::getContext()->cookie->PackagesFilter_country}{/if}" name="PackagesFilter_country">
						</th>
						<th>
							<input class="filter" type="text" value="{if Context::getContext()->cookie->__isset('PackagesFilter_postcode') && Context::getContext()->cookie->PackagesFilter_postcode}{Context::getContext()->cookie->PackagesFilter_postcode}{/if}" name="PackagesFilter_postcode">
						</th>
						<th>
							<input class="filter" type="text" value="{if Context::getContext()->cookie->__isset('PackagesFilter_city') && Context::getContext()->cookie->PackagesFilter_city}{Context::getContext()->cookie->PackagesFilter_city}{/if}" name="PackagesFilter_city">
						</th>
						<th>
							<input class="filter" type="text" value="{if Context::getContext()->cookie->__isset('PackagesFilter_address') && Context::getContext()->cookie->PackagesFilter_address}{Context::getContext()->cookie->PackagesFilter_address}{/if}" name="PackagesFilter_address">
						</th>
						<th>
							<input class="filter" type="text" value="{if Context::getContext()->cookie->__isset('PackagesFilter_ref1') && Context::getContext()->cookie->PackagesFilter_address}{Context::getContext()->cookie->PackagesFilter_ref1}{/if}" name="PackagesFilter_ref1">
						</th>
						<th>
							<input class="filter" type="text" value="{if Context::getContext()->cookie->__isset('PackagesFilter_ref2') && Context::getContext()->cookie->PackagesFilter_address}{Context::getContext()->cookie->PackagesFilter_ref2}{/if}" name="PackagesFilter_ref2">
						</th>
						<th>
							<input class="filter" type="text" value="{if Context::getContext()->cookie->__isset('PackagesFilter_additional_info') && Context::getContext()->cookie->PackagesFilter_address}{Context::getContext()->cookie->PackagesFilter_additional_info}{/if}" name="PackagesFilter_additional_info">
						</th>
						<th class="actions">
							<span class="pull-right">
								<button id="submitFilterButtonPackages" class="btn btn-default" data-list-id="Packages" name="submitFilter" type="submit">
									<i class="icon-search"></i>
									{l s='Search' mod='dpdpoland'}
								</button>
								{if $filters_has_value}
									<button type="submit" name="submitResetPackages" class="btn btn-warning">
										<i class="icon-eraser"></i> {l s='Reset' mod='dpdpoland'}
									</button>
								{/if}
							</span>
						</th>
					</tr>
				</thead>
				<tbody>
					{if isset($table_data) && $table_data}
						{section name=ii loop=$table_data}
							<tr id="tr__{$table_data[ii].id_package_ws|escape:'htmlall':'UTF-8'}_0" class="odd">
								<td class="text-center fixed-width-xs center">
									<input class="noborder" type="checkbox" value="{$table_data[ii].id_package_ws|escape:'htmlall':'UTF-8'}" name="PackagesBox[]"{if isset($smarty.post.PackagesBox) && in_array($table_data[ii].id_package_ws, $smarty.post.PackagesBox)} checked="checked"{/if} />
								</td>
								<td class="pointer">
									{if $table_data[ii].date_add && $table_data[ii].date_add != '0000-00-00 00:00:00'}
										{$table_data[ii].date_add|escape:'htmlall':'UTF-8'}
									{else}
										--
									{/if}
								</td>
								<td class="pointer">
									{if $table_data[ii].id_order}
										{$table_data[ii].id_order|escape:'htmlall':'UTF-8'}
									{else}
										--
									{/if}
								</td>
								<td class="pointer">
									{if $table_data[ii].package_number}
										<a href="{$smarty.const._DPDPOLAND_TRACKING_URL_WITHOUT_AT_|escape:'htmlall':'UTF-8'}{$table_data[ii].package_number|escape:'htmlall':'UTF-8'}" target="_blank">{$table_data[ii].package_number|escape:'htmlall':'UTF-8'}</a>
									{else}
										--
									{/if}
								</td>
								<td class="pointer fixed-width-xs center">
									{if $table_data[ii].count_parcel}
										{$table_data[ii].count_parcel|escape:'htmlall':'UTF-8'}
									{else}
										--
									{/if}
								</td>
								<td class="pointer">
									{if $table_data[ii].receiver}
										{$table_data[ii].receiver|escape:'htmlall':'UTF-8'}
									{else}
										--
									{/if}
								</td>
								<td class="pointer center">
									{if $table_data[ii].country}
										{$table_data[ii].country|escape:'htmlall':'UTF-8'}
									{else}
										--
									{/if}
								</td>
								<td class="pointer fixed-width-xs center">
									{if $table_data[ii].postcode}
										{$table_data[ii].postcode|escape:'htmlall':'UTF-8'}
									{else}
										--
									{/if}
								</td>
								<td class="pointer center">
									{if $table_data[ii].city}
										{$table_data[ii].city|escape:'htmlall':'UTF-8'}
									{else}
										--
									{/if}
								</td>
								<td class="pointer center">
									{if $table_data[ii].address}
										{$table_data[ii].address|escape:'htmlall':'UTF-8'}
									{else}
										--
									{/if}
								</td>
								<td class="pointer center">
									{if $table_data[ii].ref1}
										{$table_data[ii].ref1|escape:'htmlall':'UTF-8'}
									{else}
										--
									{/if}
								</td>
								<td class="pointer center">
									{if $table_data[ii].ref2}
										{$table_data[ii].ref2|escape:'htmlall':'UTF-8'}
									{else}
										--
									{/if}
								</td>
								<td class="pointer center">
									{if $table_data[ii].additional_info}
										{$table_data[ii].additional_info|escape:'htmlall':'UTF-8'}
									{else}
										--
									{/if}
								</td>
								<td class="text-right">
									<div class="btn-group pull-right">
										<a class=" btn btn-default" title="View" href="{$order_link|escape:'htmlall':'UTF-8'}&id_order={$table_data[ii].id_order|escape:'htmlall':'UTF-8'}">
											<i class="icon-search-plus"></i>
											{l s='View' mod='dpdpoland'}
										</a>
									</div>
								</td>
							</tr>
						{/section}
					{else}
						<tr>
							<td colspan="11" class="list-empty">
								<div class="list-empty-msg">
									<i class="icon-warning-sign list-empty-icon"></i>
									{l s='No records found' mod='dpdpoland'}
								</div>
							</td>
						</tr>
					{/if}
				</tbody>
			</table>
		</div>
		<div class="row">
			<div class="col-lg-6">
				<div class="btn-group bulk-actions">
					<button class="btn btn-default dropdown-toggle" data-toggle="dropdown" type="button">
						{l s='Bulk actions' mod='dpdpoland'}
						<span class="caret"></span>
					</button>
					<ul class="dropdown-menu">
						<li>
							<a onclick="checkDelBoxes($(this).closest('form').get(0), 'PackagesBox[]', true);return false;" href="#">
								<i class="icon-check-sign"></i>
								{l s='Select all' mod='dpdpoland'}
							</a>
						</li>
						<li>
							<a onclick="checkDelBoxes($(this).closest('form').get(0), 'PackagesBox[]', false);return false;" href="#">
								<i class="icon-check-empty"></i>
								{l s='Unselect all' mod='dpdpoland'}
							</a>
						</li>
						<li class="divider"></li>
						<li>
							<a onclick="sendBulkAction($(this).closest('form').get(0), 'printManifest');" href="#">
								<i class="icon-download"></i>
								{l s='Manifest printout' mod='dpdpoland'}
							</a>
						</li>
						<li>
							<a onclick="sendDpdPolandBulkAction($(this).closest('form').get(0), 'printLabelsLabelFormat');" href="#">
								<i class="icon-download"></i>
								{l s='Label duplicate printout Label printer' mod='dpdpoland'}
							</a>
						</li>
						<li>
							<a onclick="sendDpdPolandBulkAction($(this).closest('form').get(0), 'printLabelsA4Format');" href="#">
								<i class="icon-download"></i>
								{l s='Label duplicate printout A4' mod='dpdpoland'}
							</a>
						</li>
					</ul>
				</div>
			</div>
			{include file=$smarty.const._DPDPOLAND_TPL_DIR_|cat:'admin/_pagination_16.tpl' identifier='Packages'}
		</div>
	</div>
</form>