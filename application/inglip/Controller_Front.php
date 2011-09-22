<?php
namespace app;

class Controller_Front
{
    protected $_request;
    protected $_router;
    protected $_applicationDir;

    public function  __construct($applicationDir)
    {
        $this->_applicationDir = $applicationDir;
        $this->_request = new Request();
        $this->_router  = new Router($this->_request->getGet('q'));
    }

    public function getRequest()
    {
        return $this->_request;
    }

    public function render()
    {
        $controller = $this->_getController();
        if (!empty($controller)) {
            try {
                $action = "{$this->_router->getActionName()}Action";
                \ob_start();
                $controller->init();
                $controller->$action();
                $controller->render();
                \ob_end_flush();
            } catch (\Exception $e) {
                \ob_end_clean();
                $this->_handleError($e->getMessage());
            }
        }
    }
    
    protected function _getController()
    {
        $controller = null;
        $controllerName = $this->_router->getControllerName();
        $fileName = \ucfirst($controllerName) . 'Controller';
        $path = $this->_applicationDir . '/controllers';
        if (file_exists("{$path}/{$fileName}.php")) {
            $class = '\\controllers\\' . $fileName;
            $controller = new $class($this->_applicationDir);
            $controller->setRouter($this->_router);
            $controller->setRequest($this->_request);
        } else {
            $this->_notFound('Not found.');
        }
        return $controller;
    }

    protected function _handleError($message)
    {
        header('HTTP/1.0 500 Internal Server Error');
        header('Content-Type: text/plain;charset=UTF-8');
        echo $message;
    }
    
    protected function _notFound($message)
    {
            header('HTTP/1.0 404 Not Found');
            header('Content-Type: text/plain;charset=UTF-8');
            echo $message;
    }
}
?>