{#

OPNsense® is Copyright © 2014 – 2025 by Deciso B.V.
This file is Copyright © 2025 Your Name
All rights reserved.

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

1.  Redistributions of source code must retain the above copyright notice,
    this list of conditions and the following disclaimer.

2.  Redistributions in binary form must reproduce the above copyright notice,
    this list of conditions and the following disclaimer in the documentation
    and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY
AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY,
OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
POSSIBILITY OF SUCH DAMAGE.

#}

<script>

    function quagga_update_status() {
      updateServiceControlUI('quagga');
    }

    $( document ).ready(function() {
        mapDataToFormUI({'frm_isis_settings':"/api/quagga/isis/get"}).done(function(data){
            formatTokenizersUI();
            $('.selectpicker').selectpicker('refresh');
            updateServiceControlUI('quagga');
        });

        $("#reconfigureAct").SimpleActionButton({
            onPreAction: function() {
                const dfObj = new $.Deferred();
                saveFormToEndpoint("/api/quagga/isis/set", 'frm_isis_settings', function () { dfObj.resolve(); }, true, function () { dfObj.reject(); });
                return dfObj;
            },
            onAction: function(data, status) {
                updateServiceControlUI('quagga');
            }
        });

        $("#{{formGridEditISISInterface['table_id']}}").UIBootgrid({
            'search':'/api/quagga/isis/search_interface',
            'get':'/api/quagga/isis/get_interface/',
            'set':'/api/quagga/isis/set_interface/',
            'add':'/api/quagga/isis/add_interface/',
            'del':'/api/quagga/isis/del_interface/',
            'toggle':'/api/quagga/isis/toggle_interface/'
        });

        $("#{{formGridEditISISRedistribution['table_id']}}").UIBootgrid({
            'search':'/api/quagga/isis/search_redistribution',
            'get':'/api/quagga/isis/get_redistribution/',
            'set':'/api/quagga/isis/set_redistribution/',
            'add':'/api/quagga/isis/add_redistribution/',
            'del':'/api/quagga/isis/del_redistribution/',
            'toggle':'/api/quagga/isis/toggle_redistribution/'
        });

        const $header = $(".bootgrid-header[id*='{{formGridEditISISRedistribution['table_id']}}']");
        if ($header.length) {
            $header.find("div.actionBar").parent().prepend(
                '<td class="col-sm-2 theading-text">' +
                '<span class="fa fa-info-circle text-muted" style="margin-right: 5px;"></span>' +
                '<strong>{{ lang._("Route Redistribution") }}</strong>' +
                '</td>'
            );
        }

    });
</script>

<style>
    /* Some trickery to make the redistribution grid look like its part of the base form */
    .bootgrid-header[id*='{{ formGridEditISISRedistribution['table_id'] }}'] {
        padding-left: 10px;
    }
    #{{ formGridEditISISRedistribution['table_id'] }}.bootgrid-table {
        margin-left: 25%;
        width: 75%;
    }
    .bootgrid-footer[id*='{{ formGridEditISISRedistribution['table_id'] }}'] {
        margin-left: 24%;
    }
</style>

<!-- Navigation bar -->
<ul class="nav nav-tabs" data-tabs="tabs" id="maintabs">
    <li class="active"><a data-toggle="tab" href="#general">{{ lang._('General') }}</a></li>
    <li><a data-toggle="tab" href="#interfaces">{{ lang._('Interfaces') }}</a></li>
</ul>
<div class="tab-content content-box tab-content">
    <!-- Tab: General -->
    <div id="general" class="tab-pane fade in active">
        {{ partial("layout_partials/base_form",['fields':generalForm,'id':'frm_isis_settings'])}}
        {{ partial('layout_partials/base_bootgrid_table', formGridEditISISRedistribution)}}
    </div>
    <!-- Tab: Interfaces -->
    <div id="interfaces" class="tab-pane fade in">
        {{ partial('layout_partials/base_bootgrid_table', formGridEditISISInterface)}}
    </div>
</div>
{{ partial(
    'layout_partials/base_apply_button',
    {
        'data_endpoint': '/api/quagga/service/reconfigure',
        'data_service_widget': 'quagga',
        'data_change_message_content': lang._('Apply will reload the service without causing interruptions. Some changes will need a full restart with the available service control buttons.')
    }
) }}
{{ partial("layout_partials/base_dialog",['fields':formDialogEditISISInterface,'id':formGridEditISISInterface['edit_dialog_id'],'label':lang._('Edit Interface')])}}
{{ partial("layout_partials/base_dialog",['fields':formDialogEditISISRedistribution,'id':formGridEditISISRedistribution['edit_dialog_id'],'label':lang._('Edit Route Redistribution')])}}
