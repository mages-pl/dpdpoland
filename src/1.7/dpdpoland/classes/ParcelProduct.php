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
*  @author    DPD Polska Sp. z o.o.
*  @copyright 2019 DPD Polska Sp. z o.o.
*  @license   http://opensource.org/licenses/osl-3.0.php Open Software License (OSL 3.0)
*  International Registered Trademark & Property of DPD Polska Sp. z o.o.
*/

if (!defined('_PS_VERSION_'))
	exit;

/**
 * Class DpdPolandParcelProduct Responsible for parcel products management
 */
class DpdPolandParcelProduct extends DpdPolandObjectModel
{
    /**
     * @var int Parcel product ID
     */
	public $id_parcel_product;

    /**
     * @var int Parcel ID
     */
	public $id_parcel;

    /**
     * @var int Product ID
     */
	public $id_product;

    /**
     * @var int Product attribute ID
     */
	public $id_product_attribute;

    /**
     * @var string Product name
     */
	public $name;

    /**
     * @var Product weight
     */
	public $weight;

    /**
     * @var datetime Date when product was assigned for order
     */
	public $date_add;

    /**
     * @var datetime Date when product data of assignation for order was updated
     */
	public $date_upd;

    /**
     * @var array Class variables and their validation types
     */
	public static $definition = array(
		'table' => _DPDPOLAND_PARCEL_PRODUCT_DB_,
		'primary' => 'id_parcel_product',
		'multilang' => false,
		'multishop' => false,
		'fields' => array(
			'id_parcel'				=>	array('type' => self::TYPE_INT, 'validate' => 'isUnsignedInt'),
			'id_product'			=>	array('type' => self::TYPE_INT, 'validate' => 'isUnsignedInt'),
			'id_product_attribute'	=>	array('type' => self::TYPE_INT, 'validate' => 'isUnsignedInt'),
			'name'					=>	array('type' => self::TYPE_STRING, 'validate' => 'isString'),
			'weight'				=>	array('type' => self::TYPE_FLOAT, 'validate' => 'isUnsignedFloat'),
			'date_add'				=>	array('type' => self::TYPE_DATE, 'validate' => 'isDate'),
			'date_upd'				=>	array('type' => self::TYPE_DATE, 'validate' => 'isDate')
		)
	);

    /**
     * Collects data about parcels products details
     *
     * @param array $parcels Parcels
     * @return array Parcels products data
     */
	public static function getProductDetailsByParcels($parcels)
	{
		$products = array();

		foreach ($parcels as $parcel)
		{
			if (isset($parcel['id_parcel']))
			{
				if ($products_array = self::getProductByIdParcel($parcel['id_parcel']))
				{
					foreach ($products_array as $product)
					{
						if (self::isLabelPrinted($parcel['id_parcel']))
						{
							$product_data = self::getProductNameAndWeight($parcel['id_parcel'], $product['id_product'],
								$product['id_product_attribute']);
							$products[] = array_merge($product, array(
								'name' => $product_data['name'],
								'weight' => (float)$product_data['weight'],
								'id_parcel' => (int)$parcel['id_parcel'],
                                'reference' => $product['reference']
							));
						}
						else
						{
							$product_obj = new Product($product['id_product']);
							$combination = new Combination($product['id_product_attribute']);

							$products[] = array_merge($product, array(
								'name' => (version_compare(_PS_VERSION_, '1.5', '<') ?
									$product_obj->name[(int)Context::getContext()->language->id] :
									Product::getProductName($product['id_product'], $product['id_product_attribute'])),
								'weight' => (float)$combination->weight + (float)$product_obj->weight,
								'id_parcel' => (int)$parcel['id_parcel'],
                                'reference' => $product['reference']
							));
						}
					}
				}
			}
		}

		return $products;
	}

