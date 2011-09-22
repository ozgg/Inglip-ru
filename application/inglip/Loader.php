<?php
namespace app;

class Loader
{
    protected $_namespaces = array('app');

    public function __construct()
    {
        \spl_autoload_register('app\Loader::load');
    }

    public static function load($class)
    {
        $parts = explode('\\', $class);
        $path  = '';
        if (count($parts) > 1) {
            $fileName = \array_pop($parts);
            if ($parts[0] != 'app') {
                $path = implode('/', $parts) . '/';
            }
        } else {
            $fileName = $class;
        }
        require_once("{$path}{$fileName}.php");
    }

    public function registerNamespace($namespace)
    {
        $this->_namespaces[] = $namespace;
    }
}
?>