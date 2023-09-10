<?php
/**
 * 2019 DPD Polska Sp. z o.o.
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
 * @license   http://opensource.org/licenses/osl-3.0.php Open Software License (OSL 3.0)
 *  International Registered Trademark & Property of DPD Polska Sp. z o.o.
 */

if (!defined('_PS_VERSION_'))
    exit;

/**
 * Class DpdPolandCarrierClassicService Responsible for specific DPD service (carrier) management
 */
class DpdPolandCarrierClassicService extends DpdPolandService
{
    /**
     * Current file name
     */
    const FILENAME = 'dpd_classic.service';

    /**
     * Installs specific DPD service (carrier)
     *
     * @return bool Carrier installed successfully
     */
    public static function install()
    {
        $id_shop = Shop::getContextShopID(true);
        $id_shop_group = Shop::getContextShopGroupID(true);
        $id_carrier = (int)Configuration::get(DpdPolandConfiguration::CARRIER_CLASSIC_ID, null, $id_shop_group, $id_shop);
        $carrier = self::getCarrierByReference((int)$id_carrier);
        if ($id_carrier && Validate::isLoadedObject($carrier))
            if (!$carrier->deleted)
                return true;
            else {
                $carrier->deleted = 0;
                return (bool)$carrier->save();
            }

        $carrier_classic = new DpdPolandCarrierClassicService();

        $carrier = new Carrier();
        $carrier->name = $carrier_classic->module_instance->l('DPD international shipment (DPD Classic)', self::FILENAME);
        $carrier->active = 1;
        $carrier->is_free = 0;
        $carrier->shipping_handling = 1;
        $carrier->shipping_external = 1;
        $carrier->shipping_method = 1;
        $carrier->max_width = 0;
        $carrier->max_height = 0;
        $carrier->max_depth = 0;
        $carrier->max_weight = 0;
        $carrier->grade = 0;
        $carrier->is_module = 1;
        $carrier->need_range = 1;
        $carrier->range_behavior = 1;
        $carrier->external_module_name = $carrier_classic->module_instance->name;
        $carrier->url = _DPDPOLAND_TRACKING_URL_;

        $delay = array();

        foreach (Language::getLanguages(false) as $language)
            $delay[$language['id_lang']] = $carrier_classic->module_instance->l('DPD international shipment (DPD Classic)', self::FILENAME);

        $carrier->delay = $delay;

        if (!$carrier->save())
            return false;

        $dpdpoland_carrier = new DpdPolandCarrier();
        $dpdpoland_carrier->id_carrier = (int)$carrier->id;
        $dpdpoland_carrier->id_reference = (int)$carrier->id;

        if (!$dpdpoland_carrier->save())
            return false;

        if (!copy(_DPDPOLAND_IMG_DIR_ . DpdPolandCarrierClassicService::IMG_DIR . '/' . _DPDPOLAND_CLASSIC_ID_ . '.' .
            DpdPolandCarrierClassicService::IMG_EXTENSION, _PS_SHIP_IMG_DIR_ . '/' . (int)$carrier->id . '.jpg'))
            return false;

        $zones = Zone::getZones(false);
        foreach ($zones as $zone)
            $carrier->addZone((int)$zone["id_zone"]);

        if (!$range_obj = $carrier->getRangeObject())
            return false;

        $range_obj->id_carrier = (int)$carrier->id;
        $range_obj->delimiter1 = 0;
        $range_obj->delimiter2 = 1;

        if (!$range_obj->add())
            return false;

        if (!self::assignCustomerGroupsForCarrier($carrier))
            return false;

        if (!Configuration::updateValue(DpdPolandConfiguration::CARRIER_CLASSIC_ID, (int)$carrier->id))
            return false;

        return true;
    }

    /**
     * Deletes DPD carrier
     *
     * @return bool DPD carrier deleted successfully
     */
    public static function delete()
    {
        $id_shop = Shop::getContextShopID(true);
        $id_shop_group = Shop::getContextShopGroupID(true);
        return (bool)self::deleteCarrier((int)Configuration::get(DpdPolandConfiguration::CARRIER_CLASSIC_ID, null, $id_shop_group, $id_shop));
    }
}