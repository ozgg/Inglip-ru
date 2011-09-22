<?php
/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

namespace models\words;

/**
 * Description of verb
 *
 * @author Maxim
 */
class Verb extends Word
{
    public $id;
    public $isPassive;
    public $isLasting;
    public $infinitive;
    public $imperativeSimple;
    public $imperativePerfect;
    public $firstSingle;
    public $secondSingle;
    public $thirdSingle;
    public $firstPlural;
    public $secondPlural;
    public $thirdPlural;
    protected $_table = 'verb';

    const FORM = 'verb_form';

    public function __construct($id = null, array $options = array())
    {
        if (!is_null($id)) {
            $this->_where('id', \intval($id));
        } else {
            $this->_setRandom();
        }
        $this->_init();
        if (!empty($options[self::FORM])) {
            $this->word = $this->$options[self::FORM];
        } else {
            $this->word = $this->imperativeSimple;
        }
        if (!empty($options[\models\Claim::USE_NEGATION])) {
            $this->word = "не {$this->word}";
        }
    }

    public function __get($form)
    {
        return '[whoops!]';
    }

    protected function _setProperties(array $row)
    {
        $this->id = $row['id'];
        $this->isPassive = $row['is_passive'];
        $this->isLasting = $row['is_lasting'];
        $this->infinitive = $row['infinitive'];
        $this->imperativeSimple = $row['imperative'];
        $this->imperativePerfect = $row['imperative_perfect'];
        $this->firstSingle = $row['first_single'];
        $this->secondSingle = $row['second_single'];
        $this->thirdSingle = $row['third_single'];
        $this->firstPlural = $row['first_plural'];
        $this->secondPlural = $row['second_plural'];
        $this->thirdPlural = $row['third_plural'];
    }
}
?>