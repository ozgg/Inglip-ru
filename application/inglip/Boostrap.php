<?php
/**
 * Приложение. основные компоненты ядра
 */
namespace app;

class Bootstrap
{
    protected $_applicationDir;
    protected $_frontController;
    protected $_loader;
    
    public function __construct()
    {
        \mb_internal_encoding('UTF-8');
        $this->_applicationDir = dirname(__FILE__);
        $includePath = $this->_applicationDir
                     . DIRECTORY_SEPARATOR 
                     . get_include_path();
        set_include_path($includePath);
        $this->_initLoader();
        $this->_initFrontController();
    }

    protected function _initLoader()
    {
        require_once('Loader.php');
        $this->_loader = new Loader();
    }
    
    protected function _initFrontController()
    {
        $this->_frontController = new Controller_Front($this->_applicationDir);
    }
    
    public function run()
    {
        $this->_frontController->render();
    }
}
?>