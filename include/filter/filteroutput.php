<?php

defined('PG_PAGE') or die();
/**
 * PGFilterOutput
 *
 */
class PGFilterOutput
{
	/**
	* Makes an object safe to display in forms
	*
	* Object parameters that are non-string, array, object or start with underscore
	* will be converted
	*
	* @static
	* @param object An object to be parsed
	* @param int The optional quote style for the htmlspecialchars function
	* @param string|array An optional single field name or array of field names not
	*					 to be parsed (eg, for a textarea)
	* @since 1.5
	*/
	function objectHTMLSafe( &$mixed, $quote_style=ENT_QUOTES, $exclude_keys='' )
	{
		if (is_object( $mixed ))
		{
			foreach (get_object_vars( $mixed ) as $k => $v)
			{
				if (is_array( $v ) || is_object( $v ) || $v == NULL || substr( $k, 1, 1 ) == '_' ) {
					continue;
				}

				if (is_string( $exclude_keys ) && $k == $exclude_keys) {
					continue;
				} else if (is_array( $exclude_keys ) && in_array( $k, $exclude_keys )) {
					continue;
				}

				$mixed->$k = htmlspecialchars( $v, $quote_style, 'UTF-8' );
			}
		}
	}

	/**
	 * This method processes a string and replaces all instances of & with &amp; in links only
	 *
	 * @static
	 * @param	string	$input	String to process
	 * @return	string	Processed string
	 * @since	1.5
	 */
	function linkXHTMLSafe($input)
	{
		$regex = 'href="([^"]*(&(amp;){0})[^"]*)*?"';
		return preg_replace_callback( "#$regex#i", array('PGFilterOutput', '_ampReplaceCallback'), $input );
	}

