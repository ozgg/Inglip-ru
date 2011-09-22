<?php
namespace app;

class Request
{
    protected $_get;
    protected $_post;
    
    public function __construct()
    {
        $this->_get  = &$_GET;
        $this->_post = &$_POST;
    }

    public function getParameter($parameter)
    {
        $value = null;
        if (isset($this->_get[$parameter])) {
            $value = $this->_get[$parameter];
        } elseif (isset($this->_post[$parameter])) {
            $value = $this->_post[$parameter];
        }
        return $value;
    }

    public function getGet($parameter = null)
    {
        if (is_null($parameter)) {
            return $this->_get;
        } else {
            $value = null;
            if (isset($this->_get[$parameter])) {
                $value = $this->_get[$parameter];
            }
            return $value;
        }
    }

    public function getPost($parameter = null)
    {
        if (is_null($parameter)) {
            return $this->_post;
        } else {
            $value = null;
            if (isset($this->_post[$parameter])) {
                $value = $this->_post[$parameter];
            }
            return $value;
        }
    }
}
?>