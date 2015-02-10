/**
 * Magic for adjective forms
 *
 * Created by maxim on 10.02.15.
 */

$(document).ready(function() {
    $('#adjective-magic').on('click', function() {
        var qualitative = $('#adjective_qualitative').is(':checked');
        var superlative = $('#adjective_superlative').is(':checked');
        var donor       = $('#adjective_nominative_masculine').val();
        var base        = donor.slice(0, -2);
        var penultimate = donor.slice(-2).substr(0, 1);
        var soften;
        if (in_array(base.slice(-1), ['к', 'г', 'ж', 'ш'])) {
            soften = false;
        } else {
            soften = (penultimate === 'и');
        }

        var m = soften ? 'е' : 'о';
        var f = soften ? 'я' : 'а';
        var n = soften ? 'е' : 'о';
        var p = soften ? 'и' : 'ы';
        var i = (penultimate === 'о' ? 'ы' : penultimate);

        var form, ending;
        var endings = {
            'masculine': [donor.slice(-2), m + 'го', m + 'му', m + 'го', i + 'м', m + 'м'],
            'feminine': [f + 'я', m + 'й', m + 'й', (soften ? 'ю' : 'у') + 'ю', m + 'й', m + 'й'],
            'neuter': [n + 'е', n + 'го', n + 'му', n + 'го', i + 'м', n + 'м'],
            'plural': [p + 'е', p + 'х', p + 'м', p + 'х', p + 'ми', p + 'х']
        };

        if (qualitative && !superlative) {
            $('#adjective_comparative').val(base + 'ее');
            $('#adjective_partial').val(base + (soften ? 'е' : 'о'));
        }

        for (form in endings) {
            if (endings.hasOwnProperty(form)) {
                ending = endings[form];
                $('#adjective_nominative_' + form).val(base + ending[0]);
                $('#adjective_genitive_' + form).val(base + ending[1]);
                $('#adjective_dative_' + form).val(base + ending[2]);
                $('#adjective_accusative_' + form).val(base + ending[3]);
                $('#adjective_instrumental_' + form).val(base + ending[4]);
                $('#adjective_prepositional_' + form).val(base + ending[5]);
            }
        }
    });
});