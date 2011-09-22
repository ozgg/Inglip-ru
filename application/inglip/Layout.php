<?php
namespace app;

class Layout
{
    protected $_name;
    protected $_view;
    
    public function __construct($name = 'layout')
    {
        $this->_name = $name;
    }
    
    public function setView($view)
    {
        $this->_view = $view;
    }

    public function disable()
    {
        $this->_name = null;
    }
    
    public function render()
    {
        if (!is_null($this->_name)) {
            $filename = "layouts/{$this->_name}.phtml";
            include($filename);
        }
    }
}
?>