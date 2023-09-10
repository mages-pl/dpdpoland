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

<div class="pudo-map-container">

    <div class="form-group row container_dpdpoland_pudo_code_input" style="display:none">
        <label for="dpdpoland_pudo_code_input" class="col-sm-4 col-form-label" style="text-align: left">
            {l s='Selected pickup point' mod='dpdpoland'}</label>
        <div class="col-sm-8">
            <input type="text" class="form-control" id="dpdpoland_pudo_code_input" disabled="disabled"
                   style="font-size: 13px;">
        </div>
    </div>

    <script id="dpd-widget" type="text/javascript">
        const id_pudo_carrier = '{$id_pudo_carrier|intval}'.toString();
        const id_pudo_cod_carrier = '{$id_pudo_cod_carrier|intval}'.toString();
        const dpdpoland_ajax_uri = '{$dpdpoland_ajax_uri|escape:'htmlall':'UTF-8'}'.toString();
        const dpdpoland_token = '{$dpdpoland_token|escape:'htmlall':'UTF-8'}'.toString();
        const dpdpoland_cart = '{$dpdpoland_cart|intval}'.toString();

        function pointSelected(pudoCode) {
            console.log("Selected point")
            if (getSelectedCarrier() === id_pudo_carrier)
                $('.container_dpdpoland_pudo_code_input').css("display", "block");
            else if (getSelectedCarrier() === id_pudo_cod_carrier)
                $('.container_dpdpoland_pudo_cod_code_input').css("display", "block");

            if (getSelectedCarrier() === id_pudo_cod_carrier) {
                dpdPolandPointIdCod = pudoCode;
            } else {
                dpdPolandPointId = pudoCode;
            }

            $.ajax("{$dpdpoland_ajax_uri|escape:'htmlall':'UTF-8'}", {
                data: {
                    'pudo_code': pudoCode,
                    'save_pudo_id': 1,
                    'token': "{$dpdpoland_token|escape:'htmlall':'UTF-8'}",
                    'id_cart': "{$dpdpoland_cart|intval}"
                }
            });

            $('.container_dpdpoland_pudo_cod_warning').css("display", "none");
            if (getSelectedCarrier() === id_pudo_cod_carrier) {
                $.ajax("{$dpdpoland_ajax_uri|escape:'htmlall':'UTF-8'}", {
                    data: {
                        'pudo_code': pudoCode,
                        'call_has_pudo_cod': 1,
                        'token': "{$dpdpoland_token|escape:'htmlall':'UTF-8'}",
                        'id_cart': "{$dpdpoland_cart|intval}"
                    },
                    success: function (data) {
                        if (data === "0")
                            $('.container_dpdpoland_pudo_cod_warning').css("display", "block");
                        else
                            $('.container_dpdpoland_pudo_cod_warning').css("display", "none");
                    }
                });
            }

            $.ajax("{$dpdpoland_ajax_uri|escape:'htmlall':'UTF-8'}", {
                data: {
                    'pudo_code': pudoCode,
                    'call_pudo_address': 1,
                    'token': "{$dpdpoland_token|escape:'htmlall':'UTF-8'}",
                    'id_cart': "{$dpdpoland_cart|intval}"
                },
                success: function (data) {
                    if (getSelectedCarrier() === id_pudo_carrier)
                        $('#dpdpoland_pudo_code_input').val(data);
                    else if (getSelectedCarrier() === id_pudo_cod_carrier)
                        $('#dpdpoland_pudo_cod_code_input').val(data);

                    togglePudoMap();
                    togglePudoMap17();
                    togglePudoMap14();
                },
                error: function () {
                    if (getSelectedCarrier() === id_pudo_carrier)
                        $('#dpdpoland_pudo_code_input').val(pudoCode);
                    else if (getSelectedCarrier() === id_pudo_cod_carrier)
                        $('#dpdpoland_pudo_cod_code_input').val(pudoCode);

                    togglePudoMap();
                    togglePudoMap17();
                    togglePudoMap14();
                },
            });
        }
    </script>

    <br/><br/>
</div>

<div class="pudo-map-cod-container">

    <div class="form-group row container_dpdpoland_pudo_cod_code_input" style="display:none">
        <label for="dpdpoland_pudo_cod_code_input" class="col-sm-4 col-form-label" style="text-align: left">
            {l s='Selected pickup point' mod='dpdpoland'}</label>
        <div class="col-sm-8">
            <input type="text" class="form-control" id="dpdpoland_pudo_cod_code_input" disabled="disabled"
                   style="font-size: 13px;">
        </div>
    </div>

    <div class="form-group container_dpdpoland_pudo_cod_warning" style="display:none">
        <p class="alert alert-danger">{l s='Selected point does not provide the cod service' mod='dpdpoland'}</p>
    </div>

    <script id="dpd-widget-cod" type="text/javascript"></script>

    <br/><br/>
</div>


<script type="text/javascript">
    const iframe = document.createElement("iframe");
    iframe.src = '//pudofinder.dpd.com.pl/widget?key=1ae3418e27627ab52bebdcc1a958fa04';
    iframe.style.width = "100%";
    iframe.style.border = "none";
    iframe.style.minHeight = "400px";

    const script = document.getElementById("dpd-widget");
    if (script)
        script.parentNode.insertBefore(iframe, script);

    const eventListener = window[window.addEventListener ? "addEventListener" : "attachEvent"];
    const messageEvent = ("attachEvent" === eventListener) ? "onmessage" : "message";
    eventListener(messageEvent, function (a) {
        if (a.data.height && !isNaN(a.data.height)) {
            iframe.style.height = a.data.height + "px"
        } else if (a.data.point_id) {
            pointSelected(a.data.point_id);
        }
    }, !1);

    const iframeCod = document.createElement("iframe");
    iframeCod.src = '//pudofinder.dpd.com.pl/widget?key=1ae3418e27627ab52bebdcc1a958fa04&direct_delivery_cod=1';
    iframeCod.style.width = "100%";
    iframeCod.style.border = "none";
    iframeCod.style.minHeight = "400px";

    const scriptCod = document.getElementById("dpd-widget-cod");
    if (scriptCod)
        scriptCod.parentNode.insertBefore(iframeCod, scriptCod);

    const eventListenerCod = window[window.addEventListener ? "addEventListener" : "attachEvent"];
    const messageEventCod = ("attachEvent" === eventListenerCod) ? "onmessage" : "message";
    eventListenerCod(messageEventCod, function (a) {
        if (a.data.height && !isNaN(a.data.height)) {
            iframeCod.style.height = a.data.height + "px"
        }
    }, !1);

</script>