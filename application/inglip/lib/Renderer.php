<?php
/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

namespace lib;

/**
 * Description of Renderer
 *
 * @author Maxim
 */
class Renderer
{
    protected $_image;
    protected $_buffer;
    protected $_text;
    protected $_coords;
    protected $_width;
    protected $_height;

    public function __construct($width = 300, $height = 57, $text = 'Hello')
    {
        $this->_width = $width;
        $this->_height = $height;
        $this->_image  = \imagecreatetruecolor($width, $height);
        $this->_buffer = \imagecreatetruecolor($width, $height);
        $this->_text  = $text;
        \imagefill($this->_image, 1, 1, 0xffffff);
        $this->_addNoise();
        $this->_addText();
    }
    
    public function __descruct()
    {
        if (!empty($this->_image)) {
            \imagedestroy($this->_image);
        }
        \imagedestroy($this->_buffer);
    }
    
    protected function _addNoise()
    {
        $total = rand(500, 1500);
        for ($i = 0; $i < $total; $i++) {
            $x = rand(0, $this->_width);
            $y = rand(0, $this->_height);
            $color = rand(0xaaaaaa, 0xfefefe);
            \imagesetpixel($this->_image, $x, $y, $color);
        }
        \imagefilter($this->_image, \IMG_FILTER_SMOOTH, rand(0, 10));
    }
    
    protected function _addText()
    {
        $fontfile = \dirname(__FILE__) . '/palab.ttf';
        $size = rand(12, 14);
        $x = rand(5, 15);
        $y = $this->_height - rand(15, 20);
        $angle = rand(-3, 3);
        $color = rand(0, 0x000080);
        $this->_coords = \imagettftext($this->_image, $size, $angle, $x, $y, $color, $fontfile, $this->_text);
    }
    
    public function spawn($useBig = false)
    {
        header('Content-Type: image/png');
        header('Cache-Control: no-cache');
        if ($useBig) {
            $original = realpath('./images/captcha_back.png');
            $image    = \imagecreatefrompng($original);
            \imagecopy($image, $this->_image, 6, 6, 0, 0, $this->_width, $this->_height);
        } else {
            $image = $this->_image;
        }
        \imagepng($image);
        \imagedestroy($image);
    }
}
?>