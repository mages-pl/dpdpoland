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
    <br/>
{/if}
<div id="help_container"{if version_compare($smarty.const._PS_VERSION_, '1.6', '>=')} class="panel"{/if}>
    <img src="{$smarty.const._DPDPOLAND_IMG_URI_|escape:'htmlall':'UTF-8'}pdf.gif"/>
    <a href="{$module_link|escape:'htmlall':'UTF-8'}&menu=help&print_pdf&polish">{l s='User guide' mod='dpdpoland'}</a>
    <br/><br/>
    <p>{l s='If you have any questions, please contact our support team at ' mod='dpdpoland'} <a
                href="mailto: itcustomersupport@dpd.com.pl">itcustomersupport@dpd.com.pl</a></p>
</div>