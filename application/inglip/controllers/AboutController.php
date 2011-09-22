<?php
namespace controllers;

class AboutController extends \app\Controller_Application
{
    public function indexAction()
    {
        $this->_view->title = 'О сайте и меме';
    }
}
?>