<?php
/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

namespace models\words;

/**
 * Description of Adverb
 *
 * @author Maxim
 */
class Adverb extends Word
{
    public $id;
    public $isPlace;
    public $word;
    protected $_table = 'adverb';

    public function __construct($id = null, array $options = array())
    {
        if (!is_null($id)) {
            $this->_where('id', \intval($id));
        } else {
            $isPlace = 0;
            if (!empty($options[\models\Claim::USE_PLACE])) {
                $isPlace = 1;
            }
            $this->_where('is_place', $isPlace);
            $this->_setRandom();
        }
        $this->_init();
    }

    protected function _setProperties(array $row)
    {
        $this->id      = $row['id'];
        $this->isPlace = $row['is_place'];
        $this->word    = $row['word'];
    }
}
?>
