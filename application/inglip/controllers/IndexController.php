<?php
namespace controllers;

class IndexController extends \app\Controller_Application
{
    public function indexAction()
    {
        $this->_view->title = 'Inglip summoned (Инглип явился)';
    }
}
?>