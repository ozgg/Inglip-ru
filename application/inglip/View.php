<?php
namespace app;

class View
{
    protected $_dir;
    protected $_template;
    protected $_parameters = array();
    
    public function __construct($templatesDir)
    {
        $this->_dir = $templatesDir;
    }

    public function __set($parameter, $value)
    {
        $this->_parameters[$parameter] = $value;
    }

    public function __get($parameter)
    {
        $value = null;
        if (isset($this->_parameters[$parameter])) {
            $value = $this->_parameters[$parameter];
        }
        return $value;
    }

    public function setTemplate($name)
    {
        $this->_template = $name;
    }

    public function render()
    {
        $filename = "{$this->_dir}/{$this->_template}.phtml";
        if (\file_exists($filename)) {
            include($filename);
        } else {
            throw new \Exception("No template {$this->_template}");
        }
    }
}
?>