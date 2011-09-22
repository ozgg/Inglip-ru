<?php
/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

namespace controllers;

/**
 * Description of ManageController
 *
 * @author Maxim
 */
class ManageController extends \app\Controller_Application
{
    protected $_ok = false;
    
    public function init()
    {
        parent::init();
        if (empty($_SESSION)) {
            session_start();
        }
        if (!isset($_SESSION['auth'])) {
            $this->_view->setTemplate('auth');
        } else {
            $this->_ok = true;
        }
        $this->_view->showForm = !$this->_ok;
    }

    public function indexAction()
    {
    }
    
    public function addsubjectAction()
    {
        if ($this->_ok) {
            $request = $this->getRequest();
            $words = explode(',', $request->getPost('words'));
            $added = 0;
            $gender = $request->getPost('gender');
            $adjective = $request->getPost('is_descriptive', 0);
            $isDescriptive = intval(!empty($adjective));
            if (!empty($words)) {
                foreach ($words as $word) {
                    $added += \models\words\Subject::add($word, $gender, $isDescriptive);
                }
            }
            $this->_view->added = $added;
        }
    }

    public function authAction()
    {
        $allowed = array(
            'ozgg' => 'lolorrrr',
            'kiote' => '1234!56',
            'electra1002' => '13d13d13d',
        );
        if (!$this->_ok) {
            $request  = $this->getRequest();
            $login    = $request->getPost('login');
            $password = $request->getPost('password');
            if (isset($allowed[$login])) {
                if ($allowed[$login] == $password) {
                    $this->_doAuth($login);
                }
            }
        }
    }

    protected function _doAuth($login)
    {
        $this->_ok = true;
        $this->_view->showForm = false;
        $_SESSION['auth'] = $login;
    }
}
?>
