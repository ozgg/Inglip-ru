<?php
/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

namespace app;

/**
 * Description of Db_Abstract
 *
 * @author Maxim
 */
abstract class Db_Abstract
{
    protected static $_instance;

    public static function getInstance(array $connectionData)
    {
    }

    abstract protected function _connect(array $connectionData);
    abstract protected function _disconnect();
    abstract public function query($query);
    abstract public function fetchRow($query);
    abstract public function fetchAll($query);
    abstract public function free();
    abstract public function escape($string);
}
?>