/**
 * Magic for noun forms
 *
 * Created by maxim on 06.02.15.
 */

$(document).ready(function() {
    $('#noun-magic-singular').on('click', function() {
        var gender = $('#noun_grammatical_gender').val();
        var donor  = $('#noun_nominative').val();

        var animated = $('#noun_animated').is(':checked');
        var ending   = donor.slice(-1);
        var penultimate = donor.slice(-2).substring(0, 1);
        var soften = in_array(penultimate, ['г', 'к']);

        var genitive      = $('#noun_genitive');
        var dative        = $('#noun_dative');
        var accusative    = $('#noun_accusative');
        var instrumental  = $('#noun_instrumental');
        var prepositional = $('#noun_prepositional');

        var root, endings;

        if (gender === 'masculine') {
            switch (ending) {
                case 'а':
                    root   = donor.slice(0, -1);
                    endings = [soften ? 'и' : 'ы', 'е', animated ? 'у' : ending, 'ой', 'е'];
                    break;
                case 'я':
                    root   = donor.slice(0, -1);
                    endings = ['и', 'е', animated ? 'ю' : ending, 'ей', 'е'];
                    break;
                case 'ь':
                    root   = donor.slice(0, -1);
                    endings = ['я', 'ю', animated ? 'я' : ending, 'ем', 'е'];
                    break;
                default:
                    root   = donor;
                    endings = ['а', 'у', animated ? 'а' : '', 'ом', 'е'];
                    break;
            }
        } else if (gender === 'feminine') {
            switch (ending) {
                case 'а':
                    root    = donor.slice(0, -1);
                    endings = [soften ? 'и' : 'ы', 'е', 'у', 'ой', 'е'];
                    break;
                case 'я':
                    root    = donor.slice(0, -1);
                    endings = ['и', 'е', 'ю', 'ей', 'е'];
                    break;
                case 'ь':
                    root   = donor.slice(0, -1);
                    endings = ['и', 'и', ending, ending + 'ю', 'и'];
                    break;
                default:
                    root   = donor;
                    endings = ['', '', '', '', ''];
                    break;
            }
        } else if (gender === 'neuter') {
            root = donor.slice(0, -1);
            endings = ['а', 'у', ending, 'ом', 'е']
        } else {
            root = donor;
            endings = ['', '', '', '', ''];
        }

        genitive.val(root + endings[0]);
        dative.val(root + endings[1]);
        accusative.val(root + endings[2]);
        instrumental.val(root + endings[3]);
        prepositional.val(root + endings[4]);
    });

    $('#noun-magic-pluralize').on('click', function() {
        var gender = $('#noun_grammatical_gender').val();
        var donor  = $('#noun_nominative').val();
        var acceptor = $('#noun_plural_nominative');
        var plural = '';
        var ending = donor.slice(-1);
        var penultimate = donor.slice(-2).substring(0, 1);
        var soften;

        switch (gender) {
            case 'masculine':
                soften = in_array(ending, ['г', 'к', 'ь']);
                plural = donor + (soften ? 'и' : 'ы');
                break;
            case 'feminine':
                soften = in_array(penultimate, ['г', 'к']) || (ending === 'ь');
                plural = donor.slice(0, -1) + (soften ? 'и' : 'ы');
                break;
            case 'neuter':
                plural = donor.slice(0, -1) + 'а';
                break;
            default:
                plural = donor;
                break;
        }

        acceptor.val(plural);
    });

    $('#noun-magic-plural').on('click', function() {
        var donor = $('#noun_plural_nominative').val();
        var animated = $('#noun_animated').is(':checked');

        var genitive      = $('#noun_plural_genitive');
        var dative        = $('#noun_plural_dative');
        var accusative    = $('#noun_plural_accusative');
        var instrumental  = $('#noun_plural_instrumental');
        var prepositional = $('#noun_plural_prepositional');

        var root   = donor.slice(0, -1);
        var ending = donor.slice(-1);

        var endings = ['ов', 'ам', animated ? 'ов' : ending, 'ами', 'ах'];

        genitive.val(root + endings[0]);
        dative.val(root + endings[1]);
        accusative.val(root + endings[2]);
        instrumental.val(root + endings[3]);
        prepositional.val(root + endings[4]);
    });
});