<?php
/**
 * Класс для работы с БД
 * MySQL 5.1.*
 * Библиотека php_mysqli
 *
 * ver 1.0.0
 */

namespace app;

class Db_Mysql extends Db_Abstract
{
    /**
     *
     * @var mysqli_result
     */
	private $_result;
	private $_error;			// Сообщение об ошибке
	private $_connection;		// Соединение с базой (ресурс)

    public static function getInstance(array $connectionData = array())
    {
        if (is_null(self::$_instance)) {
            self::$_instance = new self();
        	self::$_instance->_connect($connectionData);
        }
        return self::$_instance;
    }

	/**
	 * Установить соединение с базой
	 * Если соединение уже установлено, будет просто возвращён экземпляр класса
	 * На входе принимает массив с параметрами соединенмя
	 */
	protected function _connect(array $connectionData = array())
	{
		if (!empty($this->_connection)) {
			return $this;
		}
		// Параметры по умолчанию
		$par = array(
			'host' => 'localhost',
			'user' => 'inglip',
			'password' => '',
			'dbname' => 'inglip',
            'port'  => 63306,
		);
		foreach ($par as $key => $val) {
			if (isset($connectionData[$key])) {
				$par[$key] = $connectionData[$key];
			}
		}
		unset($key, $val);
		$this->_connection = new \mysqli(
                $par['host'],
                $par['user'],
                $par['password'],
                $par['dbname'],
                $par['port']
            );
		if (!$this->_connection) {
			$this->_error = 'Database connection error.';
			throw new \Exception($this->_error);
		} else {
            $this->_connection->query("SET NAMES utf8");
        }
	}

	/**
	 * Закрыть соединение с базой
	 */
	protected function _disconnect()
	{
		return $this->_connection->close();
	}

	/**
	 * Получить ресурс-ссылку для работы с базой
	 * На случай, если нужно проделать какие-то особые операции
	 */
	public function getConnection()
	{
		return $this->_connection;
	}

	/**
	 * Выполнить запрос
	 */
	public function query($query)
	{
		$this->_result = $this->_connection->query($query);
		if (!$this->_result) {
			$this->_error = $this->_connection->error;
			throw new \Exception("Query error. {$this->_error}");
		}
		return $this->_result;
	}

	/**
	 * Осводить результат
	 */
	public function free()
	{
		if (!empty($this->_result)) {
			$this->_result->free();
		}
	}

	/**
	 * Получить все ряды в результате запроса
	 */
	public function fetchAll($query)
	{
		$this->query($query);
		if (!empty($this->_result)) {
			$out = $this->_result->fetch_all();
			$this->free();
			return $out;
		}
	}

	/**
	 * Получить один ряд из результата запроса
	 */
	public function fetchRow($query)
	{
		$this->query($query);
		if (!empty($this->_result)) {
			$out = $this->_result->fetch_row();
			$this->free();
			return $out;
		}
	}

	/**
	 * Получить один ряд в смешанном массиве из результата запроса
	 */
	public function fetchArray($query)
	{
		$this->query($query);
		if (!empty($this->_result)) {
			$out = $this->_result->fetch_array();
			$this->free();
			return $out;
		}
	}

	/**
	 * Получить один элемент в результате запроса
	 * Например, если у нас что-то типа
	 	SELECT `id` FROM `test` WHERE `alias` = 'given_alias'
	 */
	public function fetchOne($query)
	{
		$this->query($query);
		if (!empty($this->_result)) {
			$row = $this->_result->fetch_row();
			if (!empty($row[0])) {
				return $row[0];
			} else {
				return null;
			}
		}
	}

	/**
	 * Экранировать строку
	 * Если передаётся строка, то возвращается экранированная строка.
	 * Если передан массив, то для каждого его элемента вызывается эта же
		функция, возвращая массив с экранированными значениями ключей.
	 */
	public function escape($input)
	{
		if (is_array($input)) {
			$out = array();
			foreach ($input as $key => $val) {
				$out[$key] = $this->escape($val);
			}
			unset($key, $val);
			return $out;
		} else {
			return $this->_connection->real_escape_string($input);
		}
	}
}
?>