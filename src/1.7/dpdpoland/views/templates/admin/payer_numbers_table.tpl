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
<table cellspacing="0" cellpadding="0" class="table document numbers-table">
    <colgroup>
        <col>
        <col>
        <col>
        <col>
    </colgroup>
    <thead>
        <tr class="nodrag nodrop titles-row">
            <th class="center">
                <span class="title_box">{l s='Client number' mod='dpdpoland'}</span>
            </th>
            <th class="center">
                <span class="title_box">{l s='Client name' mod='dpdpoland'}</span>
            </th>
            <th class="center">
                <span class="title_box">{l s='Default' mod='dpdpoland'}</span>
            </th>
            <th class="center">
                <span class="title_box"></span>
            </th>
        </tr>
    </thead>
    <tbody>
        {if isset($payer_numbers) && !empty($payer_numbers)}
            {section name=ii loop=$payer_numbers}
                <tr>
                    <td class="center">
                        {$payer_numbers[ii].payer_number|escape:'htmlall':'UTF-8'}
                    </td>
                    <td class="center">
                        {$payer_numbers[ii].name|escape:'htmlall':'UTF-8'}
                    </td>
                    <td class="center">
                        <input type="radio" name="{DpdPolandConfiguration::CLIENT_NUMBER|escape:'htmlall':'UTF-8'}" value="{$payer_numbers[ii].payer_number|escape:'htmlall':'UTF-8'}" {if DpdPoland::getInputValue(DpdPolandConfiguration::CLIENT_NUMBER, $settings->client_number) == $payer_numbers[ii].payer_number|escape:'htmlall':'UTF-8'}checked="checked"{/if} />
                    </td>
                    <td class="center">
                        <img class="payer-number-delete-button" title="{l s='Delete' mod='dpdpoland'}" onclick="if (confirm('{l s='Delete selected client numbers?' mod='dpdpoland'}{$payer_numbers[ii].payer_number|escape:'htmlall':'UTF-8'}')){ deleteClientNumber('{$payer_numbers[ii].id_dpdpoland_payer_number|escape:'htmlall':'UTF-8'}'); }else{ return false; }" alt="{l s='Delete' mod='dpdpoland'}" src="../img/admin/delete.gif">
                    </td>
                </tr>
            {/section}
        {else}
            <tr>
                <td colspan="4" class="center">
                    {l s='No numbers' mod='dpdpoland'}
                </td>
            </tr>
        {/if}
    </tbody>
</table>