	/**
	 * This method processes a string and replaces all accented UTF-8 characters by unaccented
	 * ASCII-7 "equivalents", whitespaces are replaced by hyphens and the string is lowercased.
	 *
	 * @static
	 * @param	string	$input	String to process
	 * @return	string	Processed string
	 * @since	1.5
	 */
	/*function stringURLSafe($string)
	{
		//remove any '-' from the string they will be used as concatonater
		$str = str_replace('-', ' ', $string);

		$lang =& JFactory::getLanguage();
		$str = $lang->transliterate($str);

		// remove any duplicate whitespace, and ensure all characters are alphanumeric
		$str = preg_replace(array('/\s+/','/[^A-Za-z0-9\-]/'), array('-',''), $str);

		// lowercase and trim
		$str = trim(strtolower($str));
		return $str;
	}*/
	function stringURLSafe($string)
	{
		$trans = array(
		"đ"=>"d","ă"=>"a","â"=>"a","á"=>"a","à"=>"a","ả"=>"a","ã"=>"a","ạ"=>"a",
		"ấ"=>"a","ầ"=>"a","ẩ"=>"a","ẫ"=>"a","ậ"=>"a",
		"ắ"=>"a","ằ"=>"a","ẳ"=>"a","ẵ"=>"a","ặ"=>"a",
		"é"=>"e","è"=>"e","ẻ"=>"e","ẽ"=>"e","ẹ"=>"e",
		"ế"=>"e","ề"=>"e","ể"=>"e","ễ"=>"e","ệ"=>"e","ê"=>"e",
		"í"=>"i","ì"=>"i","ỉ"=>"i","ĩ"=>"i","ị"=>"i",
		"ú"=>"u","ù"=>"u","ủ"=>"u","ũ"=>"u","ụ"=>"u",
		"ứ"=>"u","ừ"=>"u","ử"=>"u","ữ"=>"u","ự"=>"u","ư"=>"u",
		"ó"=>"o","ò"=>"o","ỏ"=>"o","õ"=>"o","ọ"=>"o",
		"ớ"=>"o","ờ"=>"o","ở"=>"o","ỡ"=>"o","ợ"=>"o","ơ"=>"o",
		"ố"=>"o","ồ"=>"o","ổ"=>"o","ỗ"=>"o","ộ"=>"o","ô"=>"o",
		"ú"=>"u","ù"=>"u","ủ"=>"u","ũ"=>"u","ụ"=>"u",
		"ứ"=>"u","ừ"=>"u","ử"=>"u","ữ"=>"u","ự"=>"u","ư"=>"u",
		"ý"=>"y","ỳ"=>"y","ỷ"=>"y","ỹ"=>"y","ỵ"=>"y",
		"Đ"=>"d","Ă"=>"a","Â"=>"a","Á"=>"a","À"=>"a","Ả"=>"a","Ã"=>"a","Ạ"=>"a",
		"Ấ"=>"a","Ầ"=>"a","Ẩ"=>"a","Ẫ"=>"a","Ậ"=>"a",
		"Ắ"=>"a","Ằ"=>"a","Ẳ"=>"a","Ẵ"=>"a","Ặ"=>"a",
		"É"=>"e","È"=>"e","Ẻ"=>"e","Ẽ"=>"e","Ẹ"=>"e",
		"Ế"=>"e","Ề"=>"e","Ể"=>"e","Ễ"=>"e","Ệ"=>"e","Ê"=>"e",
		"Í"=>"i","Ì"=>"i","Ỉ"=>"i","Ĩ"=>"i","Ị"=>"i",
		"Ú"=>"u","Ù"=>"u","Ủ"=>"u","Ũ"=>"u","Ụ"=>"u",
		"Ứ"=>"u","Ừ"=>"u","Ử"=>"u","Ữ"=>"u","Ự"=>"u","Ư"=>"u",
		"Ó"=>"o","Ò"=>"o","Ỏ"=>"o","Õ"=>"o","Ọ"=>"o",
		"Ớ"=>"o","Ờ"=>"o","Ở"=>"o","Ỡ"=>"o","Ợ"=>"o","Ơ"=>"o",
		"Ố"=>"o","Ồ"=>"o","Ổ"=>"o","Ỗ"=>"o","Ộ"=>"o","Ô"=>"o",
		"Ú"=>"u","Ù"=>"u","Ủ"=>"u","Ũ"=>"u","Ụ"=>"u",
		"Ứ"=>"u","Ừ"=>"u","Ử"=>"u","Ữ"=>"u","Ự"=>"u","Ư"=>"u",
		"Ý"=>"y","Ỳ"=>"y","Ỷ"=>"y","Ỹ"=>"y","Ỵ"=>"y");
		
		//remove any '-' from the string they will be used as concatonater
		$str = str_replace('-', ' ', $string);

		//$lang =& JFactory::getLanguage();
		//$str = $lang->transliterate($str);
		$str = strtr($str, $trans);
		// remove any duplicate whitespace, and ensure all characters are alphanumeric
		$str = preg_replace(array('/\s+/','/[^A-Za-z0-9\-]/'), array('-',''), $str);

		// lowercase and trim
		$str = trim(strtolower($str));
		return $str;
	}
	/**
	* Replaces &amp; with & for xhtml compliance
	*
	* @todo There must be a better way???
	*
	* @static
	* @since 1.5
	*/
	function ampReplace( $text )
	{
		$text = str_replace( '&&', '*--*', $text );
		$text = str_replace( '&#', '*-*', $text );
		$text = str_replace( '&amp;', '&', $text );
		$text = preg_replace( '|&(?![\w]+;)|', '&amp;', $text );
		$text = str_replace( '*-*', '&#', $text );
		$text = str_replace( '*--*', '&&', $text );

		return $text;
	}

	/**
	 * Callback method for replacing & with &amp; in a string
	 *
	 * @static
	 * @param	string	$m	String to process
	 * @return	string	Replaced string
	 * @since	1.5
	 */
	function _ampReplaceCallback( $m )
	{
		 $rx = '&(?!amp;)';
		 return preg_replace( '#'.$rx.'#', '&amp;', $m[0] );
	}

	/**
	* Cleans text of all formating and scripting code
	*/
	function cleanText ( &$text )
	{
		$text = preg_replace( "'<script[^>]*>.*?</script>'si", '', $text );
		$text = preg_replace( '/<a\s+.*?href="([^"]+)"[^>]*>([^<]+)<\/a>/is', '\2 (\1)', $text );
		$text = preg_replace( '/<!--.+?-->/', '', $text );
		$text = preg_replace( '/{.+?}/', '', $text );
		$text = preg_replace( '/&nbsp;/', ' ', $text );
		$text = preg_replace( '/&amp;/', ' ', $text );
		$text = preg_replace( '/&quot;/', ' ', $text );
		$text = strip_tags( $text );
		$text = htmlspecialchars( $text );
		return $text;
	}
}
