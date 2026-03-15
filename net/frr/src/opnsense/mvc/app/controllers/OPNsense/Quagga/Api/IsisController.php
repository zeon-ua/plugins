<?php

/**
 *    Copyright (C) 2025 Your Name
 *    Based on OspfsettingsController.php, Copyright (C) 2017 Fabian Franz
 *
 *    All rights reserved.
 *
 *    Redistribution and use in source and binary forms, with or without
 *    modification, are permitted provided that the following conditions are met:
 *
 *    1. Redistributions of source code must retain the above copyright notice,
 *       this list of conditions and the following disclaimer.
 *
 *    2. Redistributions in binary form must reproduce the above copyright
 *       notice, this list of conditions and the following disclaimer in the
 *       documentation and/or other materials provided with the distribution.
 *
 *    THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES,
 *    INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY
 *    AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
 *    AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY,
 *    OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 *    SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 *    INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 *    CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 *    ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 *    POSSIBILITY OF SUCH DAMAGE.
 */

namespace OPNsense\Quagga\Api;

use OPNsense\Base\ApiMutableModelControllerBase;

class IsisController extends ApiMutableModelControllerBase
{
    protected static $internalModelName = 'isis';
    protected static $internalModelClass = '\OPNsense\Quagga\ISIS';

    /*
     * -------------------------------------------------------------------------
     * Redistribution grid
     * -------------------------------------------------------------------------
     */

    public function searchRedistributionAction()
    {
        return $this->searchBase(
            'redistributions.redistribution',
            ['enabled', 'protocol', 'level', 'metric', 'route_map']
        );
    }

    public function getRedistributionAction($uuid = null)
    {
        return $this->getBase('redistribution', 'redistributions.redistribution', $uuid);
    }

    public function addRedistributionAction()
    {
        return $this->addBase('redistribution', 'redistributions.redistribution');
    }

    public function delRedistributionAction($uuid)
    {
        return $this->delBase('redistributions.redistribution', $uuid);
    }

    public function setRedistributionAction($uuid)
    {
        return $this->setBase('redistribution', 'redistributions.redistribution', $uuid);
    }

    public function toggleRedistributionAction($uuid)
    {
        return $this->toggleBase('redistributions.redistribution', $uuid);
    }

    /*
     * -------------------------------------------------------------------------
     * Interface grid
     * -------------------------------------------------------------------------
     */

    public function searchInterfaceAction()
    {
        return $this->searchBase(
            'interfaces.interface',
            ['enabled', 'interface', 'circuit_type', 'passive', 'metric', 'network_type']
        );
    }

    public function getInterfaceAction($uuid = null)
    {
        return $this->getBase('interface', 'interfaces.interface', $uuid);
    }

    public function addInterfaceAction()
    {
        return $this->addBase('interface', 'interfaces.interface');
    }

    public function delInterfaceAction($uuid)
    {
        return $this->delBase('interfaces.interface', $uuid);
    }

    public function setInterfaceAction($uuid)
    {
        return $this->setBase('interface', 'interfaces.interface', $uuid);
    }

    public function toggleInterfaceAction($uuid)
    {
        return $this->toggleBase('interfaces.interface', $uuid);
    }
}
