//= require jquery
//= require jquery_ujs
//= require_tree .

function in_array(needle, haystack) {
    for (var i in haystack) {
        if (haystack.hasOwnProperty(i)) {
            if (haystack[i] === needle) {
                return true;
            }
        }
    }

    return false;
}