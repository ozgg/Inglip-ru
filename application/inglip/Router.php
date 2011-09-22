<?php
namespace app;

class Router
{
    protected $_controller = 'index';
    protected $_action     = 'index';
    protected $_parameters = array();
    
    public function __construct($query = null)
    {
        if (!is_null($query)) {
           $parts = \explode('/', trim($query, '/'));
           if (isset($parts[0])) {
               $this->_controller = $this->_escape(\array_shift($parts));
               if (!strlen($this->_controller)) {
                   $this->_controller = 'index';
               }
           }
           if (isset($parts[0])) {
               $this->_action = $this->_escape(\array_shift($parts));
               if (!strlen($this->_action)) {
                   $this->_action = 'index';
               }
           }
           if (!empty($parts)) {
               $this->_setParameters($parts);
           }
        }
    }

    protected function _setParameters(array $query)
    {
        while (!empty($query)) {
            $parameter = \array_shift($query);
            if (!empty($query)) {
                $value = \urldecode(\array_shift($query));
            } else {
                $value = null;
            }
            $this->_parameters[$parameter] = $value;
        }
        unset($parameter, $value);
    }

    protected function _escape($string)
    {
        $out = \mb_strtolower(\urldecode($string));
        $out = \preg_replace('/[^-a-z0-9_]/', '', $out);
        return $out;
    }

    public function getControllerName()
    {
        return $this->_controller;
    }

    public function getActionName()
    {
        return $this->_action;
    }
}
?>