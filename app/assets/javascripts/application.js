//= require jquery
//= require jquery_ujs
//= require_tree .

function in_array(needle, haystack) {
    var found = false;

    for (var i in haystack) {
        if (haystack.hasOwnProperty(i)) {
            if (haystack[i] === needle) {
                found = true;
                break;
            }
        }
        if (found) {
            break;
        }
    }

    return found;
}