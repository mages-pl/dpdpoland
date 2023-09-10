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
const animation_speed = 'fast';
let dpdPolandPointId = 0;
let dpdPolandPointIdCod = 0;

$(document).ready(function () {
    togglePudoMap();
    togglePudoMap17();
    togglePudoMap14();

    $(document).on('click', '.delivery_option_radio', togglePudoMap);
    $(document).on('click', 'input[name^="delivery_option"]', togglePudoMap17);
    $(document).on('click', 'input[name="id_carrier"]', togglePudoMap14);

    $(document).ajaxStop(function () {
        togglePudoMap(true);
    });

});

function toggleCheckoutButton(idSelectedCarrier) {
    if ((idSelectedCarrier === id_pudo_carrier || idSelectedCarrier === id_pudo_cod_carrier)) {
        $('button[name="processCarrier"]').attr('disabled');
    } else {
        $('button[name="processCarrier"]').removeAttr('disabled');
    }
}

function savePudoCode(pudoCode) {
    $.ajax(dpdpoland_ajax_uri, {
        data: {
            'pudo_code': pudoCode,
            'save_pudo_id': 1,
            'token': dpdpoland_token,
            'id_cart': dpdpoland_cart
        }
    });
}

function togglePudoMap(ajaxStop = false) {
    let id_selected_carrier = $('.delivery_option_radio:checked').val();

    if (typeof id_selected_carrier == 'undefined') {
        return;
    }

    id_selected_carrier = id_selected_carrier.replace(',', '');

    if (typeof id_selected_carrier == 'undefined' || id_selected_carrier === 0) {
        return;
    }

    if (id_selected_carrier === id_pudo_carrier) {
        $('.pudo-map-cod-container').hide();
        $('.pudo-map-container').slideDown(animation_speed);
    } else if (id_selected_carrier === id_pudo_cod_carrier) {

        $('.pudo-map-container').hide();
        $('.pudo-map-cod-container').slideDown(animation_speed);
    } else {
        $('.pudo-map-container').slideUp(animation_speed);
        $('.pudo-map-cod-container').slideUp(animation_speed);
    }

    const pudoSelected = $('#dpdpoland_pudo_code_input').val()
    const pudoCodSelected = $('#dpdpoland_pudo_cod_code_input').val()

    if (id_selected_carrier === id_pudo_cod_carrier && !isEmpty(pudoCodSelected) && ajaxStop === false)
        savePudoCode(dpdPolandPointIdCod)
    else if (id_selected_carrier === id_pudo_carrier && !isEmpty(pudoSelected) && ajaxStop === false)
        savePudoCode(dpdPolandPointId)

    if ((id_selected_carrier === id_pudo_cod_carrier && isEmpty(pudoCodSelected) || (id_selected_carrier === id_pudo_carrier && isEmpty(pudoSelected)))) {
        $('button[name="processCarrier"]').attr('disabled', 'disabled');
    } else {
        $('button[name="processCarrier"]').removeAttr('disabled');
    }
}

function getSelectedCarrier() {
    let id_selected_carrier_ps17 = $('input[name^="delivery_option"]:checked').val();

    if (typeof id_selected_carrier_ps17 == 'undefined') {
        return null;
    }

    id_selected_carrier_ps17 = id_selected_carrier_ps17.replace(',', '');

    if (typeof id_selected_carrier_ps17 == 'undefined' || id_selected_carrier_ps17 === 0) {
        return null;
    }

    return id_selected_carrier_ps17;
}

function togglePudoMap17() {

    const id_selected_carrier_ps17 = getSelectedCarrier()
    if (typeof id_selected_carrier_ps17 == 'undefined' || (typeof id_pudo_carrier == 'undefined' && typeof id_pudo_cod_carrier == 'undefined'))
        return;

    if (id_selected_carrier_ps17 === id_pudo_carrier) {
        $('.pudo-map-cod-container').hide();
        $('.pudo-map-container').slideDown(animation_speed);
    } else if (id_selected_carrier_ps17 === id_pudo_cod_carrier) {
        $('.pudo-map-container').hide();
        $('.pudo-map-cod-container').slideDown(animation_speed);
    } else {
        $('.pudo-map-container').slideUp(animation_speed);
        $('.pudo-map-cod-container').slideUp(animation_speed);
    }

    const pudoSelected = $('#dpdpoland_pudo_code_input').val()
    const pudoCodSelected = $('#dpdpoland_pudo_cod_code_input').val()

    if (id_selected_carrier_ps17 === id_pudo_cod_carrier && !isEmpty(pudoCodSelected))
        savePudoCode(dpdPolandPointIdCod)
    else if (id_selected_carrier_ps17 === id_pudo_carrier && !isEmpty(pudoSelected))
        savePudoCode(dpdPolandPointId)

    if ((id_selected_carrier_ps17 === id_pudo_cod_carrier && isEmpty(pudoCodSelected) || (id_selected_carrier_ps17 === id_pudo_carrier && isEmpty(pudoSelected)))) {
        $('button[name="confirmDeliveryOption"]').attr('disabled', 'disabled');
    } else {
        $('button[name="confirmDeliveryOption"]').removeAttr('disabled');
    }
}

function isEmpty(input) {
    return input == null || input === ""
}

function togglePudoMap14() {
    let id_selected_carrier_ps14 = $('input[name="id_carrier"]:checked').val();

    if (typeof id_selected_carrier_ps14 == 'undefined') {
        return;
    }

    id_selected_carrier_ps14 = id_selected_carrier_ps14.replace(',', '');

    if (typeof id_selected_carrier_ps14 == 'undefined' || id_selected_carrier_ps14 === 0) {
        return;
    }

    if (id_selected_carrier_ps14 === id_pudo_carrier) {
        $('.pudo-map-cod-container').hide();
        $('.pudo-map-container').slideDown(animation_speed);
    } else if (id_selected_carrier_ps14 === id_pudo_cod_carrier) {
        $('.pudo-map-container').hide();
        $('.pudo-map-cod-container').slideDown(animation_speed);
    } else {
        $('.pudo-map-container').slideUp(animation_speed);
        $('.pudo-map-cod-container').slideUp(animation_speed);
    }
}
