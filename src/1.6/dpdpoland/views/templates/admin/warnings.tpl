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
{if count($warnings)}
	<div class="bootstrap">
		<div class="warning warn alert alert-warning">
			{if count($warnings) == 1}
				{$warnings[0]|escape:'htmlall':'UTF-8'}
			{else}
				{l s='%d warnings' mod='dpdpoland' sprintf=$warnings|count}
				<br/>
				<ol>
					{foreach $warnings as $warning}
						<li>{$warning|escape:'htmlall':'UTF-8'}</li>
					{/foreach}
				</ol>
			{/if}
		</div>
	</div>
{/if}