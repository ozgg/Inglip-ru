<?php
/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

namespace models\words;

/**
 * Description of Subject
 *
 * @author Maxim
 */
class Subject extends Word
{
    public $id;
    public $isDescriptive;
    public $gender;
    public $isPlural;
    public $nominative;
    public $genitive;
    public $dative;
    public $absolutive;
    public $instrumental;
    public $locative;
    public $word;
    protected $_table = 'subject';

    public function __construct($id = null, array $options = array())
    {
        if (!is_null($id)) {
            $this->_where('id', \intval($id));
        } else {
            $this->_setRandom();
            if (isset($options['gender'])) {
                $this->_where('gender', \intval($options['gender']));
            }
            if (isset($options['plural'])) {
                $this->_where('is_plural', \intval($options['plural']));
            }
            if (isset($options['descriptive'])) {
                $this->_where('is_descriptive', \intval($options['is_descriptive']));
            }
        }
        $this->_init();
    }

    public function chooseCase($isPassive)
    {
        $cases = array('dative', 'absolutive', 'instrumental', );
        switch ($isPassive) {
            case -1:
                $case = 'nominative';
                break;
            case 1:
                $case = $cases[rand(0, 2)];
                break;
            case 3:
                $case = 'dative';
                break;
            case 5:
                $case = 'instrumental';
                break;
            default:
                $case = $cases[rand(1, 2)];
                break;
        }
        $this->word = $this->$case;
    }

    protected function _setProperties(array $row)
    {
        $this->id            = $row['id'];
        $this->isDescriptive = $row['is_descriptive'];
        $this->gender        = $row['gender'];
        $this->isPlural      = $row['is_plural'];
        $this->nominative    = $row['nominative'];
        $this->genitive      = $row['genitive'];
        $this->dative        = $row['dative'];
        $this->absolutive    = $row['absolutive'];
        $this->instrumental  = $row['instrumental'];
        $this->locative      = $row['locative'];

        $this->word = $this->nominative;
    }

    public static function add($word, $gender, $isDescriptive)
    {
        $added = 0;
        $word = trim($word);
        if (\mb_strlen($word) != 0) {
            $url = 'http://export.yandex.ru/inflect.xml?name='
                 . \rawurlencode($word)
                 . '&format=json';
            $json  = file_get_contents($url);
            $forms = \json_decode($json, true);
            \array_shift($forms);
            $db = \app\Db_Factory::get();
            if ((count($forms) == 6) && !self::_exists($db, $forms[0])) {
                $options = array();
                if ($gender < 3) {
                    $options['gender']    = $gender;
                    $options['is_plural'] = '0';
                } else {
                    $options['gender']    = 'null';
                    $options['is_plural'] = '1';
                }
                $options['is_descriptive'] = intval($isDescriptive);
                $options['nominative'] = "'{$db->escape($forms[0])}'";
                $options['genitive'] = "'{$db->escape($forms[1])}'";
                $options['dative'] = "'{$db->escape($forms[2])}'";
                $options['absolutive'] = "'{$db->escape($forms[3])}'";
                $options['instrumental'] = "'{$db->escape($forms[4])}'";
                $options['locative'] = "'{$db->escape($forms[5])}'";
                $query = self::_assemble($options);
                if ($db->query($query)) {
                    $added++;
                }
            }
        }
        return $added;
    }

    protected static function _exists($db, $word)
    {
        $query = "select 1 from subject where nominative = "
               . "'{$db->escape($word)}'";
        return $db->fetchOne($query);
    }

    protected static function _assemble(array $options)
    {
        $query = "insert into subject (";
        $fields = array();
        $values = array();
        foreach ($options as $field => $value) {
            $fields[] = $field;
            $values[] = $value;
        }
        $query .= implode(', ', $fields);
        $query .= ") values (";
        $query .= implode(', ', $values);
        $query .= ')';
        return $query;
    }
}
?>