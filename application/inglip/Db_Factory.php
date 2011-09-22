<?php
/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

namespace app;

/**
 * Description of Db_Factory
 *
 * @author Maxim
 */
class Db_Factory
{
    const MYSQL = 'Mysql';

    public static function get($type = self::MYSQL)
    {
        $class = null;
        $db    = null;
        switch ($type) {
            case self::MYSQL:
                $class = 'app\Db_' . self::MYSQL;
                break;
            default:
                break;
        }
        if (!\is_null($class)) {
            $db = $class::getInstance();
        }
        return $db;
    }
}
?>