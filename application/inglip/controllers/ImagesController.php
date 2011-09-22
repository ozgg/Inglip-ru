<?php
/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

namespace controllers;

/**
 * Description of ImagesController
 *
 * @author Maxim
 */
class ImagesController extends \app\Controller_Application
{
    public function claimpngAction()
    {
        $this->_layout->disable();
        $renderer = new \lib\Renderer(300, 57, \models\Claim::get());
        $renderer->spawn();
    }

    public function captchapngAction()
    {
        $this->_layout->disable();
        $renderer = new \lib\Renderer(300, 57, \models\Claim::get());
        $renderer->spawn(true);
    }

    public function mailpngAction()
    {
        $this->_layout->disable();
        $renderer = new \lib\Renderer(185, 50, 'summon@inglip.ru');
        $renderer->spawn();
    }
}
?>
