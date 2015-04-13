/**
 * Magic for noun forms
 *
 * Created by maxim on 06.02.15.
 */

$(document).ready(function() {
    $('#noun-magic').on('click', function() {
        var gender = $('#noun_grammatical_gender').val();
        var donor  = $('#noun_nominative').val();

        var animated = $('#noun_animated').is(':checked');
        var ending   = donor.slice(-1);
        var penultimate = donor.slice(-2).substring(0, 1);
        var is_sibilant = in_array(penultimate, ['ж', 'ш', 'щ', 'ч', 'ц']);
        var soften = in_array(penultimate, ['г', 'к', 'ш', 'ж']);

        var root, endings, plurals;

        if (gender === 'masculine') {
            switch (ending) {
                case 'а':
                    soften |= is_sibilant;
                    root    = donor.slice(0, -1);
                    endings = [soften ? 'и' : 'ы', 'е', animated ? 'у' : ending, 'ой', 'е'];
                    plurals = [soften ? 'и' : 'ы', '', 'ам', animated ? '' : (soften ? 'и' : 'ы'), 'ами', 'ах'];
                    break;
                case 'я':
                    root    = donor.slice(0, -1);
                    endings = ['и', 'е', animated ? 'ю' : ending, 'ей', 'е'];
                    plurals = ['и', 'ь', 'ям', animated ? 'ей' : 'и', 'ями', 'ях'];
                    break;
                case 'ь':
                    root    = donor.slice(0, -1);
                    endings = ['я', 'ю', animated ? 'я' : ending, 'ем', 'е'];
                    plurals = ['и', 'ей', 'ям', animated ? 'ей' : 'и', 'ями', 'ях'];
                    break;
                case 'о':
                    root    = donor.slice(0, -1);
                    endings = ['и', 'е', animated ? 'ю' : ending, 'ой', 'е'];
                    plurals = ['и', 'ек', 'ам', animated ? 'ек' : 'и', 'ами', 'ах'];
                    break;
                case 'е':
                    root    = donor.slice(0, -1);
                    soften  = !in_array(root.slice(-1), ['ч', 'щ']);
                    endings = [soften ? 'я' : 'а', soften ? 'ю' : 'у', animated ? 'а' : ending, 'ем', 'е'];
                    plurals = [is_sibilant ? 'и' : 'ы', '', is_sibilant ? 'ям' : 'ам', animated ? 'ей' : (is_sibilant ? 'и' : 'ы'), 'ами', 'ах'];
                    break;
                case 'щ':
                    root    = donor;
                    endings = ['а', 'у', animated ? 'а' : '', 'ом', 'е'];
                    plurals = ['и', 'ей', 'ам', animated ? 'ей' : 'и', 'ами', 'ах'];
                    break;
                case 'й':
                    root    = donor.slice(0, -1);
                    endings = ['я', 'ю', animated ? 'я' : ending, 'ем', 'е'];
                    plurals = ['и', 'ев', 'ям', animated ? 'ев' : 'и', 'ями', 'ях'];
                    break;
                default:
                    if ((ending === 'к') && in_array(penultimate, ['о', 'ё'])) {
                        root = donor.slice(0, -2);
                        if (penultimate === 'ё') {
                            root += 'ь';
                        }
                        endings = ['ка', 'ку', animated ? 'ка' : (penultimate + 'к'), 'ком', 'ке'];
                        plurals = ['ки', 'ков', 'кам', animated ? 'ков' : 'ки', 'ками', 'ках'];
                    } else if (ending === 'н' && penultimate === 'и' && animated) {
                        root = donor.slice(0, -2);
                        endings = ['на', 'ну', 'на', 'ном', 'не'];
                        plurals = ['е', '', 'ам', '', 'ами', 'ах'];
                    } else {
                        soften  = in_array(ending, ['г', 'к']);
                        root    = donor;
                        endings = ['а', 'у', animated ? 'а' : '', 'ом', 'е'];
                        plurals = [soften ? 'и' : 'ы', 'ов', 'ам', animated ? 'ов' : (soften ? 'и' : 'ы'), 'ами', 'ах'];
                    }
                    break;
            }
        } else if (gender === 'feminine') {
            switch (ending) {
                case 'а':
                    root    = donor.slice(0, -1);
                    endings = [soften ? 'и' : 'ы', 'е', 'у', is_sibilant ? 'ей' : 'ой', 'е'];
                    plurals = ['ы', '', 'ам', animated ? '' : 'ы', 'ами', 'ах'];
                    break;
                case 'я':
                    root    = donor.slice(0, -1);
                    endings = ['и', 'е', 'ю', 'ей', 'е'];
                    plurals = ['и', 'ь', 'ям', animated ? 'ь' : 'и', 'ями', 'ях'];
                    break;
                case 'ь':
                    soften  = !in_array(penultimate, ['ж', 'ш', 'щ', 'ч']);
                    root    = donor.slice(0, -1);
                    endings = ['и', 'и', ending, ending + 'ю', 'и'];
                    plurals = ['и', 'ей', soften ? 'ям' : 'ам', animated ? 'ей' : 'и', soften ? 'ями' : 'ами', soften ? 'ях' : 'ах'];
                    break;
                default:
                    root    = donor;
                    endings = ['', '', '', '', ''];
                    plurals = ['', '', '', animated ? '' : '', '', ''];
                    break;
            }
        } else if (gender === 'neuter') {
            switch (ending) {
                case 'о':
                    root = donor.slice(0, -1);
                    endings = ['а', 'у', ending, 'ом', 'е'];
                    plurals = ['а', '', 'ам', animated ? '' : 'а', 'ами', 'ах'];
                    break;
                case 'е':
                    root    = donor.slice(0, -1);
                    soften  = !in_array(penultimate, ['ч', 'щ', 'ж', 'ш']);
                    endings = [soften ? 'я' : 'а', soften ? 'ю' : 'у', ending, 'ем', 'е'];
                    if (penultimate === 'и') {
                        endings[5] = 'и';
                        plurals    = ['я', 'й', 'ям', animated ? 'й' : 'я', 'ями', 'ях'];
                    } else {
                        plurals = [soften ? 'я' : 'а', 'ей', soften ? 'ям' : 'ам', animated ? 'ей' : (soften ? 'я' : 'а'), soften ? 'ями' : 'ами', soften ? 'ях' : 'ах'];
                    }
                    break;
                case 'я':
                    root    = donor.slice(0, -1);
                    endings = ['ени', 'еню', 'я', 'енем', 'ени'];
                    plurals = ['ена', 'ян', 'енам', animated ? 'ян' : 'ена', 'енами', 'енах'];
                    break;
                default:
                    root = donor;
                    endings = ['', '', '', '', ''];
                    plurals = ['', '', '', animated ? '' : '', '', ''];
                    break;
            }
        } else {
            root    = donor;
            endings = ['', '', '', '', ''];
            plurals = ['', '', '', '', '', ''];
        }

        $('#noun_genitive').val(root + endings[0]);
        $('#noun_partitive').val(root + endings[0]);
        $('#noun_dative').val(root + endings[1]);
        $('#noun_accusative').val(root + endings[2]);
        $('#noun_instrumental').val(root + endings[3]);
        $('#noun_prepositional').val(root + endings[4]);
        $('#noun_locative').val(root + endings[4]);

        $('#noun_plural_nominative').val(root + plurals[0]);
        $('#noun_plural_genitive').val(root + plurals[1]);
        $('#noun_plural_partitive').val(root + plurals[1]);
        $('#noun_plural_dative').val(root + plurals[2]);
        $('#noun_plural_accusative').val(root + plurals[3]);
        $('#noun_plural_instrumental').val(root + plurals[4]);
        $('#noun_plural_prepositional').val(root + plurals[5]);
        $('#noun_plural_locative').val(root + plurals[5]);
    });
});
