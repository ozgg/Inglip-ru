<?php
/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

namespace models;

use app;

/**
 * Description of Claim
 *
 * @author Maxim
 */
class Claim
{
    protected static $_db;
    protected static $_options;
    
    const USE_PERFECT   = 'use_perfect';
    const USE_NEGATION  = 'use_negation';
    const USE_ADVERB    = 'use_adverb';
    const USE_PLACE     = 'use_place';
    const ADVERB_FIRST  = 'adverb_first';
    const SUBJECT_FIRST = 'subject_first';
    
    public static function get($chars = 25)
    {
        $claim   = '';
        $options = array(
            self::USE_PERFECT => \rand(0, 1),
            self::USE_NEGATION => \rand(0, 1),
            self::USE_ADVERB => \rand(0, 1),
            self::USE_PLACE => 0, // \rand(0, 1),
            self::ADVERB_FIRST => \rand(0, 1),
            self::SUBJECT_FIRST => \rand(0, 1),
        );

        if ($options[self::SUBJECT_FIRST]) {
            $subject = new words\Subject(null, $options);
            $form    = $subject->isPlural ? 'thirdPlural' : 'thirdSingle';
            $claim  .= "{$subject} ";
            $options[words\Verb::FORM] = $form;
            $options[self::USE_ADVERB] = 0;
            unset($subject, $form);
        } else {
            if ($options[self::USE_PERFECT]) {
                $options[words\Verb::FORM]   = 'imperativePerfect';
                $options[self::USE_NEGATION] = 0;
            }
        }

        $verb = new words\Verb(null, $options);
        if (!empty($verb->id)) {
            $claim  .= $verb;
            $subject = new words\Subject();
            $subject->chooseCase($verb->isPassive);
            $word   = $subject->__toString();
            $length = mb_strlen($claim) + mb_strlen($word);
            if ($length <= $chars) {
                $claim .= " {$word}";
            }
            unset($subject, $word, $length);
        }
        
        if ($options[self::USE_ADVERB]) {
            $adverb = new words\Adverb(null, $options);
            $word   = $adverb->__toString();
            $length = mb_strlen($claim) + mb_strlen($word);
            if ($length <= $chars) {
                if ($options[self::ADVERB_FIRST]) {
                    $claim = "{$word} {$claim}";
                } else {
                    $claim .= " {$word}";
                }
            }
        }

        self::_log($claim);
        return $claim;
    }

    protected static function _log($phrase)
    {
        $remote_addr = null;
        if (!empty($_SERVER['REMOTE_ADDR'])) {
            $remote_addr = $_SERVER['REMOTE_ADDR'];
            $octet = '(25[0-5]|2[0-4]\d|1\d{2}|\d{1,2})';
            $pattern = "/^{$octet}\.{$octet}\.{$octet}\.{$octet}.*/";
            $remote_addr = preg_replace($pattern, '$1.$2.$3.$4', $remote_addr);
            unset($octet, $pattern);
            $remote_addr = \ip2long($remote_addr);
        }
        if ($remote_addr != 2130706433) {
            if (empty($remote_addr)) {
                $remote_addr = 'null';
            }
            $db = \app\Db_Factory::get();
            $phrase = $db->escape($phrase);
            $query  = "insert into logger (remote_addr, phrase) values ";
            $query .= "({$remote_addr}, '{$phrase}')";
            $db->query($query);
            unset($db, $query);
        }
        unset($remote_addr);
    }
}
?>