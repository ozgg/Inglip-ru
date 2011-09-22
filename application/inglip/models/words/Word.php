<?php
/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

namespace models\words;

/**
 * Description of Word
 *
 * @author Maxim
 */
abstract class Word
{
    public $word;
    protected $_table;
    protected $_rand  = false;
    protected $_where = array();
    protected $_db;

    public function __toString()
    {
        return ($this->word);
    }

    protected function _init()
    {
        $query = "select * from {$this->_table}";
        if (!empty($this->_where)) {
            $query .= " where " . implode(' and ', $this->_where);
        }
        if ($this->_rand) {
            $query .= ' order by rand() limit 1';
        }
        $this->_db  = \app\Db_Factory::get();
        $row = $this->_db->fetchArray($query);
        if (!empty($row)) {
            $this->_setProperties($row);
        }
    }

    protected function _where($field, $value)
    {
        $this->_where[] = "{$field} = {$value}";
    }

    protected function _setRandom($rand = true)
    {
        $this->_rand = (bool) $rand;
    }

    abstract protected function _setProperties(array $row);
}
?>
