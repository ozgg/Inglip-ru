<?php
/**
 * Дополнительные классы
 */
namespace lib;

class Recaptcha
{
    const PRIVATE_KEY = '6LezOMESAAAAAHM3x_ceoC4mw8PkRHhVrq42tmWI';
    const PUPLIC_KEY  = '6LezOMESAAAAAM9RcLToz7PQwl8TVfE7AGHf3kcz';
    
    public function __construct()
    {
        require_once(dirname(__FILE__) . '/recaptchalib.php');
    }

    public function getHtml()
    {
        return \recaptcha_get_html(self::PUPLIC_KEY);
    }
}
?>