    /**
     * Collects products IDs according to parcel
     *
     * @param int $id_parcel Parcel ID
     * @return array|false|mysqli_result|null|PDOStatement|resource Parcel products IDs
     */
	private static function getProductByIdParcel($id_parcel)
	{
		return Db::getInstance()->executeS('
			SELECT dp.`id_product`, dp.`id_product_attribute`, p.`reference`
			FROM `'._DB_PREFIX_.bqSQL(self::$definition['table']).'` dp
            LEFT JOIN `'._DB_PREFIX_.'product` p ON (p.`id_product` = dp.`id_product`)
			WHERE dp.`id_parcel`='.(int)$id_parcel
		);
	}

    /**
     * Collects and formats data about order shipped products
     *
     * @param int $id_order Order ID
     * @param array $products Products information
     * @return array Shipped products data
     */
	public static function getShippedProducts($id_order, $products = array())
	{
		$order = is_object($id_order) ? $id_order : new Order((int)$id_order);

		if (!$products)
			$products = $order->getProductsDetail();

		$shipped_products = array();

		foreach ($products as $product)
		{
			if (isset($product['product_quantity']))
				$quantity = (int)$product['product_quantity'];
			elseif (isset($product['quantity']))
				$quantity = (int)$product['quantity'];
			else
				$quantity = 1;

			self::extractAndFormatProductData($product);

			for ($i = 0; $i < $quantity; $i++)
				$shipped_products[] = $product;
		}

		return $shipped_products;
	}

    /**
     * Collects and formats needed products data
     *
     * @param array $product Product properties
     */
	private static function extractAndFormatProductData(&$product)
	{
		$id_product = isset($product['product_id']) ? (int)$product['product_id'] : (int)$product['id_product'];
		$id_product_attribute = isset($product['product_attribute_id']) ? (int)$product['product_attribute_id'] :
			(int)$product['id_product_attribute'];
		$product_name = isset($product['product_name']) ? $product['product_name'] : $product['name'];
		$product_weight = isset($product['product_weight']) ? $product['product_weight'] : $product['weight'];

		if (isset($product['id_parcel']))
			$id_parcel = (int)$product['id_parcel'];

		$product = array(
			'id_product' => $id_product,
			'id_product_attribute' => $id_product_attribute,
			'name' => $product_name,
			'weight' => DpdPoland::convertWeight($product_weight),
			'width' => isset($product['width']) ? DpdPoland::convertDimension($product['width']) : null,
			'height' => isset($product['height']) ? DpdPoland::convertDimension($product['height']) : null,
			'length' => isset($product['height']) ? DpdPoland::convertDimension($product['depth']) : null,
            'reference' => $product['reference']
		);

		if (isset($id_parcel))
			$product['id_parcel'] = $id_parcel;
	}

    /**
     * Checks if label is printed and record about it was saved in database
     *
     * @param int $id_parcel Parcel ID
     * @return bool Label was printed
     */
	private static function isLabelPrinted($id_parcel)
	{
		return (bool)DB::getInstance()->getValue('
			SELECT pac.`labels_printed`
			FROM `'._DB_PREFIX_._DPDPOLAND_PARCEL_DB_.'` par
			LEFT JOIN `'._DB_PREFIX_._DPDPOLAND_PACKAGE_DB_.'` pac ON (pac.`id_package_ws` = par.`id_package_ws`)
			WHERE par.`id_parcel` = "'.(int)$id_parcel.'"
		');
	}

    /**
     * Collects product name and weight
     *
     * @param int $id_parcel Parcel ID
     * @param int $id_product Product ID
     * @param int $id_product_attribute Product combination ID
     * @return array|bool|null|object Product name and weight
     */
	private static function getProductNameAndWeight($id_parcel, $id_product, $id_product_attribute)
	{
		return DB::getInstance()->getRow('
			SELECT `name`, `weight`
			FROM `'._DB_PREFIX_._DPDPOLAND_PARCEL_PRODUCT_DB_.'`
			WHERE `id_parcel` = "'.(int)$id_parcel.'"
				AND `id_product` = "'.(int)$id_product.'"
				AND `id_product_attribute` = "'.(int)$id_product_attribute.'"
		');
	}
}