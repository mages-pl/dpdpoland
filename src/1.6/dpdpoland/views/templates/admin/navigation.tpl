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
{if version_compare($smarty.const._PS_VERSION_, '1.6', '<')}
    <div class="toolbar-placeholder">
        <div class="toolbarBox toolbarHead">
            <ul class="cc_button">
                {if Tools::getValue('menu') == 'sender_address'}
                    <li>
                        <a id="desc-add_new" class="toolbar_btn" href="{$form_url|escape:'htmlall':'UTF-8'}" title="{l s='Add new' mod='dpdpoland'}">
                            <span class="process-icon-add_new add_new"></span>
                            <div>{l s='Add new' mod='dpdpoland'}</div>
                        </a>
                    </li>
                {/if}
                <li>
                    <a id="arrange_pickup_page" href="{$module_link|escape:'htmlall':'UTF-8'}&menu=arrange_pickup" class="toolbar_btn">
                        <span class="process-icon-arrange_pickup arrange_pickup"></span>
                        <div>{l s='Arrange Pickup' mod='dpdpoland'}</div>
                    </a>
                </li>
                <li>
                    <a id="pickup_history_page" href="{$module_link|escape:'htmlall':'UTF-8'}&menu=pickup_history" class="toolbar_btn">
                        <span class="process-icon-packages_list pickup_history"></span>
                        <div>{l s='Pickup history' mod='dpdpoland'}</div>
                    </a>
                </li>
                <li>
                    <a id="packages_list_page" href="{$module_link|escape:'htmlall':'UTF-8'}&menu=packages_list" class="toolbar_btn">
                        <span class="process-icon-packages_list packages_list"></span>
                        <div>{l s='Packages list' mod='dpdpoland'}</div>
                    </a>
                </li>
                <li>
                    <a id="manifest_list_page" href="{$module_link|escape:'htmlall':'UTF-8'}&menu=manifest_list" class="toolbar_btn">
                        <span class="process-icon-manifest_list manifest_list"></span>
                        <div>{l s='Manifest list' mod='dpdpoland'}</div>
                    </a>
                </li>
                <li>
                    <a id="parcel_history_list_page" href="{$module_link|escape:'htmlall':'UTF-8'}&menu=parcel_history_list" class="toolbar_btn">
                        <span class="process-icon-parcel_history_list parcel_history_list"></span>
                        <div>{l s='Parcels history' mod='dpdpoland'}</div>
                    </a>
                </li>
                <li>
                    <a id="country_list_page" href="{$module_link|escape:'htmlall':'UTF-8'}&menu=country_list" class="toolbar_btn">
                        <span class="process-icon-country_list country_list"></span>
                        <div>{l s='Shipment countries' mod='dpdpoland'}</div>
                    </a>
                </li>
                <li>
                    <a id="csv_page" href="{$module_link|escape:'htmlall':'UTF-8'}&menu=csv" class="toolbar_btn">
                        <span class="process-icon-csv csv"></span>
                        <div>{l s='CSV prices import' mod='dpdpoland'}</div>
                    </a>
                </li>
                <li>
                    <a id="sender_address" href="{$module_link|escape:'htmlall':'UTF-8'}&menu=sender_address" class="toolbar_btn">
                        <span class="process-icon-sender_address sender_address"></span>
                        <div>{l s='Sender address' mod='dpdpoland'}</div>
                    </a>
                </li>
                <li>
                    <a id="settings_page" href="{$module_link|escape:'htmlall':'UTF-8'}&menu=configuration" class="toolbar_btn">
                        <span class="process-icon-settings settings"></span>
                        <div>{l s='Settings' mod='dpdpoland'}</div>
                    </a>
                </li>
                <li>
                    <a id="help_page" href="{$module_link|escape:'htmlall':'UTF-8'}&menu=help" class="toolbar_btn">
                        <span class="process-icon-help help"></span>
                        <div>{l s='Help' mod='dpdpoland'}</div>
                    </a>
                </li>
            </ul>
            <div class="pageTitle">
                <h3>
                    <span id="current_obj">
                        <span class="breadcrumb item-0 ">
                            {section name=breadcrumb_iteration loop=$breadcrumb}
                                {if $smarty.section.breadcrumb_iteration.index != 0}
                                    <img src="{$smarty.const._DPDPOLAND_IMG_URI_|escape:'htmlall':'UTF-8'}/separator_breadcrumb.png" alt=">">
                                {/if}
                                <span class="breadcrumb item-1">
                                    {$breadcrumb[breadcrumb_iteration]|escape:'htmlall':'UTF-8'}
                                </span>
                            {/section}
                        </span>
                    </span>
                </h3>
            </div>
        </div>
    </div>
{else}
    <nav class="navbar navbar-default" role="navigation">
       <div class="navbar-header">
          <button type="button" class="navbar-toggle float-left" data-toggle="collapse" data-target="#navbar-collapse">
             <span class="sr-only"></span>
             <span class="icon-bar"></span>
             <span class="icon-bar"></span>
             <span class="icon-bar"></span>
          </button>
       </div>
       <div class="collapse navbar-collapse" id="navbar-collapse">
          <ul class="nav navbar-nav">
            {if isset($meniutabs)}
              {foreach $meniutabs key=numStep item=tab}
                <li class="{if $tab.active}active{/if}">
                    <a id="{$tab.short|escape:'htmlall':'utf-8'}" href="{$tab.href|escape:'htmlall':'utf-8'}">
                        <span class="{$tab.imgclass|escape:'htmlall':'utf-8'}"></span>{$tab.desc|escape:'htmlall':'utf-8'}
                    </a>
                </li>
              {/foreach}
            {/if}
          </ul>
       </div>
    </nav>
{/if}