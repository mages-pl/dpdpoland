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
<br/>
{if $displayBlock}
    <script>
        var dpdpoland_ajax_uri = '{$dpdpoland_ajax_uri|escape:'htmlall':'UTF-8'}';
        var dpdpoland_pdf_uri = '{$smarty.const._DPDPOLAND_PDF_URI_|escape:'htmlall':'UTF-8'}';
        var dpdpoland_token = '{$dpdpoland_token|escape:'htmlall':'UTF-8'}';
        var dpdpoland_id_shop = '{$dpdpoland_id_shop|escape:'htmlall':'UTF-8'}';
        var dpdpoland_id_lang = '{$dpdpoland_id_lang|escape:'htmlall':'UTF-8'}';
        var _DPDPOLAND_DIMENTION_WEIGHT_DIVISOR_ = '{$smarty.const._DPDPOLAND_DIMENTION_WEIGHT_DIVISOR_|escape:'htmlall':'UTF-8'}';
        var id_package_ws = '{$package->id_package_ws|escape:'htmlall':'UTF-8'}';
        var _PS_ADMIN_DIR_ = '{$smarty.const._PS_ADMIN_DIR_|regex_replace:"/\\\/":"\\\\\\"}';
        var dpdpoland_parcels_error_message = "{l s='All products should be assigned to a particular parcel!' mod='dpdpoland'}";
        var modified_field_message = "{l s='Modified field' mod='dpdpoland'}";
        var redirect_and_open = '{$redirect_and_open|escape:'htmlall':'UTF-8'}';
        var printout_format = '{$printout_format|escape:'htmlall':'UTF-8'}';
        var current_order_uri = '{$dpdpoland_order_uri|escape:'htmlall':'UTF-8'}';

        {if (isset($ps14) && $ps14 || isset($ps17) && $ps17)}
        var id_order = '{Tools::getValue('id_order')|escape:'htmlall':'UTF-8'}';
        {/if}

        $(document).ready(function () {
            {if isset($smarty.get.scrollToShipment)}
            $([document.documentElement, document.body]).animate({
                scrollTop: $("#dpdpoland").offset().top - 150
            }, 400);
            {/if}
        });
    </script>
    <div class="card col-lg-12 col-xl-8 mt-2 d-print-none">
        <div class="card-body">
            <div class="panel dpdpoland-ps16" id="dpdpoland">
                <div class="panel-heading">
                    <img src="{$smarty.const._DPDPOLAND_MODULE_URI_|escape:'htmlall':'UTF-8'}logo.gif" width="16"
                         height="16"> {l s='DPD Polska Sp. z o.o. shipping' mod='dpdpoland'}
                    <span class="badge"><a href="javascript:toggleShipmentCreationDisplay()"
                                           rel="[ {l s='collapse' mod='dpdpoland'} ]">[ {l s='expand' mod='dpdpoland'} ]</a></span>
                </div>

                {if $smarty.const._DPDPOLAND_DEBUG_MODE_}
                    <div class="alert alert-warning">
                        {l s='Module is in DEBUG mode' mod='dpdpoland'}
                        {if DpdPoland::getConfig(DpdPolandWS::DEBUG_FILENAME)}
                            <br>
                            <strong>
                                <a target="_blank"
                                   href="{$smarty.const._DPDPOLAND_MODULE_URI_|escape:'htmlall':'UTF-8'}{DpdPoland::getConfig(DpdPolandWS::DEBUG_FILENAME)}">
                                    {l s='View debug file' mod='dpdpoland'}
                                </a>
                            </strong>
                        {/if}
                    </div>
                {/if}

                <div id="dpdpoland_shipment_creation"{if isset($smarty.get.scrollToShipment)} class="displayed-element"{/if}>
                    <div id="dpdpoland_msg_container">{if isset($errors) && $errors}{include file=$smarty.const._PS_MODULE_DIR_|cat:'dpdpoland/views/templates/admin/errors.tpl'}{/if}</div>
                    {if isset($compatibility_warning_message) && $compatibility_warning_message}
                        <div class="alert alert-warning">
                            <p class="ml-2">{$compatibility_warning_message}</p>
                        </div>
                    {/if}
                    {if isset($address_warning_message) && $address_warning_message}
                        <div class="alert alert-warning">
                            <p class="ml-2">{$address_warning_message}</p>
                        </div>
                    {/if}

                    <div class="form-horizontal">
                        <div class="form-group">
                            <label for="dpdpoland_SessionType"
                                   class="control-label">{l s='Shipment mode:' mod='dpdpoland'}</label>
                            <div class="col-lg-9">
                                <select id="dpdpoland_SessionType" class="custom-select" name="dpdpoland_SessionType"
                                        autocomplete="off">
                                    <option value="domestic"{if (!empty($package->sessionType) && $package->sessionType == 'domestic') || (empty($package->sessionType) && $selected_id_method == $smarty.const._DPDPOLAND_STANDARD_ID_)} selected="selected"{/if}>{l s='DPD domestic shipment - Standard' mod='dpdpoland'}</option>
                                    <option value="domestic_with_cod"{if (!empty($package->sessionType) && $package->sessionType == 'domestic_with_cod') || (empty($package->sessionType) && $selected_id_method == $smarty.const._DPDPOLAND_STANDARD_COD_ID_)} selected="selected"{/if}>{l s='DPD domestic shipment - Standard with COD' mod='dpdpoland'}</option>
                                    <option value="international"{if (!empty($package->sessionType) && $package->sessionType == 'international') || (empty($package->sessionType) && $selected_id_method == $smarty.const._DPDPOLAND_CLASSIC_ID_)} selected="selected"{/if}>{l s='DPD international shipment (DPD Classic)' mod='dpdpoland'}</option>
                                    <option value="pudo"{if (!empty($package->sessionType) && $package->sessionType == 'pudo') || (empty($package->sessionType) && $selected_id_method == $smarty.const._DPDPOLAND_PUDO_ID_)} selected="selected"{/if}>{l s='DPD Poland Reception Point Pickup' mod='dpdpoland'}</option>
                                    <option value="pudo_cod"{if (!empty($package->sessionType) && $package->sessionType == 'pudo_cod') || (empty($package->sessionType) && $selected_id_method == $smarty.const._DPDPOLAND_PUDO_COD_ID_)} selected="selected"{/if}>{l s='DPD Poland Reception Point Pickup with COD' mod='dpdpoland'}</option>
                                </select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="dpdpoland_PayerNumber"
                                   class="control-label">{l s='DPD client number (Payer):' mod='dpdpoland'}</label>
                            <div class="col-lg-9">
                                <select class="custom-select client_number_select" id="dpdpoland_PayerNumber"
                                        name="dpdpoland_PayerNumber" autocomplete="off">
                                    {foreach from=$payerNumbers item=payerNumber}
                                        <option value="{$payerNumber.payer_number|escape:'htmlall':'UTF-8'}"{if $selectedPayerNumber == $payerNumber.payer_number} selected="selected"{/if}>{$payerNumber.payer_number|escape:'UTF-8'}</option>
                                    {/foreach}
                                </select>
                            </div>
                        </div>
                    </div>

                    <hr/>

                    <div class="row">
                        <div class="col-lg-6 col-xs-12">
                            <div class=" clearfix" id="dpdpoland_sender_address_container">
                                <h3>
                                    <i class="icon-user"></i>
                                    {l s='Sender' mod='dpdpoland'}
                                </h3>

                                <div class="form-group">
                                    <div class="col-lg-12 mt-1">
                                        <select class="custom-select col-lg-6 col-sm-6 col-xs-12"
                                                id="sender_address_selection" name="sender_address_selection"
                                                autocomplete="off">
                                            {foreach from=$sender_addresses item=address key=id_sender_address}
                                                <option value="{$id_sender_address}"{if $id_sender_address == $package->id_sender_address} selected="selected"{/if}>{$address}</option>
                                            {/foreach}
                                        </select>
                                    </div>

                                    <div class="dpdpoland_address info-block mt-1">
                                        {include file=$smarty.const._DPDPOLAND_TPL_DIR_|cat:'admin/address_17.tpl'}
                                    </div>

                                    <div class="alert alert-info">
                                        <p class="ml-1">{l s='Sender address are managed in module Sender addresses page.' mod='dpdpoland'}</p>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-6 col-xs-12">
                            <div class="clearfix" id="dpdpoland_recipient_address_container">
                                <h3>
                                    <i class="icon-user"></i>
                                    {l s='Recipient' mod='dpdpoland'}
                                </h3>

                                <div class="form-group mt-1">
                                    <div class="col-lg-12">
                                        <select class="custom-select col-lg-6 col-sm-6 col-xs-12"
                                                id="dpdpoland_recipient_address_selection"
                                                name="dpdpoland_id_address_delivery" autocomplete="off">
                                            {foreach from=$recipientAddresses item=address}
                                                {capture assign=address_title|escape:'htmlall':'UTF-8'}{$address['alias']|escape:'UTF-8'} - {$address['address1']|escape:'UTF-8'} {$address['postcode']|escape:'UTF-8'} {$address['city']|escape:'UTF-8'}{if !empty($address['state'])} {$address['state']|escape:'UTF-8'}{/if}, {$address['country']|escape:'UTF-8'}{/capture}
                                                <option value="{$address['id_address']|escape:'htmlall':'UTF-8'}"{if $address['id_address'] == $selectedRecipientIdAddress} selected="selected"{/if}>{$address_title|escape:'UTF-8'}</option>
                                            {/foreach}
                                        </select>
                                        <div class="dpdpoland_address info-block mt-1">
                                            {include file=$smarty.const._DPDPOLAND_TPL_DIR_|cat:'admin/address_input_17.tpl' address=$recipientAddress}
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <hr/>
                    <div class="pudo-map-container">
                        <div class="form-group col-xs-12 mb-10">
                            <label for="dpdpoland_pudo_code_input"
                                   class="form-check-label">{l s='Selected DPD Pickup' mod='dpdpoland'}</label>
                            <input class="form-control" type="text" id="dpdpoland_pudo_code_input"
                                   value="{$pudo_code}"/>
                        </div>
                        <script id="dpd-widget" type="text/javascript">
                            function pointSelected(pointID) {
                                $('#dpdpoland_pudo_code_input').val(pointID);
                            }
                        </script>

                        <script type="text/javascript"
                                src="//pudofinder.dpd.com.pl/source/dpd_widget.js?key=1ae3418e27627ab52bebdcc1a958fa04"></script>

                        <hr/>
                    </div>

                    <div class="form-horizontal">
                        <div class="form-group {if ($package->sessionType && $package->sessionType != 'domestic_with_cod') || (!$package->sessionType && $selected_id_method != $smarty.const._DPDPOLAND_STANDARD_COD_ID_)} hidden-element{/if}"
                             id="dpdpoland_cod_amount_container">
                            <label for="dpdpoland_COD_amount" class="control-label">
							<span title="" data-toggle="tooltip" class="label-tooltip"
                                  data-original-title="{l s='Enter the amount of COD' mod='dpdpoland'}">
								{l s='COD:' mod='dpdpoland'}
							</span>
                            </label>
                            <span class="input-group-addon mt-1 mr-2">{$smarty.const._DPDPOLAND_CURRENCY_ISO_|escape:'htmlall':'UTF-8'}</span>
                            <input type="text" name="dpdpoland_COD_amount" class="form-control" autocomplete="off"
                                   onchange="this.value = this.value.replace(/,/g, '.');"
                                   value="{if $package->cod_amount}{$package->cod_amount|escape:'htmlall':'UTF-8'}{else}{if isset($ps14) && $ps14}{Tools::convertPrice($order->total_paid_real, $currency_from, $currency_to)}{else}{Tools::convertPriceFull($order->total_paid_tax_incl, $currency_from, $currency_to)}{/if}{/if}"
                                   maxlength="14" size="11">
                        </div>

                        {if $settings->declared_value}
                            <div class="form-group" id="dpdpoland_declared_value_amount_container">
                                <label for="dpdpoland_DeclaredValue_amount" class="form-check-label">
								<span title="" data-toggle="tooltip" class="label-tooltip"
                                      data-original-title="{l s='Leave blank if service is not needed' mod='dpdpoland'}">
									{l s='Valuable parcel:' mod='dpdpoland'}
								</span>
                                </label>
                                <span class="input-group-addon mt-1 mr-2">{$smarty.const._DPDPOLAND_CURRENCY_ISO_|escape:'htmlall':'UTF-8'}</span>
                                <input type="text" name="dpdpoland_DeclaredValue_amount" class="form-control"
                                       autocomplete="off" onchange="this.value = this.value.replace(/,/g, '.');"
                                       value="{if $package->declaredValue_amount}{$package->declaredValue_amount}{else}{$order_price_pl}{/if}"
                                       maxlength="14" size="11">

                            </div>
                        {/if}

                        <div class="clearfix"></div>

                        {if $settings->duty}
                            <div class="form-group col-xs-12 mb-0">
                                <div class="form-check">
                                    <input id="dpdpoland_duty" type="checkbox" name="duty" class="form-check-input"
                                           value="1"{if $package->duty} checked="checked"{/if}>
                                    <label for="dpdpoland_duty"
                                           class="form-check-label">{l s='Duty' mod='dpdpoland'}</label>
                                </div>
                                <div id="dpdpoland_duty_container" class="d-none form-row ml-0 mr-0">
                                    <select class="form-control col-xs-12 col-md-1" name="dpdpoland_duty_currency">
                                        <option>PLN</option>
                                        <option>EUR</option>
                                        <option>USD</option>
                                        <option>CHF</option>
                                        <option>SEK</option>
                                        <option>NOK</option>
                                        <option>CZK</option>
                                        <option>RON</option>
                                        <option>HUF</option>
                                        <option>HRK</option>
                                        <option>BGN</option>
                                        <option>GBP</option>
                                        <option>RSD</option>
                                        <option>RUB</option>
                                        <option>TRY</option>
                                    </select>
                                    <input type="text" name="dpdpoland_duty_amount"
                                           class="form-control col-xs-12 col-md-11"
                                           autocomplete="off" onchange="this.value = this.value.replace(/,/g, '.');"
                                           value="{if $package->duty_amount}{$package->duty_amount}{else}{$order_price_pl}{/if}">
                                    <p class="mt-1">{l s='After generating the shipping number with DUTY service, you must completeing required informations on page:' mod='dpdpoland'}
                                        <a href="https://odprawacelna.dpd.com.pl">odprawacelna.dpd.com.pl</a>
                                    </p>
                                </div>
                            </div>
                        {/if}
                        {if $settings->cud}
                            <div class="form-check col-12">
                                <input class="form-check-input" type="checkbox" name="cud" id="dpdpoland_cud"
                                       value="1"{if $package->cud} checked="checked"{/if}>
                                <label class="form-check-label" for="dpdpoland_cud">
                                    {l s='Return parcel' mod='dpdpoland'}
                                </label>
                            </div>
                        {/if}


                        {if $settings->rod}
                            <div class="form-check col-12">
                                <input class="form-check-input" type="checkbox" name="rod" id="dpdpoland_rod"
                                       value="1"{if $package->rod} checked="checked"{/if}>
                                <label class="form-check-label" for="dpdpoland_rod">
                                    {l s='Return documents' mod='dpdpoland'}
                                </label>
                            </div>
                        {/if}

                        {if $settings->dpde}
                            <div class="form-check col-12">
                                <input class="form-check-input" type="checkbox" name="dpde" id="dpdpoland_dpde"
                                       value="1"{if $package->dpde} checked="checked"{/if}>
                                <label class="form-check-label" for="dpdpoland_dpde">
                                    {l s='DPD Express' mod='dpdpoland'}
                                </label>
                            </div>
                        {/if}

                        {if $settings->dpdnd}
                            <div class="form-check col-12">
                                <input class="form-check-input" type="checkbox" name="dpdnd" id="dpdpoland_dpdnd"
                                       value="1"{if $package->dpdnd} checked="checked"{/if}>
                                <label class="form-check-label" for="dpdpoland_dpdnd">
                                    {l s='DPD Next day' mod='dpdpoland'}
                                </label>
                            </div>
                        {/if}

                        {if $settings->dpdtoday}
                            <div class="form-check col-12 dpdpoland_dpdtoday_container">
                                <input class="form-check-input" type="checkbox" name="dpdtoday" id="dpdpoland_dpdtoday"
                                       value="1"{if $package->dpdtoday} checked="checked"{/if}>
                                <label class="form-check-label" for="dpdpoland_dpdtoday">
                                    {l s='DPD Today' mod='dpdpoland'}
                                </label>
                            </div>
                        {/if}
                        {if $settings->dpdsaturday}
                            <div class="form-check col-12 dpdpoland_dpdsaturday_container">
                                <input class="form-check-input" type="checkbox" name="dpdsaturday"
                                       id="dpdpoland_dpdsaturday"
                                       value="1"{if $package->dpdsaturday} checked="checked"{/if}>
                                <label class="form-check-label" for="dpdpoland_dpdsaturday">
                                    {l s='DPD Saturday' mod='dpdpoland'}
                                </label>
                            </div>
                        {/if}
                        {if $settings->dpdfood}
                            <div class="form-check col-12 dpdpoland_dpdfood_container">
                                <input class="form-check-input" type="checkbox" name="dpdfood" id="dpdpoland_dpdfood"
                                       value="1"{if $package->dpdfood} checked="checked"{/if}>
                                <label class="form-check-label" for="dpdpoland_dpdfood">
                                    {l s='DPD Food' mod='dpdpoland'}
                                </label>
                                <div class="input-group datepicker d-none" id="dpdfood_limit_date_container"
                                     style="width: 300px;">
                                    <label class="form-check-label dpdfood_limit_date_label" for="dpdfood_limit_date"
                                           style="margin: 8px 10px 0 0;">
                                        {l s='Limit date' mod='dpdpoland'}
                                    </label>
                                    <input type="text" class="form-control" id="dpdfood_limit_date"
                                           name="dpdfood_limit_date" data-format="YYYY-MM-DD" data-min-date="0">
                                    <div class="input-group-append">
                                        <div class="input-group-text"><i class="material-icons">date_range</i></div>
                                    </div>
                                </div>
                            </div>
                        {/if}
                        {if $settings->dpdlq}
                            <div class="form-check col-12 dpdpoland_dpdlq_container">
                                <input class="form-check-input" type="checkbox" name="dpdlq" id="dpdpoland_dpdlq"
                                       value="1"{if $package->dpdlq} checked="checked"{/if}>
                                <label class="form-check-label" for="dpdpoland_dpdlq">
                                    {l s='DPD ADR' mod='dpdpoland'}
                                </label>
                            </div>
                        {/if}
                    </div>

                    <hr/>

                    <div class="row">
                        <div class="form-group col-lg-6" id="dpdpoland_additional_info_container">
                            <label for="additional_info" class="form-check-label">
                                {l s='Additional shipment information:' mod='dpdpoland'}
                            </label>
                            <textarea name="additional_info" class="form-control" autocomplete="off"
                                      rows="4">{if $package->additional_info}{$package->additional_info|escape:'htmlall':'UTF-8'}{elseif !$loaded_object}{$default_customer_data_1|escape:'htmlall':'UTF-8'}{/if}</textarea>

                        </div>

                        <div id="dpdpoland_shipment_references_container" class="col-lg-6">
                            <div class="form-group">
                                <label for="dpdpoland_ref1" class="form-check-label">
								<span title="" data-toggle="tooltip" class="label-tooltip"
                                      data-original-title="{l s='Reference number 1' mod='dpdpoland'}">
									{l s='Reference number 1' mod='dpdpoland'}
								</span>
                                </label>
                                <input type="text" name="dpdpoland_ref1" class="form-control" autocomplete="off"
                                       value="{if $package->ref1}{$package->ref1|escape:'htmlall':'UTF-8'}{elseif !$loaded_object}{$default_ref1|escape:'htmlall':'UTF-8'}{/if}"/>

                            </div>

                            <div class="form-group">
                                <label for="dpdpoland_ref2" class="form-check-label">
								<span title="" data-toggle="tooltip" class="label-tooltip"
                                      data-original-title="{l s='Reference number 2' mod='dpdpoland'}">
									{l s='Reference number 2' mod='dpdpoland'}
								</span>
                                </label>
                                <input type="text" name="dpdpoland_ref2" class="form-control" autocomplete="off"
                                       value="{if $package->ref2}{$package->ref2|escape:'UTF-8'}{elseif !$loaded_object}{$default_ref2|escape:'htmlall':'UTF-8'}{/if}"/>

                            </div>
                        </div>
                    </div>

                    <hr/>

                    <div class="col-12">
                        <p>{l s='Group the products in your shipment into parcels' mod='dpdpoland'}
                            - {l s='This module lets you organize your products into parcels using the table below. Select parcel number.' mod='dpdpoland'}</p>
                    </div>

                    <input type="hidden"
                           name="dpdpoland_parcel_content_type"
                           class="form-control" value="{$parcel_content_source|escape:'htmlall':'UTF-8'}">

                    <input type="hidden"
                           name="dpdpoland_is_cod_payment_method"
                           id="dpdpoland_is_cod_payment_method"
                           class="form-control" value="{$is_cod_payment_method|escape:'htmlall':'UTF-8'}">

                    <table width="100%" cellspacing="0" cellpadding="0" class="table" id="dpdpoland_shipment_products">
                        <colgroup>
                            <col width="10%">
                            <col width="">
                            <col width="10%">
                            <col width="20%">
                            <col width="5%">
                        </colgroup>
                        <thead>
                        <tr>
                            <th>{l s='ID' mod='dpdpoland'}</th>
                            <th>{l s='Product' mod='dpdpoland'}</th>
                            <th>{l s='Weight' mod='dpdpoland'}</th>
                            <th>{l s='Parcel' mod='dpdpoland'}</th>
                            <th></th>
                        </tr>
                        </thead>
                        <tbody>
                        {foreach from=$products item=product name=products}
                            <tr>
                                <td class="parcel_reference">
                                    <input type="hidden"
                                           name="dpdpoland_products[{$smarty.foreach.products.index|escape:'htmlall':'UTF-8'}][id_product]"
                                           class="form-control" value="{$product.id_product|escape:'htmlall':'UTF-8'}">
                                    <input type="hidden"
                                           name="dpdpoland_products[{$smarty.foreach.products.index|escape:'htmlall':'UTF-8'}][id_product_attribute]"
                                           class="form-control"
                                           value="{$product.id_product_attribute|escape:'htmlall':'UTF-8'}">
                                    <input type="hidden"
                                           name="dpdpoland_products[{$smarty.foreach.products.index|escape:'htmlall':'UTF-8'}][reference]"
                                           class="form-control"
                                           value="{$product.reference|escape:'htmlall':'UTF-8'}">
                                    <input type="hidden"
                                           name="dpdpoland_products[{$smarty.foreach.products.index|escape:'htmlall':'UTF-8'}][name]"
                                           class="form-control"
                                           value="{$product.name|escape:'htmlall':'UTF-8'}">
                                    {$product.id_product|escape:'htmlall':'UTF-8'}
                                    _{$product.id_product_attribute|escape:'htmlall':'UTF-8'}
                                </td>
                                <td class="product_name">{$product.name|escape:'htmlall':'UTF-8'}</td>
                                <td class="parcel_weight">
                                    <input type="hidden" name="parcel_weight" class="form-control"
                                           value="{if $product.weight > 0}{$product.weight|escape:'htmlall':'UTF-8'}{else}{DpdPoland::getConfig(DpdPolandConfiguration::DEFAULT_WEIGHT)|escape:'htmlall':'UTF-8'}{/if}"/>
                                    {if $product.weight > 0}
                                        {$product.weight|string_format:"%.3f"} {$smarty.const._DPDPOLAND_DEFAULT_WEIGHT_UNIT_|escape:'htmlall':'UTF-8'}
                                    {else}
                                        {DpdPoland::getConfig(DpdPolandConfiguration::DEFAULT_WEIGHT)|string_format:"%.3f"} {$smarty.const._DPDPOLAND_DEFAULT_WEIGHT_UNIT_|escape:'htmlall':'UTF-8'}
                                    {/if}
                                </td>
                                <td>
                                    <select class="custom-select parcel_selection"
                                            name="dpdpoland_products[{$smarty.foreach.products.index|escape:'htmlall':'UTF-8'}][parcel]"
                                            autocomplete="off">
                                        <option value="0">--</option>
                                        {foreach from=$parcels item=parcel}
                                            {if isset($parcel.id_parcel) && isset($product.id_parcel)}
                                                {assign var="selected_parcel" value=$parcel.id_parcel == $product.id_parcel}
                                            {else}
                                                {assign var="selected_parcel" value=$parcel.number == 1}
                                            {/if}
                                            <option value="{$parcel.number|escape:'htmlall':'UTF-8'}"{if $selected_parcel} selected="selected"{/if}>{$parcel.number|escape:'htmlall':'UTF-8'}</option>
                                        {/foreach}
                                    </select>
                                </td>
                                <td>
                                    <input id="product_width" type="hidden"
                                           value="{$parcels[0].width|escape:'htmlall':'UTF-8'}"/>
                                    <input id="product_height" type="hidden"
                                           value="{$parcels[0].height|escape:'htmlall':'UTF-8'}"/>
                                    <input id="product_length" type="hidden"
                                           value="{$parcels[0].length|escape:'htmlall':'UTF-8'}"/>
                                </td>
                            </tr>
                        {/foreach}
                        </tbody>
                    </table>

                    <div class="row form-horizontal" id="dpdpoland_add_product_container" style="display: none">
                        <div class="form-group">
                            <label class="control-label ml-3">
							<span data-original-title="{l s='Begin typing the first letters of the product name, then select the product from the drop-down list.' mod='dpdpoland'}"
                                  class="label-tooltip" data-toggle="tooltip" title="">
								{l s='Search for a product' mod='dpdpoland'}
							</span>
                            </label>
                            <div class="ml-3 mr-3">
                                <input type="hidden" id="dpdpoland_selected_product_id_product" value="0"/>
                                <input type="hidden" id="dpdpoland_selected_product_id_product_attribute" value="0"/>
                                <input type="hidden" id="dpdpoland_selected_product_weight_numeric" value="0"/>
                                <input type="hidden" id="dpdpoland_selected_product_weight" value="0"/>
                                <input type="hidden" id="dpdpoland_selected_product_name" value="0"/>
                                <input type="hidden" id="dpdpoland_selected_product_parcel_content" value="0"/>
                                <div class="input-group">
                                    <input id="dpdpoland_select_product" type="text" class="form-control" size="35"/>
                                    <span class="input-group-addon">
									<i class="icon-search"></i>
								</span>
                                </div>
                            </div>
                            <div class="col-12 mt-1">
                                <input type="button" class="btn btn-primary btn-block" id="dpdpoland_add_product"
                                       value="{l s='Add product' mod='dpdpoland'}"/>
                            </div>
                        </div>
                    </div>

                    <div class="col-12">
                        <p>{l s='Manage parcels' mod='dpdpoland'}
                            - {l s='Here you can change parcel parameters, create new parcels' mod='dpdpoland'}</p>
                    </div>
                    <div id="dpdpoland_shipment_parcels_container">
                        <table width="100%" cellspacing="0" cellpadding="0" class="table"
                               id="dpdpoland_shipment_parcels">
                            <colgroup>
                                <col width="5%">
                                <col width="">
                                <col width="5%" class="adr-package d-none">
                                <col width="10%" class="adr-package d-none">
                                <col width="10%">
                                <col width="10%">
                                <col width="10%">
                                <col width="10%">
                                <col width="10%">
                                <col width="5%">
                            </colgroup>
                            <thead>
                            <tr>
                                <th class="center">{l s='Parcel' mod='dpdpoland'}</th>
                                <th>{l s='Content of parcel' mod='dpdpoland'}</th>
                                <th class="adr-package d-none">{l s='ADR' mod='dpdpoland'}</th>
                                <th class="adr-package d-none">{l s='Weight  ADR (kg)' mod='dpdpoland'}</th>
                                <th>{l s='Weight (kg)' mod='dpdpoland'}</th>
                                <th>{l s='Height (cm)' mod='dpdpoland'}</th>
                                <th>{l s='Length (cm)' mod='dpdpoland'}</th>
                                <th>{l s='Width (cm)' mod='dpdpoland'}</th>
                                <th>{l s='Dimension weight' mod='dpdpoland'}</th>
                                <th></th>
                            </tr>
                            </thead>
                            <tbody>
                            {foreach from=$parcels item=parcel}
                                <tr>
                                    <td class="center">
                                        {$parcel.number|escape:'htmlall':'UTF-8'}
                                        <input type="hidden"
                                               name="parcels[{$parcel.number|escape:'htmlall':'UTF-8'}][number]"
                                               value="{$parcel.number|escape:'htmlall':'UTF-8'}"/>
                                    </td>
                                    <td>
                                        <input type="hidden"
                                               name="parcels[{$parcel.number|escape:'htmlall':'UTF-8'}][content]"
                                               autocomplete="off" value="{$parcel.content|escape:'htmlall':'UTF-8'}"/>
                                        <input type="text"
                                               name="parcels[{$parcel.number|escape:'htmlall':'UTF-8'}][content]"
                                               class="form-control" size="46" autocomplete="off"
                                               value="{$parcel.content|escape:'htmlall':'UTF-8'}"/>
                                        <p class="preference_description clear"
                                           style="display: none">{l s='Modified field' mod='dpdpoland'}</p>
                                    </td>
                                    <td class="adr-package d-none">
                                        <input type="checkbox"
                                               name="parcels[{$parcel.number|escape:'htmlall':'UTF-8'}][adr]"
                                               class="form-control" size="10" autocomplete="off"
                                               value="true"/>
                                        <p class="preference_description clear"
                                           style="display: none">{l s='Modified field' mod='dpdpoland'}</p>
                                    </td>
                                    <td class="adr-package d-none">
                                        <input type="text"
                                               name="parcels[{$parcel.number|escape:'htmlall':'UTF-8'}][weight_adr]"
                                               class="form-control" size="10" autocomplete="off"

                                               value="{$parcel.weight_adr|escape:'htmlall':'UTF-8'}"/>
                                        <p class="preference_description clear"
                                           style="display: none">{l s='Modified field' mod='dpdpoland'}</p>
                                    </td>
                                    <td>
                                        <input type="text"
                                               name="parcels[{$parcel.number|escape:'htmlall':'UTF-8'}][weight]"
                                               class="form-control" size="10" autocomplete="off"

                                               value="{$parcel.weight|escape:'htmlall':'UTF-8'}"/>
                                        <p class="preference_description clear"
                                           style="display: none">{l s='Modified field' mod='dpdpoland'}</p>
                                    </td>
                                    <td>
                                        <input type="text"
                                               name="parcels[{$parcel.number|escape:'htmlall':'UTF-8'}][height]"
                                               class="form-control" size="10" autocomplete="off"
                                               value="{$parcel.height|escape:'htmlall':'UTF-8'}"/>
                                        <p class="preference_description clear"
                                           style="display: none">{l s='Modified field' mod='dpdpoland'}</p>
                                    </td>
                                    <td>
                                        <input type="text"
                                               name="parcels[{$parcel.number|escape:'htmlall':'UTF-8'}][length]"
                                               class="form-control" size="10" autocomplete="off"
                                               value="{$parcel.length|escape:'htmlall':'UTF-8'}"/>
                                        <p class="preference_description clear"
                                           style="display: none">{l s='Modified field' mod='dpdpoland'}</p>
                                    </td>
                                    <td>
                                        <input type="text"
                                               name="parcels[{$parcel.number|escape:'htmlall':'UTF-8'}][width]"
                                               class="form-control" size="10" autocomplete="off"
                                               value="{$parcel.width|escape:'htmlall':'UTF-8'}"/>
                                        <p class="preference_description clear"
                                           style="display: none">{l s='Modified field' mod='dpdpoland'}</p>
                                    </td>
                                    <td class="parcel_dimension_weight">{sprintf('%.3f', $parcel.length|escape:'htmlall':'UTF-8'*$parcel.width|escape:'htmlall':'UTF-8'*$parcel.height|escape:'htmlall':'UTF-8'/$smarty.const._DPDPOLAND_DIMENTION_WEIGHT_DIVISOR_|escape:'htmlall':'UTF-8')}</td>
                                    <td>
                                        {if $parcel@index >0}
                                            <input type="button" size="10" value="X" class="delete_parcel">
                                        {/if}
                                    </td>
                                </tr>
                            {/foreach}
                            </tbody>
                        </table>
                    </div>
                    <br/>
                    <div class="row" id="parcel_addition_container">

                        <div class="col-lg-10">
                            <div class="alert alert-info">
                                <p class="ml-1">
                                    {l s='When adding new parcel: Additional fee will be charged by DPD PL depending on your DPD PL contract. Price for shipment that was shown to your customer always includes only one parcel per order.' mod='dpdpoland'}
                                </p>
                            </div>
                        </div>
                        <div class="col-lg-2">
                            <input type="button" id="add_parcel" class="btn btn-primary btn-block"
                                   value="{l s='Add parcel' mod='dpdpoland'}"/>
                        </div>
                    </div>
                    <hr/>
                    <div class="row">
                        <div class="col-lg-3">

                        </div>
                        <div id="dpdgeopost_actions" class="form-horizontal">
                            <label class="control-label">{l s='Printout format:' mod='dpdpoland'}</label>
                            <div class="form-check">
                                <input id="printout_format_a4" type="radio" name="dpdpoland_printout_format"
                                       class="form-check-input"
                                       {if DpdPoland::getConfig(DpdPolandConfiguration::DEFAULT_PRINTER_TYPE) == DpdPolandConfiguration::PRINTOUT_FORMAT_A4}checked="checked"{/if}
                                       value="{DpdPolandConfiguration::PRINTOUT_FORMAT_A4|escape:'htmlall':'UTF-8'}"/>
                                {l s='A4' mod='dpdpoland'}
                                </label>
                            </div>
                            <div class="form-check">
                                <input id="label_out_of_stock_2" type="radio" name="dpdpoland_printout_format"
                                       class="form-check-input"
                                       {if DpdPoland::getConfig(DpdPolandConfiguration::DEFAULT_PRINTER_TYPE) == DpdPolandConfiguration::PRINTOUT_FORMAT_LABEL}checked="checked"{/if}
                                       value="{DpdPolandConfiguration::PRINTOUT_FORMAT_LABEL|escape:'htmlall':'UTF-8'}"/>
                                {l s='Label Printer' mod='dpdpoland'}
                            </div>
                            <div claa="mt-1">
                                <button class="btn btn-default pull-right" id="save_and_print_labels" type="button"><i
                                            class="process-icon-save"></i> {l s='Save and print labels' mod='dpdpoland'}
                                </button>
                                <button class="btn btn-default pull-right" id="save_labels" type="button"><i
                                            class="process-icon-save"></i> {l s='Save' mod='dpdpoland'}</button>
                                <button class="btn btn-default pull-right{if !$package->id_package_ws} hidden-element{/if}"
                                        id="print_labels" type="button"><i
                                            class="process-icon-save-status"></i> {l s='Print labels' mod='dpdpoland'}
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <div id="dpdpoland_current_status_accordion" class="panel-group">
                    <div class="panel">
                        <div class="panel-heading">
                            <a class="accordion-toggle" data-toggle="collapse"
                               data-parent="#dpdpoland_current_status_accordion"
                               href="#dpdpoland-status">{l s='Current status' mod='dpdpoland'}</a>
                        </div>
                        <div id="dpdpoland-status">
                            <div class="panel-body">
                                <table cellspacing="0" cellpadding="10" class="table">
                                    <thead>
                                    <tr>
                                        <th width="200"><span class="title_box">{l s='Action' mod='dpdpoland'}</span>
                                        </th>
                                        <th width="50"><span class="title_box">{l s='Status' mod='dpdpoland'}</span>
                                        </th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr>
                                        <td>{l s='Labels printed' mod='dpdpoland'}</td>
                                        <td>{if $package->labels_printed}{l s='Yes' mod='dpdpoland'}{else}{l s='No' mod='dpdpoland'}{/if}</td>
                                    </tr>
                                    <tr class="alt_row">
                                        <td>{l s='Manifest printed' mod='dpdpoland'}</td>
                                        <td>{if $package->isManifestPrinted()}{l s='Yes' mod='dpdpoland'}{else}{l s='No' mod='dpdpoland'}{/if}</td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
{else}
    <div class="row">
        <div class="col-lg-7">
            <div class="panel dpdpoland-ps16" id="dpdpoland">
                <div class="panel-heading">
                    <img src="{$smarty.const._DPDPOLAND_MODULE_URI_|escape:'htmlall':'UTF-8'}logo.gif" width="16"
                         height="16"> {l s='DPD Polska Sp. z o.o. shipping' mod='dpdpoland'}
                </div>
                <div class="alert alert-warning">
                    {l s='Module is not configured yet. Please check required settings' mod='dpdpoland'}<strong><a
                                href="{$moduleSettingsLink|escape:'htmlall':'UTF-8'}"> {l s='here' mod='dpdpoland'}</a></strong>
                </div>
            </div>
        </div>
    </div>
{/if}