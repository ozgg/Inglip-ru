<?php
/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

namespace controllers;

class ApiController extends \app\Controller_Application
{
    public function claimAction()
    {
        header('Content-Type: text/plain;charset=UTF-8');
        $this->_layout->disable();
        echo \models\Claim::get();
    }
    
    public function taglineAction()
    {
        header('Content-Type: text/plain;charset=UTF-8');
        $this->_layout->disable();
        echo \models\Claim::get(65535);
    }
}
?>