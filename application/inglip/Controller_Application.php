<?php
namespace app;

abstract class Controller_Application
{
    protected $_request;
    protected $_router;
    protected $_layout;
    protected $_view;
    protected $_dir;
    
    public function __construct($applicationDir)
    {
        $this->_dir = $applicationDir;
        $this->_layout = new Layout();
    }

    public function  __call($name, $arguments)
    {
        $pageName = \str_replace('Action', '', $name);
        throw new \Exception("No such page: {$pageName}");
    }
    
    public function setRouter(Router $router)
    {
        $this->_router = $router;
    }

    public function setRequest(Request $request)
    {
        $this->_request = $request;
    }

    public function getRequest()
    {
        return $this->_request;
    }

    public function init()
    {
        $dir = "{$this->_dir}/views/{$this->_router->getControllerName()}";
        $this->_view = new View($dir);
        $this->_view->setTemplate($this->_router->getActionName());
        $this->_layout->setView($this->_view);
    }

    public function render()
    {
        $this->_layout->render();
    }
}
?>